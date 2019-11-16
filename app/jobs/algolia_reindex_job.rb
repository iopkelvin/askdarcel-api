# frozen_string_literal: true

# Background job to reindex all relevant database records in Algolia.
#
# Usage:
#
# To send job to a background worker to execute:
#
# > AlgoliaReindexJob.perform_async
#
# To execute in-line immediately from Rails console:
#
# > AlgoliaReindexJob.new.perform
#
class AlgoliaReindexJob
  def perform
    Resource.where(status: :approved).reindex
    # Since Service and Resource share an algolia index, we use `reindex!` so
    # Service reindexing does not clear out Resource index records.
    Service.where(status: :approved).reindex!

    # Batch synonyms, with replica forwarding and atomic replacement of existing synonyms
    forward_to_replicas = true
    replace_existing_synonyms = true

    Synonym.inheritance_column = :_type_disabled # to avoid getting error when using the type column: "ActiveRecord::SubclassNotFound: The single-table inheritance mechanism failed to locate the subclass: 'synonym'"
    synonyms_list = []
    Synonym.all.each do |e|
      synonyms_list.push({objectID: e.objectID, type: e.type, synonyms: e.synonyms})
    end
    Synonym.inheritance_column = :type # switch on the Rails STI after you've made your updates to the DB columns

    Resource.index.batch_synonyms(synonyms_list, forward_to_replicas, replace_existing_synonyms)
  end
end

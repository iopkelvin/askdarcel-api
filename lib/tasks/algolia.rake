# frozen_string_literal: true

require 'json'

namespace :algolia do
  task reindex: :environment do
    puts '[algolia:reindex] Reindexing resource/service index...'
    AlgoliaReindexJob.new.perform
    puts '[algolia:reindex] Success.'
  end

  task incremental_index: :environment do
    puts '[algolia:incremental_index] Indexing recent updates to resources/services...'
    AlgoliaIncrementalIndexJob.new.perform
    puts '[algolia:incremental_index] Success.'
  end

  task refresh_synonyms: :environment do
    puts '[algolia:refresh_synonyms] Uploading synonyms...'

    # Batch synonyms, with replica forwarding and atomic replacement of existing synonyms
    forward_to_replicas = true
    replace_existing_synonyms = true

    algolia_synonyms_json = File.join(File.dirname(__FILE__), 'algolia-synonyms.json')
    synonyms = File.open(algolia_synonyms_json) do |f|
      JSON.parse(f.read)
    end

    Resource.index.batch_synonyms(synonyms, forward_to_replicas, replace_existing_synonyms)
    puts '[algolia:refresh_synonyms] Success.'
  end
end

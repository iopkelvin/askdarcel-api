# frozen_string_literal: true

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
end

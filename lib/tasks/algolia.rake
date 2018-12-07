# frozen_string_literal: true

namespace :algolia do
  task reindex: :environment do
    print "Reindexing resource/service index... "
    Resource.where(status: :approved).reindex
    Service.where(status: :approved).reindex!
    puts "success."
  end
end

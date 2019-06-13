# frozen_string_literal: true

# Represents the `bookmarks` table. If a cronjob or some other system is
# scanning through a database table and needs to save its current place, it can
# save a bookmark to allow it to pick up again where it left off.
#
# For example, the Algolia incremental indexing cronjob might run periodically
# to index all Resources that have been updated since the last time it ran. The
# cronjob can simply do something like this:
#
#   bookmark = Bookmark.where(identifier: 'algolia-index-resources').take
#   prev_updated_at = bookmark.date_value
#   resources_to_index = Resource.where('updated_at > ?', prev_updated_at)
#   ...
#   bookmark.update(date_value: new_updated_at)
#
# Bookmarks have a date_value column and an id_value column which can be used
# to store data needed to keep your place in a scan.
class Bookmark < ActiveRecord::Base
end

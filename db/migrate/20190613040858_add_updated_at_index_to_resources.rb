# Add index on updated_at datetime to resources. This allows us to walk through
# recent updates efficiently, which is particularly useful for performing
# incremental Algolia indexing.
#
# We index on both `updated_at` and `id` to make efficient pagination possible
# even if a large number of records have exactly the same `updated_at` value.
class AddUpdatedAtIndexToResources < ActiveRecord::Migration[5.0]
  def change
    add_index :resources, %i[updated_at id]
  end
end

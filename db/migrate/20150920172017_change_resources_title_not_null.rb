class ChangeResourcesTitleNotNull < ActiveRecord::Migration
  def change
    change_column_null :resources, :title, false
  end
end

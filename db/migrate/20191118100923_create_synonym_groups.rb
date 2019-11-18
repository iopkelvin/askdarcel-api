class CreateSynonymGroups < ActiveRecord::Migration[5.2]
  def up
    create_table :synonym_groups do |t|
      t.timestamps
    end
    execute <<-SQL
      CREATE TYPE group_type AS ENUM ('synonym', 'oneWaySynonym', 'altCorrection1', 'altCorrection2', 'placeholder');
    SQL
    add_column :synonym_groups, :group_type, :group_type
    add_index :synonym_groups, :group_type
  end

  def down
    drop_table :synonym_groups
    execute <<-SQL
      DROP TYPE group_type;
    SQL
  end
end

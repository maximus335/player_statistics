class CreateCommands < ActiveRecord::Migration[5.2]
  def change
    create_table :commands do |t|
      t.string :name, null: false
    end

    reversible do |direction|
      direction.up { execute <<-SQL }
        CREATE EXTENSION pg_trgm;
        CREATE INDEX trgm_command_name_index ON commands USING GIN (name gin_trgm_ops);
      SQL

      direction.down { execute <<-SQL }
        DROP INDEX trgm_command_name_index;
        DROP EXTENSION pg_trgm;
      SQL
    end
  end
end

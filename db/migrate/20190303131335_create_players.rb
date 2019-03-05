class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.belongs_to :command,
                   type: :bigint,
                   null: false,
                   foreign_key: { to_table: :commands },
                   index: true
    end

    reversible do |direction|
      direction.up { execute <<-SQL }
        CREATE INDEX trgm_player_name_index ON commands USING GIN (name gin_trgm_ops);
      SQL

      direction.down { execute <<-SQL }
        DROP INDEX trgm_player_name_index;
      SQL
    end
  end
end

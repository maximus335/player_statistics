class CreatePerformances < ActiveRecord::Migration[5.2]
  def change
    reversible do |direction|
      direction.up { execute <<-SQL }
        CREATE TYPE per_type AS ENUM ('run', 'transfer');
      SQL

      direction.down { execute <<-SQL }
        DROP TYPE per_type;
      SQL
    end

    create_table :performances do |t|
      t.column :per_type, :per_type, null: false
      t.belongs_to :player,
                   type: :bigint,
                   null: false,
                   foreign_key: { to_table: :players },
                   index: true
      t.belongs_to :game,
                   type: :bigint,
                   null: false,
                   foreign_key: { to_table: :games },
                   index: true
    end

    add_index :performances,
              %i[player_id game_id per_type],
              unique: true,
              name: 'index_performances_player_id_game_id_per_type'
  end
end

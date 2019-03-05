class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.boolean :ended, null: false, default: false
      t.datetime :created_at, null: false
      t.belongs_to :first_command,
                   type: :bigint,
                   null: false,
                   foreign_key: { to_table: :commands },
                   index: true
      t.belongs_to :second_command,
                   type: :bigint,
                   null: false,
                   foreign_key: { to_table: :commands },
                   index: true
    end
    add_index :games,
              [:first_command_id, :second_command_id],
              unique: true,
              where: 'ended = false',
              name: 'index_games_commands_unique'
  end
end

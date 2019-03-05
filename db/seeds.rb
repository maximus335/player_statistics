# frozen_string_literal: true

require_relative '../lib/application.rb'

COMMAND_NAMES = %w[Alfa Betta].freeze

COMMAND_NAMES.each do |name|
  command = Command.create(name: name)
  n = 1
  6.times do
    Player.create(name: "#{name}_player_#{n}", command_id: command.id)
    n += 1
  end
end

command_players = Command.all.map { |c| [c.id, c.player_ids] }

10.times do
  game = Game.create(first_command_id: command_players[0][0],
                     second_command_id: command_players[1][0],
                     ended: true)
  game.run_performance_player_ids += command_players[0][1].sample(3)
  game.run_performance_player_ids += command_players[1][1].sample(3)
  game.transfer_performance_player_ids += command_players[1][1].sample(1)
  game.transfer_performance_player_ids += command_players[0][1].sample(1)
end

Game.create(first_command_id: command_players[0][0],
            second_command_id: command_players[1][0])

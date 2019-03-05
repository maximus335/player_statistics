# frozen_string_literal: true

module PlayerStatistics
  module Actions
    module Players
      class AddPerformance

        # SQL query string
        SQL_QUERY = <<~SQL
          SELECT players.id, games.id AS game_id FROM players
            JOIN commands ON (players.command_id = commands.id)
              JOIN games
                ON (games.first_command_id = commands.id
                      OR games.second_command_id = commands.id)
          WHERE games.ended = false AND players.id = ?
        SQL


        def self.call(args)
          new.add_performance(args)
        end

        # Notes that a player has performed an indicator in a match
        def add_performance(args)
          player = Player.find_by_sql([SQL_QUERY, args[0]]).first
          case player
          when nil
            puts 'The player does not exist or doesn\'t play in the current game'
          else
            create_performance(player, args[1])
          end
        rescue => e
          puts "ERROR: #{e.class}: #{e.message}"
        end

        private

        def create_performance(player, performance)
          Performance
              .create!(player_id: player.id,
                game_id: player.game_id, per_type: performance)
          puts 'Performance successfully added'
        rescue ActiveRecord::RecordNotUnique
          puts 'The player has achieved performance'
        end
      end
    end
  end
end

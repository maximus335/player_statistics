# frozen_string_literal: true

module PlayerStatistics
  module Actions
    module Players
      class CheckPerformance

        # SQL query string
        SQL_QUERY = <<~SQL
          SELECT g.id
          FROM (
            SELECT g.id, pl.id AS player_id FROM games g
              JOIN commands c ON (c.id = g.first_command_id OR c.id = g.second_command_id)
                JOIN players pl ON (pl.command_id = c.id AND pl.id = ?)
            ORDER BY g.created_at DESC LIMIT 5
          ) g
            JOIN performances p
              ON (p.game_id = g.id AND p.player_id = g.player_id AND p.per_type = ?)
        SQL

        def self.call(args)
          new.check(args)
        end

        # Checks if a player has completed a specific indicator
        # at least once in the previous 5 matches of the team
        def check(args)
          check_player!(args[0])
          result =
            Player.find_by_sql([SQL_QUERY, args[0], args[1]]).first
          if result
            puts 'The player has achieved performance'
          else
            puts 'The player has not achieved performance'
          end
        rescue => e
          puts "ERROR: #{e.class}: #{e.message}"
        end

        private

        def check_player!(id)
          Player.find(id)
        end
      end
    end
  end
end

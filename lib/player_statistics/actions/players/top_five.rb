# frozen_string_literal: true

module PlayerStatistics
  module Actions
    module Players
      class TopFive
        def self.call(args)
          new.top_five(args)
        end

        # top 5 players for a specific indicator in a particular team
        # and for all teams in general
        def top_five(args)
          puts args[0]
          puts args[1]
          top = Player
                .select('players.id, players.name')
                .joins(:performances)
                .where('performances.per_type = ?', args[0])
                .where(command_condition(args[1]))
                .group('players.id, players.name')
                .order('COUNT(performances.id) DESC')
                .limit(5)
          puts prepare_answer(top)
        rescue => e
          puts "ERROR: #{e.class}: #{e.message}"
        end

        private

        def command_condition(command_id)
          case command_id
          when nil
            []
          else
            ['players.command_id = ?', command_id]
          end
        end

        def prepare_answer(top)
          top.reduce('') do |memo, player|
            memo + "1. #{player.name} \n"
          end
        end
      end
    end
  end
end

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
          return [] unless command_id
          ['players.command_id = ?', command_id]
        end

        def prepare_answer(top)
          top.each_with_index.reduce('') do |memo, (player, i)|
            memo + "#{i + 1}. #{player.name} \n"
          end
        end
      end
    end
  end
end

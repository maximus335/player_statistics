# frozen_string_literal: true

require_relative '../config/app_init.rb'

Dir["#{File.expand_path(__dir__)}/player_statistics/**/*.rb"]
  .sort
  .each(&method(:require))

class Application
  MODULES = PlayerStatistics::Actions::Players

  ACTIONS = {
    'add_performance'   => MODULES::AddPerformance,
    'check_performance' => MODULES::CheckPerformance,
    'top_five'          => MODULES::TopFive
  }.freeze

  def self.run(action, *params)
    new.run(action, params)
  end

  def run(action, params)
    if ACTIONS[action]
      ACTIONS[action].call(params)
    else
      puts 'Uknow action'
    end
  end
end

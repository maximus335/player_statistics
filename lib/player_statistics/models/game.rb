# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :first_command,
             class_name: 'Command',
             foreign_key: 'first_command_id'
  belongs_to :second_command,
             class_name: 'Command',
             foreign_key: 'second_command_id'

  has_many :performances

  has_many :run_performances, -> { where(per_type: 'run') },
           class_name: 'Performance'

  has_many :transfer_performances, -> { where(per_type: 'transfer') },
           class_name: 'Performance'

  has_many :run_performance_players,
           through: :run_performances,
           class_name: 'Player',
           source: :player

  has_many :transfer_performance_players,
           through: :transfer_performances,
           class_name: 'Player',
           source: :player
end

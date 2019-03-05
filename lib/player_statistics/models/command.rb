# frozen_string_literal: true

class Command < ApplicationRecord
  has_many :games, ->(command) {
    unscope(:where)
      .where(
        [
          'first_command_id = ? OR second_command_id = ?',
          command.id,
          command.id
        ]
      )
  }

  has_many :players
end

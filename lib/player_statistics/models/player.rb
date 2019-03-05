# frozen_string_literal: true

class Player < ApplicationRecord
  belongs_to :command

  has_many :performances

  has_many :run_performances, -> { where(per_type: 'run') },
           class_name: 'Performance'

  has_many :transfer_performances, -> { where(per_type: 'transfer') },
           class_name: 'Performance'
end

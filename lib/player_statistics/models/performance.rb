# frozen_string_literal: true

class Performance < ApplicationRecord
  belongs_to :player
  belongs_to :game
end

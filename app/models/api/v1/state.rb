module Api::V1
  class State < ApplicationRecord
    has_one :bug, dependent: :destroy
    validates :devise, :os, :memory, :storage, presence: true

  end
end

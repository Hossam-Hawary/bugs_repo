class State < ApplicationRecord
  has_one :bug
  validates :devise, :os, :memory, :storage, :presence: true

end

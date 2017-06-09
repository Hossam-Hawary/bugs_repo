class Bug < ApplicationRecord
  belongs_to :state
  enum priority: { minor: 1, major: 2, critical: 3 }
  enum status: { new: 1, in_progress: 2, closed: 3 }
end

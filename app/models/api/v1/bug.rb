module Api::V1

  class Bug < ApplicationRecord
    belongs_to :state, dependent: :destroy
    validates :token, presence: true
    enum priority: { minor: 1, major: 2, critical: 3 }
    enum status: { 'new_bug': 1, 'in_progress': 2, 'closed': 3 }

    def self.generate_new_bug(bug_params, state_params)
      state = Api::V1::State.new(state_params)
      if state.valid?
        bug = Api::V1::Bug.new(bug_params)
        bug.state = state
        if bug.valid?
           state.save && bug.save
           return bug
        end
      end
      return false
    end

    def self.app_bugs(token)
      Api::V1::Bug.where(token:token)
    end

    def as_json
      {
        'token' => token,
        'number' => number,
        'status' => status,
        'priority' => priority
      }
    end


  end
end

module Api::V1

  class Bug < ApplicationRecord

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    belongs_to :state, dependent: :destroy
    validates :token, presence: true
    enum priority: { minor: 1, major: 2, critical: 3 }
    enum status: { 'new_bug': 1, 'in_progress': 2, 'closed': 3 }

    def self.generate_new_bug(bug_params, state_params)
        state = Api::V1::State.new(state_params)
        bug = Api::V1::Bug.new(bug_params)
        bug.state = state
        if state.valid? && bug.valid? && state.save && bug.save
           return bug
        end
       false
    end

    def self.app_bugs(token)
      Api::V1::Bug.where(token:token)
    end

    def bug_as_json
      {
        'token' => token,
        'number' => number,
        'status' => status,
        'priority' => priority,
        'comment' => comment
      }
    end

    def as_indexed_json(options = nil)
      self.as_json({
        only: [:number, :status, :priority, :comment ]
      })
    end


    def self.search_by_field(query, *fields)
      __elasticsearch__.search(
        {
          query: {
            multi_match: {
              query: query,
              fields: [] + fields
            }
          }
        }
      )
end

    settings index: { number_of_shards: 1 } do
      mappings dynamic: 'false' do
        indexes :comment, analyzer: 'english'
        indexes :number, type: :integer
        indexes :status, type: :integer
        indexes :priority, type: :integer
      end
    end


  end
  Bug.__elasticsearch__.create_index!
  Bug.import
end

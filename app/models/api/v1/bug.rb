module Api::V1

  class Bug < ApplicationRecord

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    belongs_to :state, dependent: :destroy
    validates :token, presence: true
    enum priority: [ :minor, :major, :critical ]
    enum status: [ :new_bug, :in_progress, :closed ]

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
        only: [:number, :status, :priority, :comment, :token ]
      })
    end


    def self.search_by_field(token, query, field)
      __elasticsearch__.search(
        {
          query: {
            bool: {
              must: { match: { field => query }},
              filter: {
                term: { token: token }
              }
            }
          }
        }
      )
end
    bug_es_settings = {
      index: {
        analysis: {
          filter: {
            comment_filter: {
              type: :edge_ngram,
              min_gram: 1,
              max_gram: 4
            }
          },
          analyzer:{
            partial_comment: {
              type: :custom,
              tokenizer: :standard,
              filter: [:lowercase, :comment_filter]
            }
          }
        }
      }
    }

    settings bug_es_settings do
      mappings dynamic: 'false' do
        indexes :comment, analyzer: :partial_comment
        indexes :number, type: :integer
        indexes :status, type: :keyword
        indexes :priority, type: :keyword
        indexes :token, type: :keyword
      end
    end

    def self.indexing_bugs
      begin
        Bug.__elasticsearch__.import force: true
        rescue Faraday::ConnectionFailed
          puts "Connection to __elasticsearch__ failed..... please try again"
      end
    end

  end
  Bug.indexing_bugs
end

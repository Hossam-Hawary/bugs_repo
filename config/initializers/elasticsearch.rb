config = {
  host: ENV.fetch('ELASTICSEARCH_HOST', 'localhost'),
  transport_options: {
    request: { timeout: 5.minutes }
  },
}

# if File.exists?("config/elasticsearch.yml")
#   config.merge!(YAML.load_file("config/elasticsearch.yml").symbolize_keys)
# end

Elasticsearch::Model.client = Elasticsearch::Client.new(config)

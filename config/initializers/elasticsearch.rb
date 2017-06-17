config = {
  host: ENV.fetch('ELASTICSEARCH_HOST', 'localhost'),
  port:9400,
  transport_options: {
    request: { timeout: 2.minutes }
  },
}

# if File.exists?("config/elasticsearch.yml")
#   config.merge!(YAML.load_file("config/elasticsearch.yml").symbolize_keys)
# end

Elasticsearch::Model.client = Elasticsearch::Client.new(config)

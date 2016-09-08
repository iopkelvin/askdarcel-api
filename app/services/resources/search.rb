module Resources
  class Search
    SEARCH_CONFIG = 'english'.freeze

    # SEARCH_COLUMNS maps table names to an array of the columns in
    # that table to search.
    SEARCH_COLUMNS = {
      resources: %i(
        name
        short_description
        long_description
        website
      ).freeze,
      services: :long_description,
      notes: :note,
      categories: :name
    }.freeze

    CLAUSE = SEARCH_COLUMNS.map do |t, cols|
      Array.wrap(cols).map do |c|
        "to_tsvector('#{SEARCH_CONFIG}', coalesce(#{t}.#{c}, ''))"
      end
    end.flatten.join('||').freeze

    def self.perform(query, sort, scope: Resource)
      sort = 'resources.name' unless sort

      scope
        .joins('LEFT JOIN services ON services.resource_id = resources.id')
        .joins('LEFT JOIN notes ON notes.resource_id = resources.id')
        .joins('LEFT JOIN categories_resources ON categories_resources.resource_id = resources.id')
        .joins('LEFT JOIN categories ON categories.id = categories_resources.category_id')
        .joins('LEFT JOIN addresses ON addresses.resource_id = resources.id')
        .where("#{CLAUSE} @@ plainto_tsquery('#{SEARCH_CONFIG}', ?)", query)
        .group('resources.id, addresses.latitude, addresses.longitude')
        .order(sort)
    end
  end
end

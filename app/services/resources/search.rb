module Resources
  class Search
    SEARCH_COLUMNS = %i(
      name
      short_description
      long_description
      website
    ).freeze

    CLAUSE = SEARCH_COLUMNS.map do |c|
      "to_tsvector(coalesce(#{c}, ''))"
    end.join('||').freeze

    def self.perform(query, scope: Resource)
      scope.where "#{CLAUSE} @@ plainto_tsquery(?)", query
    end
  end
end

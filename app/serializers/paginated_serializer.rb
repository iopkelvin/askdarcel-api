class PaginatedSerializer < ActiveModel::Serializer::ArraySerializer
  def initialize(object, options = {})
    meta_key = options[:meta_key] || :meta

    url = URI(options[:context].url)
    params = Rack::Utils.parse_query(url.query)

    self_url = url.clone.tap do |_u|
      url.query = Rack::Utils.build_query(params)
    end

    prev_url = if object.prev_page
                 url.clone.tap do |u|
                   u.query = Rack::Utils.build_query(params.merge('page' => object.prev_page))
                 end
               end

    next_url = if object.next_page
                 url.clone.tap do |u|
                   u.query = Rack::Utils.build_query(params.merge('page' => object.next_page))
                 end
               end

    options[meta_key] ||= {}
    options[meta_key] = {
      current_page: object.current_page,
      next_page: object.next_page,
      prev_page: object.prev_page,

      self: self_url.to_s,
      next_url: next_url.to_s,
      prev_url: prev_url.to_s,

      total_pages: object.total_pages,
      total_count: object.total_count
    }
    super(object, options)
  end
end

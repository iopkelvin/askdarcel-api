module Errors
  class BlankHeader < StandardError
    attr_reader :header

    def initialize(header)
      @header = header
    end

    def to_s
      "#{header} is empty or missing"
    end
  end
end

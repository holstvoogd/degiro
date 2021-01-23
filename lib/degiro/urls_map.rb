require_relative 'errors.rb'

module DeGiro
  class UrlsMap
    URL_NAMES = [
      'paUrl',
      'productSearchUrl',
      'productTypesUrl',
      'reportingUrl',
      'tradingUrl',
      'vwdQuotecastServiceUrl'
    ].freeze

    def initialize(data)
      data = data['data'] if data.key?('data')
      @map = URL_NAMES.each_with_object({}) do |url_name, acc|
        raise MissingUrlError, "Could not find url '#{url_name}'" unless data.key?(url_name)
        acc[url_name.gsub(/(.)([A-Z])/, '\1_\2').downcase] = data[url_name]
      end
    end

    def [](url_name)
      raise IncorrectUrlError, "Could not find url '#{url_name}'" unless @map.key?(url_name)
      @map[url_name]
    end
  end
end

require 'csv'
require 'monetize'

module DeGiro
  class GetPosition
    def initialize(connection)
      Money.default_currency = 'EUR'
      Money.locale_backend = nil
      Money.rounding_mode = BigDecimal::ROUND_HALF_EVEN
      @connection = connection
    end

    def get_position(date = Date.today)
      parse_position(@connection.get(url(toDate: date.strftime('%d/%m/%Y'))))
    end

    private

    def parse_position(response)
      CSV.parse(response.body, headers: :first_row).map do |row|
        # Headers are localized, not useful for parsing
        Hash[%i[product isin size value total local_total].zip(row.fields)].tap do |data|
          data[:type] = if data[:isin].nil?
                          :cash
                        elsif data[:product].match?(/TCIOPEN/)
                          :cfd
                        else
                          :stock
                        end
          data[:total] = Monetize.parse(data[:total])
          data[:local_total] = Monetize.parse(data[:local_total])

          if data[:type] == :cash
            %i[isin size value].each { |k| data.delete k }
          else
            data[:size] = data[:size].to_i
            data[:value] = Monetize.parse(data[:value], data[:total].currency)
            data[:local_value] = data[:local_total]/data[:size]
          end
        end
      end
    end

    def url(params)
      params.merge!(
        intAccount: @connection.user_data['int_account'],
        sessionId: @connection.session_id
      )
      params = URI.encode_www_form(params)
      "#{@connection.urls_map['reporting_url']}/v3/positionReport/csv?#{params}"
    end
  end
end

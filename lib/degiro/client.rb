require 'forwardable'

require_relative 'connection.rb'
require_relative 'create_order.rb'
require_relative 'find_product_by_id.rb'
require_relative 'find_products.rb'
require_relative 'get_cash_funds.rb'
require_relative 'get_orders.rb'
require_relative 'get_portfolio.rb'
require_relative 'get_position.rb'
require_relative 'get_transactions.rb'

module DeGiro
  class Client
    extend Forwardable

    def_delegators :@create_order,       :create_market_buy_order
    def_delegators :@create_order,       :create_market_sell_order
    def_delegators :@create_order,       :create_limit_buy_order
    def_delegators :@create_order,       :create_limit_sell_order
    def_delegators :@find_product_by_id, :find_product_by_id
    def_delegators :@find_products,      :find_products
    def_delegators :@get_cash_funds,     :get_cash_funds
    def_delegators :@get_orders,         :get_orders
    def_delegators :@get_portfolio,      :get_portfolio
    def_delegators :@get_position,       :get_position
    def_delegators :@get_transactions,   :get_transactions

    def initialize(login:, password:)
      connection = Connection.new(login, password)

      @create_order       = CreateOrder.new(connection)
      @find_product_by_id = FindProductById.new(connection)
      @find_products      = FindProducts.new(connection)
      @get_cash_funds     = GetCashFunds.new(connection)
      @get_orders         = GetOrders.new(connection)
      @get_portfolio      = GetPortfolio.new(connection)
      @get_position       = GetPosition.new(connection)
      @get_transactions   = GetTransactions.new(connection)
    end
  end
end

module MoneyExtensions
  
  class ::Money
    def self.new money, *params
      super money * 100, *params
    end

    def with_symbol
      "#{self.currency.symbol}#{self.to_s}"
    end

    def self.one_thousand
      Rails.env.production? ? 1000 : 100
    end
  end

end
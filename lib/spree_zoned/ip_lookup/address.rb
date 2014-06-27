# Implements the interface that Spree::Zone uses in match(address).
module SpreeZoned::IpLookup
  class Address
    attr_accessor :country_id
    attr_accessor :state_id

    def initialize(country_id)
      @country_id = country_id
      # We don't use state but Spree::Zone needs it on the object.
      @state_id = nil
    end
  end
end

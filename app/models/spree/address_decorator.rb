Spree::Address.class_eval do
  before_validation :state_must_match_country_invariant

  # The state field must be cleared when the country
  # is changed to a country without states.
  # The checkout pages don't update the state field when
  # the country is switched from a country with states
  # to one without. This is especially a problem when
  # using the address to match a zone; the zone logic
  # checks both parts of the address, state and country,
  # leading to a non-deterministic result.
  def state_must_match_country_invariant
    if state && country && country.states_required == false
      update_attribute(:state_id, nil)
    end
  end

  # Override to set the active country for the default address
  # Returns an address with the country set to either; the active country;
  # the first country for the active zone or the default zone.
  def self.build_default
    country = SpreeZoned::ActiveCountry::Session.current.get
    if country == nil
      zone = SpreeZoned::ActiveZone::Session.current.get_or_default
      country = (zone && zone.country_list.first)
    end

    return new(country: country)
  end
end

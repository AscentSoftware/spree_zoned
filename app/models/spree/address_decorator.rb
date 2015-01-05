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
end

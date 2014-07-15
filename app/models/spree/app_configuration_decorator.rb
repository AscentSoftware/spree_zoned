Spree::AppConfiguration.class_eval do
  def preferred_currency
    z = Spree::Zone.default
    if z
      return z.currency
    end

    return original_currency_preference
  end

  # Returns the actual currency preference.
  def original_currency_preference
    preferences.fetch(:currency) do
      preference_default(:currency)
    end
  end
end

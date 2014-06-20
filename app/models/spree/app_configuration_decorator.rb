Spree::AppConfiguration.class_eval do
  def preferred_currency
    return Spree::Zone.default_currency
  end

  # Returns the actual currency preference.
  def original_currency_preference
    preferences.fetch(:currency) do
      preference_default(:currency)
    end
  end
end

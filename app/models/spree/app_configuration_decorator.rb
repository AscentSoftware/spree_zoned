Spree::AppConfiguration.class_eval do
  def preferred_currency
    return Spree::Zone.default_currency
  end

  # Returns the actual currency preference.
  def default_currency
    preferences.fetch(:currency) do
      preference_default(:currency)
    end
  end

  # Used to set the actual currency preference.
  def default_currency=(iso_code)
    set_preference(:currency, iso_code)
  end
end

Spree::Admin::GeneralSettingsController.class_eval do
  alias_method :update_orig, :update

  def update
    params.each do |name, value|
      next unless SpreeZoned::Config.has_preference? name
      SpreeZoned::Config[name] = value
    end

    update_orig
  end
end

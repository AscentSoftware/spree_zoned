module Spree
  class ActiveZoneController < Spree::StoreController
    def set
      zone_id = params[:zone]

      if current_order
        zone = current_order.shipping_zone
      else
        zone = Spree::Zone.find_by(id: zone_id)
      end

      if zone
        SpreeZoned::ActiveZone::Session.current.set(zone)
        SpreeZoned::ActiveCountry.set(cookies, nil)
      end

      respond_to do |format|
        format.json { render json: true }
      end
    end
  end
end

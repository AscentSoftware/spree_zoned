module Spree
  class ActiveZoneController < Spree::StoreController
    def set
      zone_id = params[:zone]
      zone = Spree::Zone.find_by(id: zone_id)

      if zone
        SpreeZoned::ActiveZone::Session.current.set(zone)
        SpreeZoned::ActiveCountry.set(cookies, nil)

        if current_order
          ActiveRecord::Base.transaction do
            if current_order.bill_address
              current_order.bill_address = nil
            end

            if current_order.ship_address
              current_order.ship_address = nil
            end

            current_order.empty!
            current_order.restart_checkout_flow
            current_order.currency = zone.currency
            current_order.save!
          end
        end
      end

      respond_to do |format|
        format.json { render json: true }
      end
    end
  end
end

module Spree
  module Admin
    class PricesController < ResourceController
      belongs_to 'spree/product', :find_by => :slug

      def create
        params[:vp].each do |variant_id, prices|
          variant = Spree::Variant.find(variant_id)
          if variant
            prices.each do |currency_iso, amount|
              price = variant.price_in(currency_iso)
              price.price = amount.blank? ? nil : amount
              price.save! if price.changed?
            end
          end
        end
        flash[:success] = Spree.t('notice.prices_saved')
        redirect_to admin_product_path(parent)
      end
    end
  end
end

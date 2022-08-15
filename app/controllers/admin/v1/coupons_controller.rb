module Admin::V1
  class CouponsController < ApiController
    before_action :coupon_params
    def index
      @coupons = Coupon.all
    end

    def create
      @coupon = Coupon.new
      @coupon.attributes = coupon_params
      save_model(@coupon)
    end

    def update
      @coupon = Coupon.find(params[:id])
      @coupon.attributes = coupon_params
      save_model(@coupon)
    end

    def destroy
      byebug
      @coupon = Coupon.find(params[:id])
      @coupon.destroy!
    rescue
      render_error(fields: @coupon.errors.messages)
    end

    private

    def coupon_params
      return {} unless params.has_key?(:coupon)

      params.require(:coupon).permit(:id, :code, :status, :discount_value, :due_date)
    end

  end
end

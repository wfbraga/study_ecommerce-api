module Admin::V1
  class HomeController < ApiController
    def index
      render json: { message: 'Yahoo!' }
    end
  end
end
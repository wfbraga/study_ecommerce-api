module ModelSavior
  extend ActiveSupport::Concern

  included do

    def save_model(the_model_to_save)
      the_model_to_save.save! if current_user.admin?
      render :show
    rescue
      render_error(fields: the_model_to_save.errors.messages)
    end
  end
end
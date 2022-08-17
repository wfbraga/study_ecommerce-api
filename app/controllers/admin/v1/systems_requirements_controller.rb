module Admin::V1
  class SystemsRequirementsController < ApiController
    def index
      @systems_requirements = SystemRequirement.all
    end

    def create
      #byebug
      @system_requirement = SystemRequirement.new
      @system_requirement.attributes = system_requirement_params
      save_model(@system_requirement)
    end

    def update
      @system_requirement = SystemRequirement.find(params[:id])
      @system_requirement.attributes = system_requirement_params
      save_model(@system_requirement)
    end

    def destroy
      @system_requirement = SystemRequirement.find(params[:id])
      @system_requirement.destroy!
    rescue
      render_error(fields: @system_requirement.errors.messages)
    end

    private

    def system_requirement_params
      return {} unless params.has_key?(:system_requirement)

      params.require(:system_requirement).permit(:id, :name, :operational_system, :video_board, :storage, :processor, :memory)
    end
  end
end
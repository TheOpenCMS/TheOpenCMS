class PublicationParams::PubId < ActivePermits::PermittedParams::Base
  def permitted_params
    @params.fetch(:id)
  end
end

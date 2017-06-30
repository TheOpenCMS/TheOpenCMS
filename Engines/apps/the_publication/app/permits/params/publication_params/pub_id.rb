class PublicationParams::PubId < AuthorizeIt::PermittedParams::Base
  def permitted_params
    @params.fetch(:id)
  end
end

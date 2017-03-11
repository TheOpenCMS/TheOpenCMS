# include UserRoom::StoreDeviseRedirectLocation
module UserRoom
  module StoreDeviseRedirectLocation
    extend ActiveSupport::Concern

    included do
      after_filter :store_devise_redirect_location
    end # included

    # store last url - this is needed for post-login redirect to whatever the user last visited.
    def store_devise_redirect_location
      return if  request.xhr?
      return if !request.get?

      not_store_for = {
        registrations: %w[ new ],
        confirmation:  %w[ new ],
        sessions:      %w[ new ],
        passwords:     %w[ new edit ],
        omniauth_callbacks: %[ vkontakte facebook twitter google_oauth2 odnoklassniki failure ],

        users:   %w[ cabinet ],
        carts:   %w[ index ],
        orders:  %w[ index ]
      }.with_indifferent_access

      return if not_store_for.try(:[], controller_name).try(:include?, action_name)

      cookies[:previous_location] = request.fullpath
    end

  end # RedirectLocation
end # UserRoom

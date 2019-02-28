class ApplicationController < ActionController::API
    include JWTSessions::RailsAuthorization
    rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

    private
        def current_user
            puts ("APP CONTROLLER CURRENT USER")
            @current_user ||= User.find(payload['user_id'])
        end

        def not_authorized
            puts ("APP CONTROLLER NOT AUTHORIZED")
            render json: {error: 'Not authorized'}, status: :unauthorized
        end
end

class SigninController < ApplicationController
    #before_action :authorize_access_request!, only: [:destroy]

    def create
        current_user = User.find_by!(email: params[:email])

        if current_user.authenticate(params[:password])
            payload = {user_id: current_user.id}
            session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
            tokens = session.login
            print( tokens)
            response.set_cookie(JWTSessions.access_cookie,
                                    value: tokens[:access],
                                    httponly: true,
                                    secure: Rails.env.production?)
            puts ("SIGNNNIIIIN")
            render json: {csrf: tokens[:csrf]}
        else
            puts("SIGNNIIINELSEEE")
            not_authorized
        end
    end

    def destroy
        puts("DESTROY 1")
        #session = JWTSessions::Session.new(payload: payload)
        puts("DESTROY 2")
        #session.flush_by_access_payload
        puts("DESTROY 3")
        render json: :ok

    end

    private

        def not_found
            render json: {error: "Cannot find email/password combination"}, status: :not_found
        end
end

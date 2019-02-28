
  
class RefreshController < ApplicationController
    before_action :authorize_refresh_by_access_request!
  
    def create
        puts ("REFREESH")
        session = JWTSessions::Session.new(payload: claimless_payload, refresh_by_access_allowed: true)
        puts ("REFREESH4444444")
        tokens = session.refresh_by_access_allowed do
            puts ("REFREESHEWR")
            raise JWTSessions::Errors::Unauthorized, "Somethings not right here!"
        end

        puts ("REFREESH55555")
        response.set_cookie(JWTSessions.access_cookie,
                            value: tokens[:access],
                            httponly: true,
                            secure: Rails.env.production?)
        puts ("REFREESH56666")
        render json: { csrf: tokens[:csrf] }
    end
  end

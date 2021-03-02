class AuthController < ApplicationController
    def login
        user = User.find_by_email(params[:email])
        
        if user && user.authenticate(params[:password])
            token = encode_token({user_id: user.id})
            render :json => {token: token}
        else
            render :json => {error: "Invalid username or password"}, :status => 401
        end
    end

    private
        def encode_token(payload)
            payload['exp'] = 1.hour.from_now.to_i
            JWT.encode(payload, "secret key")
        end
end

class ApplicationController < ActionController::API
    before_action :load_user

    def load_user
        decoded = decoded_token

        if decoded
            user_id = decoded[0]['user_id']
            @user = User.includes(:role).find(user_id)
        else
            puts "Couldn't find the user"
        end
    end

    def authenticated?
        !@user.nil?
    end

    private

        def decoded_token
            if auth_header
                token = auth_header.split(' ')[1]
                if token
                    begin
                        decode token
                    rescue JWT::ExpiredSignature
                        puts "EXPIRED"
                        render json: {error: "Expired token"}, status: 401 and return
                    end
                end
            end
        end
    
        def auth_header
            request.headers['Authorization']
        end
        
        def decode(token)
            JWT.decode(token, "secret key", true, algorithm: "HS256")
        end
end

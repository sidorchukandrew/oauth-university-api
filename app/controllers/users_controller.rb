class UsersController < ApplicationController
    def me
        render :json => @user, 
            include: {
                role: {
                    except: excluded_role_fields,
                    include: {
                        permissions: {
                            only: [:name]
                        } 
                    }
                }
            },
            except: excluded_user_fields
    end

    private
    def excluded_user_fields
        ["password_digest", "role_id", "updated_at"]
    end

    def excluded_role_fields
        ["updated_at", "created_at", "id"]
    end
end

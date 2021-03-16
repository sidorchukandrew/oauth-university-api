class PermissionsController < ApplicationController
    def index
        if has_permission("roles.list")
            permissions = Permission.all
            render json: permissions
        else
            render_unauthorized_request
        end
    end
end

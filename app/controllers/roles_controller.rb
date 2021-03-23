class RolesController < ApplicationController
    def index
        if has_permission("roles.list")
            roles = Role.all
            render :json => roles, include: :permissions
        else
            render :json => {error: "You are not authorized to view these resources."}, status: 403
        end
    end

    def create
        if has_permission("roles.create")
            role = Role.create(role_params)
            render :json => role, include: :permissions
        else
            render :json => {error: "You are not authorized to create this resource."}, status: 403
        end
    end

    def update
        role_id = params[:id]
        permissions = role_params[:permissions_attributes]
        permissions_to_remove = permissions.select {|permission| permission['_destroy'] == 1} 
        permissions_to_add = permissions.select {|permission| !permission.key?('_destroy')}
        permission_ids_to_add = permissions_to_add.map {|permission| permission["id"]}
        result = Role.includes(:permissions).find(role_id).update({permissions_attributes: permissions_to_remove})

        if permission_ids_to_add.length > 0
            role = Role.find(role_id)
            role.permissions << Permission.find(permission_ids_to_add)
        end

        render :json => result, include: :permissions
    end

    private
        def role_params
           params.require(:role).permit(:name, :description, :id, 
                :permissions_attributes => [:_destroy, :id, :name]
            ) 
        end
end

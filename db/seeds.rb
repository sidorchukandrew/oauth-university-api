permission = Permission.find_or_create_by(name: "guides.list")
permission.description = "Can list or view all guides, whether published or unpublished."
permission.save

permission = Permission.find_or_create_by(name: "guides.delete")
permission.description = "Can delete any guides."
permission.save

permission = Permission.find_or_create_by(name: "guides.update")
permission.description = "Can update any guides. Includes changing published status, sections, title and description."
permission.save

permission = Permission.find_or_create_by(name: "guides.create")
permission.description = "Can create new guides."
permission.save

permission = Permission.find_or_create_by(name: "series.create")
permission.description = "Can create new series."
permission.save

permission = Permission.find_or_create_by(name: "series.list")
permission.description = "Can list or view all series, whether published or unpublished."
permission.save

permission = Permission.find_or_create_by(name: "series.update")
permission.description = "Can update any series. Includes changing published status, linked guides, title and description."
permission.save

permission = Permission.find_or_create_by(name: "series.delete")
permission.description = "Can delete any series."
permission.save

permission = Permission.find_or_create_by(name: "roles.delete")
permission.description = "Can delete any roles."
permission.save

permission = Permission.find_or_create_by(name: "roles.update")
permission.description = "Can update any roles by adding permissions, removing permissions or renaming the role."
permission.save

permission = Permission.find_or_create_by(name: "roles.create")
permission.description = "Can create a new role."
permission.save

permission = Permission.find_or_create_by(name: "roles.list")
permission.description = "Can list or view all roles along with their assigned permissions."
permission.save

permission = Permission.find_or_create_by(name: "analytics.list")
permission.description = "Can view various Google analytics."
permission.save

admin = Role.find_or_create_by(name: "Admin")
admin.permissions = Permission.all
admin.description = "Read, write, update and delete operations for all resources"
admin.save
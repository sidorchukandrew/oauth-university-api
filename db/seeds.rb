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

admin = Role.find_or_create_by(name: "Admin")
admin.permissions = Permission.all
admin.description = "Read, write, update and delete operations for all resources"
admin.save
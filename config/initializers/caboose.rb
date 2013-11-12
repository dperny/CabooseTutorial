# Salt to ensure passwords are encrypted securely
Caboose::salt = 'celkahdflkaspof8ufrhlcsk09ewtr32yhwqfdcsdvjjdflsuhfsdafjklyue'

# Where page asset files will be uploaded
Caboose::assets_path = Rails.root.join('app', 'assets', 'caboose')

# Register any caboose plugins
Caboose::plugins << ''

# Tell the host app about the caboose assets
Rails.application.config.assets.paths << Rails.root.join('vendor','gems','caboose-cms','app','assets','javascripts')
Rails.application.config.assets.paths << Rails.root.join('vendor','gems','caboose-cms','app','assets','stylesheets')
Rails.application.config.assets.precompile += [
  'login.css',
  'caboose/admin.js',
  'caboose/application.js',
  'caboose/login.js',
  'caboose/model.form.page.js',
  'caboose/station.js',
  'caboose/admin.css',
  'caboose/application.css',
  'caboose/caboose.css',
  'caboose/fonts.css',
  'caboose/tinymce.css'
]


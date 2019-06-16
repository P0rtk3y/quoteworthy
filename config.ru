require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

#mounts controllers. methodoverride allows PATCH and DELETE requests. Main contoller 'run'
use Rack::MethodOverride

use UsersController
use StoriesController
use QuotesController
run ApplicationController

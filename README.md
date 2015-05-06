# grape-device-sample

## Accessing Grape routes

Add this code in : *lib/tasks/routes.rake*

```ruby
namespace :api do
  desc "API Routes"
  task :routes => :environment do
    GrapeDeviceSample::Base.routes.each do |api|
      method = api.route_method.ljust(10)
      path = api.route_path.gsub(":version", api.route_version)
      puts "     #{method} #{path}"
    end
  end
end
```
Now, run this task and it should print routes :
```ruby 
rake api:routes
```

```
 GET        /api/v1/users
 GET        /api/v1/users/:id
 POST       /api/v1/users
 PUT        /api/v1/users/:id
 POST       /api/v1/users/signin
```

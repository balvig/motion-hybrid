if defined?(Motion::Project::Config)
  require 'motion-require'
  Motion::Require.all(Dir.glob(File.expand_path('../motion-rails/**/*.rb', __FILE__)))
else
  raise 'add rails stuff here?'
end

$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'motion-hybrid'
require 'bundler'
Bundler.require(:development)


Motion::Project::App.setup do |app|
  app.name = 'motion-hybrid test'
  app.version = '1.0'
end

namespace :spec do
  task :unit do
    App.config.spec_mode = true
    spec_files = App.config.spec_files - Dir.glob('./spec/functional/**/*.rb')
    App.config.instance_variable_set("@spec_files", spec_files)
    Rake::Task["simulator"].invoke
  end
end

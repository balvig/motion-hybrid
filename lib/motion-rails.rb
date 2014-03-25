require 'bubble-wrap'
require 'dish/motion'
require 'motion-cocoapods'
require 'motion-require'
require 'motion-support'
require 'ProMotion'
require 'sugarcube-classic'


Motion::Require.all(Dir.glob(File.expand_path('../motion-rails/**/*.rb', __FILE__)))

Motion::Project::App.setup do |app|
  app.pods do
    pod 'MBProgressHUD'
    pod 'SpinKit'
    pod 'CRToast'
  end
end

#if defined?(Motion::Project::Config)
  #require 'motion-require'
  #Motion::Require.all(Dir.glob(File.expand_path('../motion-rails/**/*.rb', __FILE__)))
#else
  #raise 'add rails stuff here?'
#end


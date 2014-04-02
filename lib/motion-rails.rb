require 'bubble-wrap'
require 'dish/motion'
require 'motion-cocoapods'
require 'motion-require'
require 'motion-support'
require 'ProMotion'
require 'sugarcube-classic'


Motion::Require.all(Dir.glob(File.expand_path('../motion-rails/**/*.rb', __FILE__)))

Motion::Project::App.setup do |app|
  app.resources_dirs << File.join(File.dirname(__FILE__), 'resources')
  app.pods do
    pod 'CRToast', '<0.0.6'
    pod 'FontAwesomeKit'
    pod 'MBProgressHUD'
    pod 'SpinKit'
  end
end

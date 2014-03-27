class BaseScreen < MotionRails::Screen
  self.root_url = NSURL.fileURLWithPath(NSBundle.mainBundle.resourcePath + '/web').to_s
end

class BaseScreen < MotionHybrid::Screen
  self.root_url = NSURL.fileURLWithPath(NSBundle.mainBundle.resourcePath + '/web').to_s
end

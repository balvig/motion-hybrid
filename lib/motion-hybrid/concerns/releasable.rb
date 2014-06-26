module MotionHybrid
  module Releasable

    def view_will_disappear(animated)
      @should_release = !nav_bar? || !navigationController.viewControllers.include?(self)
    end

    def view_did_disappear(animated)
      if @should_release
        webview.removeFromSuperview
        webview.release
      end
    end

  end
end

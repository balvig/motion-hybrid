module MotionHybrid
  module Releasable

    def will_disappear
      @should_release = !nav_bar? || !navigationController.viewControllers.include?(self)
    end

    def on_disappear
      if @should_release
        PM.logger.debug "Releasing #{self}"
        webview.removeFromSuperview
        webview.release
      end
    end

  end
end

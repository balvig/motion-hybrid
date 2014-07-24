module MotionHybrid
  module Releasable

    def will_disappear
      @should_release = nav_bar? && !navigationController.viewControllers.include?(self)
    end

    def on_disappear
      release_from_memory if @should_release
    end

    private

      def release_from_memory
        PM.logger.debug "Releasing #{self}"
        webview.removeFromSuperview
        webview.release
      end

  end
end

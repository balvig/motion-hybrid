module MotionHybrid
  module Updatable

    private

    def reload_dependents
      @needs_reload = false
      dependents.map(&:stop)
      dependents.map(&:reload)
    end

    # Inefficient, but will do for now
    def dependents
      dependents = all_views - [self]
      dependents = dependents | [parent_screen] if parent_screen
      dependents
    end

    def all_views
      app_delegate.window.rootViewController.viewControllers.map(&:viewControllers).flatten
    end

    def needs_reload?
      @needs_reload
    end

  end
end

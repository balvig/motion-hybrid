module MotionHybrid
  class Spinner

    def initialize(view)
      @view = view
    end

    def show
      show_hud
    end

    def hide
      MBProgressHUD.hideHUDForView(@view, animated: false)
    end

    private

    def show_hud
      hud = MBProgressHUD.showHUDAddedTo(@view, animated: true)
      hud.mode = MBProgressHUDModeCustomView
      hud.customView = spin_animation
      hud.removeFromSuperViewOnHide = true
      hud.opacity = 0
    end

    def spin_animation
      spin_animation = RTSpinKitView.alloc.initWithStyle(RTSpinKitViewStyleBounce, color: '#323667'.to_color) # TODO: Style from CSS
      spin_animation.startAnimating
      spin_animation
    end

  end
end

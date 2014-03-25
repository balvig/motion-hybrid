module MotionRails
  module Styleable

    def on_init
      super
      set_style_class
      set_webview_options
      remove_back_button_label
      self.title = nil
    end

    private

    def remove_back_button_label
      navigationItem.backBarButtonItem = UIBarButtonItem.alloc.initWithTitle("", style: UIBarButtonItemStylePlain, target: nil, action: nil)
    end

    def set_webview_options
      set_attributes webview, keyboard_display_requires_user_action: false, suppresses_incremental_rendering: true, background_color: UIColor.whiteColor
      set_attributes webview.scrollView, deceleration_rate: 0.999
    end

    def set_style_class
      navigationController.navigationBar.styleClass = style_class if nav_bar?
      view.styleClass = style_class
    end

    def style_class
      style_class = self.class.to_s.underscore
      style_class += ' modal' if modal?
      style_class
    end
  end
end

module MotionHybrid
  module Styleable

    def on_init
      super
      self.title = nil
      set_style_class if using_freestyle_css?
      set_webview_options
      set_tab_bar_options
      remove_back_button_label
    end

    def tab_bar=(tab_bar)
      @tab_bar = tab_bar
    end

    private

    def using_freestyle_css?
      view.respond_to?(:styleClass)
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

    def set_webview_options
      set_attributes webview, keyboard_display_requires_user_action: false, suppresses_incremental_rendering: true, background_color: UIColor.whiteColor
      set_attributes webview.scrollView, deceleration_rate: 0.999
    end

    def set_tab_bar_options
      set_tab_bar_item title: @tab_bar[:title], icon: Icon.new(@tab_bar[:icon], 25) if @tab_bar
    end

    def remove_back_button_label
      navigationItem.backBarButtonItem = UIBarButtonItem.alloc.initWithTitle("", style: UIBarButtonItemStylePlain, target: nil, action: nil)
    end

  end
end

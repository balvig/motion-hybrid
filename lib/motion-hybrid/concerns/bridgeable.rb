module MotionHybrid
  module Bridgeable

    def on_appear
      super
      if title_blank? && bridge.present?
        set_titles
      else
        @transition_finished = true
      end
      refresher.endRefreshing if refresher #avoids stuck animation
    end

    private

    def title_blank?
      title.blank? && navigationItem.titleView.blank?
    end

    def load_bridge
      self.bridge = Bridge.new(self)
    end

    def dom_loaded
      set_titles if transition_finished?
      set_buttons
      set_refresher
      render_flash
    end

    def transition_finished?
      @transition_finished
    end

    def set_titles
      if bridge.subtitle.present?
        self.navigationItem.titleView = MultiLineHeader.new(bridge.title, bridge.subtitle)
      else
        self.title = bridge.title
      end
    end

    def set_buttons
      #TODO : fix this madness
      set_nav_bar_left_button bridge.nav_bar_left_button.icon ? Icon.new(bridge.nav_bar_left_button.icon, 19) : nil, system_item: bridge.nav_bar_left_button.icon ? nil : UIBarButtonSystemItemStop, action: 'on_nav_bar_left_button_click' if bridge.nav_bar_left_button.present?
      set_nav_bar_right_button Icon.new(bridge.nav_bar_right_button.icon, 18), action: 'on_nav_bar_right_button_click' if bridge.nav_bar_right_button.present?
    end

    def on_nav_bar_button_click(side)
      button = "nav_bar_#{side}_button"
      if bridge.send(button).link
        bridge.click(button)
      else
        UIActionSheet.alert 'Post a photo of the finished dish!', buttons: bridge.send(button).options do |pressed, index|
          bridge.click_child(button, index)
        end
      end
    end

    def on_nav_bar_left_button_click
      on_nav_bar_button_click(:left)
    end

    def on_nav_bar_right_button_click
      on_nav_bar_button_click(:right)
    end

    def set_refresher
      if bridge.refreshable && !refresher
        self.refresher = UIRefreshControl.alloc.init
        refresher.addTarget(self, action: 'reload', forControlEvents: UIControlEventValueChanged)
        webview.scrollView.addSubview(refresher)
      end
    end

    def render_flash
      Toast.new(bridge.flash.title, bridge.flash.subtitle) if bridge.flash
    end

  end
end

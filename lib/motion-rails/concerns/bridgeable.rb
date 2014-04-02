module MotionRails
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
      set_nav_bar_left_button nil, system_item: UIBarButtonSystemItemStop, action: 'close_screen' if bridge.nav_bar_left_button.present?
      set_nav_bar_right_button Icon.new(:cog, 18), action: 'on_nav_bar_right_button_click' if bridge.nav_bar_right_button.present?
    end

    def on_nav_bar_right_button_click
      if bridge.nav_bar_right_button.link
        bridge.click(:nav_bar_right_button)
      else
        UIActionSheet.alert nil, buttons: bridge.nav_bar_right_button.options do |pressed, index|
          bridge.click_child(:nav_bar_right_button, index)
        end
      end
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

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
      set_button :left, bridge.nav_bar_buttons.left
      set_button :right, bridge.nav_bar_buttons.right
    end

    def set_button(side, button)
      return unless button
      icon = button.icon ? Icon.new(button.icon, 20) : nil
      send "set_nav_bar_#{side}_button", icon, action: "on_nav_bar_#{side}_button_click"
    end

    def on_nav_bar_button_click(side)
      button = bridge.nav_bar_buttons.send(side)
      if button.options.any?
        UIActionSheet.alert nil, buttons: button.options do |pressed, index|
          index = remap_index(index, button.options)
          bridge.click_child(button.id, index)
        end
      else
        bridge.click(button.id)
      end
    end

    #  iOS button order and actual order of buttons on screen are not the same
    def remap_index(index, options)
      if index == options.length - 1
        0
      else
        index + 1
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

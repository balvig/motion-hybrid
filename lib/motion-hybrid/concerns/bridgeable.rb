module MotionHybrid
  module Bridgeable

    def on_appear
      super
      @appeared = true
      set_titles if dom_loaded?
      refresher.endRefreshing if refresher #avoids stuck animation
    end

    private

      def load_bridge
        self.bridge = Bridge.new(self)
      end

      def dom_loaded
        PM.logger.debug "#{self} dom_loaded"
        set_titles if appeared?
        set_buttons
        set_refresher
        render_flash
        @dom_loaded = true
      end

      def dom_loaded?
        !!@dom_loaded
      end

      def appeared?
        !!@appeared
      end

      def set_titles
        if bridge.subtitle.present?
          self.navigationItem.titleView = MultiLineHeader.new(bridge.title, bridge.subtitle)
        else
          self.title = bridge.title
          self.navigationItem.titleView = nil
        end
      end

      def set_buttons
        if bridge.nav_bar_buttons
          set_button :left, bridge.nav_bar_buttons.left
          set_button :right, bridge.nav_bar_buttons.right
        else
          PM.logger.debug 'No buttons found'
        end
      end

      def set_button(side, button)
        return unless button
        return if button.modal && !top_of_modal?
        label = button.icon ? Icon.new(button.icon, 20) : button.label
        send "set_nav_bar_#{side}_button", label, action: "on_nav_bar_#{side}_button_click"
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
        Flash.new(bridge.flash.title, subtitle: bridge.flash.subtitle).show if bridge.flash
      end

      def top_of_modal?
        modal? && presenter == parent_screen
      end

  end
end

module MotionHybrid
  module BasicRoutes
    extend MotionSupport::Concern

    included do

      # All clicked GET-links are pushed
      route /.*/ do |request|
        push(request.url) if request.http_method == 'GET' && request.type == UIWebViewNavigationTypeLinkClicked
      end

      # Links with anchor #self are rendered in place
      route '#self' do |request|
        open_url(request.url_without_anchor)
      end

      # Hides tab bar
      route '#hide_tab_bar' do |request|
        push(request.url_without_anchor, hide_tab_bar: true)
      end

      # Opens in modal
      route '#modal' do |request|
        push(request.url_without_anchor, modal: true, nav_bar: true)
      end

      # Modals are closed if they encounter the url from which they were spawned from
      route /.*/ do |request|
        close_screen if presented_from?(request.url)
      end

    end

  end
end

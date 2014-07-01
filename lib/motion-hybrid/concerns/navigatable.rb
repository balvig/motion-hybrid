module MotionHybrid
  module Navigatable
    extend MotionSupport::Concern

    included do
      class_attribute :root_url, :routes
      self.routes = []
    end

    def set_initial_content
      super if @initial_url
    end

    def content
      NSURL.URLWithString(@initial_url)
    end

    def path=(path)
      self.url = self.class.url_for(path)
    end

    def path
      self.class.path_for(url)
    end

    def url=(url)
      @url = url
      @initial_url ||= url
      open_url(url) if webview
    end

    def url
      @url
    end

    def load_started
      start_transitions
    end

    def load_finished
      @url = current_url
      load_bridge
      reload_dependents if needs_reload?
      stop_transitions
    end

    def load_failed(error)
      unless [102, -999].include?(error.code) #http://stackoverflow.com/questions/19487330/failed-to-load-webpage-error-nsurlerrordomain-error-999
        stop_transitions
        on_error(error) if respond_to?(:on_error)
        PM.logger.warn error
      end
    end

    def reset!
      return_to_root
      load_initial_url
    end

    def return_to_root
      close_nav_screen(animated: false) if nav_bar?
    end

    def on_request(nsurlrequest, type)
      process_request Request.new(nsurlrequest, type)
    end

    def navigate(new_path)
      return if path == new_path
      process_request Request.new(self.class.request_for(new_path), UIWebViewNavigationTypeLinkClicked)
    end

    # overrides Promotion method to set more sensible timeout default
    def open_url(url)
      url = url.is_a?(NSURL) ? url : NSURL.URLWithString(url)
      request = NSURLRequest.requestWithURL(url, cachePolicy: NSURLRequestUseProtocolCachePolicy, timeoutInterval: 20)
      web.loadRequest request
    end

    private

    def process_request(request)
      @needs_reload = true if request.http_method != 'GET'

      if router.process(request)
        false
      else
        PM.logger.info("#{self} #{request.http_method} #{request.url}")
        true
      end
    end

    def push(url, options = {})
      view_options = options.slice!(:hide_tab_bar)
      options[:modal] = view_options[:modal]
      view_options.reverse_merge!(url: url, modal: modal?, transition_style: transition_style)
      new_view = self.class.new(view_options)
      open(new_view, options)
      new_view
    end

    def load_initial_url
      self.path = self.class.path_for(@initial_url)
    end

    def transition_style
      modal? ? UIModalTransitionStyleFlipHorizontal : nil
    end

    def router
      @router ||= Router.new(self)
    end

    module ClassMethods
      def url_for(path)
        "#{root_url}#{path}"
      end

      def request_for(path)
        NSURLRequest.requestWithURL NSURL.URLWithString(url_for(path))
      end

      def path_for(url)
        return if url.blank?
        NSURL.URLWithString(url).path
      end

      def route(*patterns, &block)
        patterns.each do |pattern|
          self.routes = [Route.new(pattern, &block)] + routes
        end
      end
    end
  end
end

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
      end_transitions
    end

    def load_failed(error)
      unless [102, -999].include?(error.code) #http://stackoverflow.com/questions/19487330/failed-to-load-webpage-error-nsurlerrordomain-error-999
        end_transitions
        show_error(error)
      end
    end

    def close_screen
      reload_dependents if needs_reload?
      super
    end

    def reset!
      dismissViewControllerAnimated(false, completion: nil)
      navigation_controller.popToRootViewControllerAnimated(false)
      load_initial_url
    end

    def on_request(nsurlrequest, type)
      process_request Request.new(nsurlrequest, type)
    end

    def navigate(new_path)
      return if path == new_path
      process_request Request.new(self.class.request_for(new_path), UIWebViewNavigationTypeLinkClicked)
    end

    private

    def process_request(request)
      return dom_loaded && false if request.url == 'motionhybrid://ready'
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
      open self.class.new(view_options), options
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

    def show_error(error)
      PM.logger.warn error
      BW::UIAlertView.default(title: 'Could not connect', message: error.localizedDescription, buttons: ['Cancel', 'Try Again']) do |alert|
        reset! if alert.clicked_button.index > 0
      end.show
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

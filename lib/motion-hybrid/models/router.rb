module MotionHybrid
  class Router

    def initialize(screen)
      @screen = screen
    end

    def process(request)
      routes.find do |route|
        route.matches?(request) && @screen.instance_exec(request, external?(request), &route.block)
      end
    end

    private

      def external?(request)
        !request.url.include?(@screen.root_url)
      end

      def routes
        @screen.class.routes
      end

  end
end

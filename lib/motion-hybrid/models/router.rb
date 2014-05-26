module MotionHybrid
  class Router

    def initialize(screen)
      @screen = screen
    end

    def process(request)
      routes.find do |route|
        route.matches?(request) && @screen.instance_exec(request, &route.block)
      end
    end

    private

    def routes
      @screen.class.routes
    end

  end
end

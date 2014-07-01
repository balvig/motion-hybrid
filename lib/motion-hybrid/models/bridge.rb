module MotionHybrid
  class Bridge
    PATH = NSBundle.mainBundle.resourcePath + '/jquery.motion-hybrid.js'
    JS_LIB = File.open(PATH).read

    def initialize(screen)
      @screen = screen
      @screen.evaluate(JS_LIB)
    end

    def click(target)
      js_api("clicked('#{target}')")
    end

    def click_child(target, index)
      js_api("clicked('#{target}', #{index})") if index > 0
    end

    private

    def bridge_hash
      @bridge_hash ||= Dish BW::JSON.parse(bridge_json)
    end

    def bridge_json
      js_api('getParams()').presence || '{}'
    end

    def method_missing(method)
      bridge_hash.send(method)
    end

    def js_api(command)
      @screen.evaluate("MotionHybrid.#{command};").to_s
    end

  end
end

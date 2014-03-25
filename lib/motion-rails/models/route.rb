module MotionRails
  class Route
    attr_accessor :block

    def initialize(pattern, &block)
      @pattern, @block = pattern, block
    end

    def matches?(request)
      # PM.logger.debug "#{request.url} <> #{@pattern}"
      if @pattern.is_a?(Regexp)
        @pattern =~ request.url
      elsif @pattern.start_with?('#')
        @pattern == "##{request.anchor}"
      elsif @pattern.start_with?('/')
        Screen.url_for(@pattern) == request.url
      else
        @pattern == request.url
      end
    end
  end

end

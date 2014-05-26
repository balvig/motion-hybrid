module MotionHybrid
  class Request

    def initialize(nsurlrequest, type)
      @nsurlrequest, @type = nsurlrequest, type
    end

    def url
      @nsurlrequest.URL.absoluteString
    end

    def url_without_anchor
      url.gsub(/#.+/, '')
    end

    def anchor
      @nsurlrequest.URL.fragment
    end

    def http_method
      @nsurlrequest.HTTPMethod
    end

    def type
      @type
    end

  end
end

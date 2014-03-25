module MotionRails
  module Presentable

    def presented_from?(url)
      presenter && presenter_url == url
    end

    private

    def presenter_url
      presenter.url.sub(/\?.+/, '').sub(/#.+/, '')
    end

    def presenter
      navigationController.viewControllers.first.parent_screen if navigationController
    end

  end
end

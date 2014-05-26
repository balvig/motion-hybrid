module MotionHybrid
  module Transitionable

    private

    def spinner
      @spinner ||= Spinner.new(view)
    end

    def start_transitions
      @loading = true
      spinner.hide
      App.run_after(0.6) do
        spinner.show if @loading
      end
      webview.scrollView.fade_out(duration: 0.2, opacity: 0.5)
    end

    def end_transitions
      @loading = false
      refresher.endRefreshing if refresher
      spinner.hide
      webview.scrollView.fade_in(0.2)
    end

  end

end

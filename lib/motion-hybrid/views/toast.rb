module MotionHybrid
  CRToastManager.setDefaultOptions(
    KCRToastAnimationOutDirectionKey => CRToastAnimationDirectionTop,
    KCRToastTextAlignmentKey => NSTextAlignmentLeft,
    KCRToastSubtitleTextAlignmentKey => NSTextAlignmentLeft,
    KCRToastNotificationTypeKey => CRToastTypeNavigationBar,
    KCRToastSubtitleFontKey => UIFont.systemFontOfSize(14)
  )

  class Toast
    attr_reader :title, :options, :responders

    def initialize(title, options = {})
      @title, @options = title, options
      @responders = [CRToastInteractionResponder.interactionResponderWithInteractionType(CRToastInteractionTypeSwipeUp, automaticallyDismiss: true, block: nil)]
    end

    def show(&block)
      responders << CRToastInteractionResponder.interactionResponderWithInteractionType(CRToastInteractionTypeTapOnce, automaticallyDismiss: true, block: -> (i) { block.call }) if block_given?
      CRToastManager.showNotificationWithOptions(kcr_options, completionBlock: nil)
    end

    def text_color
      '#333'.to_color
    end

    def background_color
      '#ffffff'.to_color
    end

    def image
      if options[:image_url]
        image_data = NSData.dataWithContentsOfURL(NSURL.URLWithString(options[:image_url]))
        retinafy UIImage.imageWithData(image_data)
      end
    end

    private

      def retinafy(image)
        UIImage.imageWithCGImage(image.CGImage, scale: 2, orientation: image.imageOrientation)
      end

      def kcr_options
        {
          KCRToastTextKey => title,
          KCRToastSubtitleTextKey => options[:subtitle].presence,
          KCRToastTextColorKey => text_color,
          KCRToastBackgroundColorKey => background_color,
          KCRToastSubtitleTextColorKey => text_color,
          KCRToastImageKey => image,
          KCRToastFontKey => options[:subtitle].present? ? UIFont.boldSystemFontOfSize(13) : UIFont.systemFontOfSize(18),
          KCRToastTimeIntervalKey => options[:subtitle].present? ? 5 : nil,
          KCRToastInteractionRespondersKey => responders
        }
      end
  end

  class Flash < Toast
    def text_color
      '#3c763d'.to_color
    end

    def background_color
      '#dff0d8'.to_color
    end

    def image
      Icon.new(:check, 20, color: text_color)
    end
  end

end

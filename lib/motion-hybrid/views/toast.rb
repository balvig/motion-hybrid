module MotionHybrid
  class Toast
    TEXT_COLOR = '#3c763d'.to_color
    BACKGROUND_COLOR = '#dff0d8'.to_color
    def initialize(title, subtitle = nil)
      options = {
        'kCRToastTextKey' => title,
        'kCRToastFontKey' => UIFont.boldSystemFontOfSize(15),
        'kCRToastTextColorKey' => TEXT_COLOR,
        'kCRToastBackgroundColorKey' => BACKGROUND_COLOR,
        'kCRToastSubtitleFontKey' => UIFont.boldSystemFontOfSize(15),
        'kCRToastSubtitleTextColorKey' => TEXT_COLOR,
        'kCRToastTextAlignmentKey' => NSTextAlignmentLeft,
        'kCRToastSubtitleTextAlignmentKey' => NSTextAlignmentLeft,
        'kCRToastNotificationTypeKey' => CRToastTypeNavigationBar
      }

      options.merge!('kCRToastFontKey' => UIFont.systemFontOfSize(13), 'kCRToastSubtitleTextKey' => subtitle, 'kCRToastTimeIntervalKey' => 3) if subtitle.present?

      CRToastManager.showNotificationWithOptions options, completionBlock: nil
    end
  end
end

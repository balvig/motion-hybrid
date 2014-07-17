module MotionHybrid
  class Toast
    TEXT_COLOR = '#3c763d'.to_color
    BACKGROUND_COLOR = '#dff0d8'.to_color
    def initialize(title, subtitle = nil)
      options = {
        'kCRToastTextKey' => title,
        'kCRToastFontKey' => UIFont.systemFontOfSize(18),
        'kCRToastTextColorKey' => TEXT_COLOR,
        'kCRToastBackgroundColorKey' => BACKGROUND_COLOR,
        'kCRToastSubtitleFontKey' => UIFont.systemFontOfSize(13),
        'kCRToastSubtitleTextColorKey' => TEXT_COLOR,
        'kCRToastTextAlignmentKey' => NSTextAlignmentLeft,
        'kCRToastSubtitleTextAlignmentKey' => NSTextAlignmentLeft,
        'kCRToastNotificationTypeKey' => CRToastTypeNavigationBar,
        'kCRToastImageKey' => Icon.new(:check, 20, color: TEXT_COLOR)
      }

      options.merge!('kCRToastFontKey' => UIFont.boldSystemFontOfSize(16), 'kCRToastSubtitleTextKey' => subtitle, 'kCRToastTimeIntervalKey' => 5) if subtitle.present?

      CRToastManager.showNotificationWithOptions options, completionBlock: nil
    end
  end
end

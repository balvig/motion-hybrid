module MotionRails
  class MultiLineHeader
    def self.new(title, subtitle)
      view = UIView.alloc.initWithFrame CGRectMake(0, 0, 200, 44)
      view.autoresizesSubviews = true
      view.styleId = 'multi_line_header' if view.respond_to?(:styleId)

      view.addSubview titleView(title)
      view.addSubview subtitleView(subtitle)

      view.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                               UIViewAutoresizingFlexibleRightMargin |
                               UIViewAutoresizingFlexibleTopMargin |
                               UIViewAutoresizingFlexibleBottomMargin)

      view
    end

    def self.titleView(title)
      titleView = UILabel.alloc.initWithFrame CGRectMake(0, 2, 200, 24)
      titleView.textAlignment = UITextAlignmentCenter
      titleView.font = UIFont.boldSystemFontOfSize(13)
      titleView.text = title
      titleView.adjustsFontSizeToFitWidth = true
      titleView
    end

    def self.subtitleView(subtitle)
      subtitleView = UILabel.alloc.initWithFrame CGRectMake(0, 20, 200, 44-24)
      subtitleView.textAlignment = UITextAlignmentCenter
      subtitleView.font = UIFont.systemFontOfSize(11)
      subtitleView.text = subtitle
      subtitleView.adjustsFontSizeToFitWidth = true
      subtitleView
    end
  end
end

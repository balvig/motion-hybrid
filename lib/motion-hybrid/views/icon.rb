module MotionHybrid
  class Icon
    def self.new(name, size, options = {})
      name = name.underscore.camelize(:lower) # f.ex trash-o becomes trashO
      icon = FAKFontAwesome.send("#{name}IconWithSize", size)
      icon.addAttribute(NSForegroundColorAttributeName, value: options[:color]) if options[:color]
      icon.imageWithSize(CGSizeMake(size, size))
    end
  end
end

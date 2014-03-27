class Icon
  def self.new(name, size, options = {})
    icon = FAKFontAwesome.send("#{name}IconWithSize", size)
    icon.addAttribute(NSForegroundColorAttributeName, value: options[:color]) if options[:color]
    icon.imageWithSize(CGSizeMake(size, size))
  end
end

module MotionHybrid
  class Screen < PM::WebScreen

    include Bridgeable
    include Navigatable
    include BasicRoutes
    include Presentable
    include Styleable
    include Syncable
    include Transitionable
    include Updatable

    attr_accessor :bridge, :refresher

  end
end

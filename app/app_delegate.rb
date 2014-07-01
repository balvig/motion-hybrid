class AppDelegate < PM::Delegate
  def on_load(app, options)
    return true if App.environment == 'test'
    open BaseScreen.new(nav_bar: true, path: '/index.html')
  end
end

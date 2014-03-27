class AppDelegate < PM::Delegate
  def on_load(app, options)
    return true if App.environment == 'test'

    BaseScreen.sync_sessions do
      @screen_1 = BaseScreen.new(nav_bar: true, path: '/index.html', tab_bar: { title: 'Welcome', icon: :users })
      @screen_2 = BaseScreen.new(nav_bar: true, path: '/refreshable.html', tab_bar: { title: 'Refreshable', icon: :cog })
      open_tab_bar @screen_1, @screen_2
    end
  end
end

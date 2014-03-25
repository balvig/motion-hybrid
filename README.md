# motion-rails



TODO: Write a gem description

## Installation


Add to Gemfile:

```ruby
  gem 'motion-rails'
```

Run bundle and install required cocoapods:

```bash
$ bundle
$ rake pod:install
```

## Usage

```ruby
# app/screens/base_screen.rb
class BaseScreen < MotionRails::Screen
  self.root_url = 'http://github.com'
end

# app/app_delegate.rb
class AppDelegate < PM::Delegate
  def on_load(app, options)
    BaseScreen.sync_sessions do
      @screen_1 = BaseScreen.new(nav_bar: true, path: '/balvig')
      @screen_2 = BaseScreen.new(nav_bar: true, path: '/rubymotion')

      @screen_1.set_tab_bar_item title: 'Balvig', system_icon: :more
      @screen_2.set_tab_bar_item title: 'Rubymotion', system_icon: :favorites

      open_tab_bar @screen_1, @screen_2
    end
  end
end
```

### Basic navigation

### Bridge

### Custom routes

TODO: Write usage instructions here

## Contributing

1. Fork it ( http://github.com/balvig/motion-rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

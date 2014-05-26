# motion-hybrid

motion-hybrid takes your existing web app and views and wraps them in a snappy native iOS interface

## Installation


Add to your rubymotion project's Gemfile:

```ruby
gem 'motion-hybrid'
```

Run bundle and install required cocoapods:

```bash
$ bundle
$ rake pod:install
```

## Basic Usage

Create a screen that inherits from `MotionHybrid::Screen` and set the base url of your web app:

```ruby
# app/screens/base_screen.rb
class BaseScreen < MotionHybrid::Screen
  self.root_url = 'http://github.com'
end
```

Create one or more screens and set their paths:

```ruby
# app/app_delegate.rb
class AppDelegate < PM::Delegate
  def on_load(app, options)
    BaseScreen.sync_sessions do
      @screen_1 = BaseScreen.new(nav_bar: true, path: '/balvig', tab_bar: { title: 'Balvig', icon: :users })
      @screen_2 = BaseScreen.new(nav_bar: true, path: '/rubymotion', tab-bar: { title: 'Rubymotion', icon: :gear })
      open_tab_bar @screen_1, @screen_2
    end
  end
end
```

### Navigation

By default, all GET-links are pushed onto the navigation controller stack.

```html
<!-- index.html -->
<a href='index_2.html'>Page 2</a>

<!-- index_2.html -->
<p>This is page 2</p>
```

<img src='https://dl.dropboxusercontent.com/u/3032793/screenshots/get.gif' width='200px' />

### Modals

Links with anchor `#modal` will be opened in a modal window.
Links _within_ a modal linking to the url of the page that created it will automatically close the modal.

```html
<!-- index.html -->
<a href='modal.html#modal'>Page 2</a>

<!-- modal.html -->
<a href='index.html'>This will close the modal</a>
```

<img src='https://dl.dropboxusercontent.com/u/3032793/screenshots/modal.gif' width='200px' />

### Inline

Links with anchor `#self` will open the new url within the current view without pushing a new view on to the stack:

### Non-GET requests

Any non-GET requests (form posts etc) will display the result within the current view and also automatically refresh all other views so that pages are up to date.

## The Bridge

The bridge is a small javascript connection between the web app and native app that allows you to use HTML in your web page to control pars of the native app.

All markup is contained within a div with id `motion-hybrid-bridge`

### Title/subtitles

```html
<div id='motion-hybrid-bridge'>
  <h1>This is the title</h1>
  <h2>This is a subtitle</h2>
</div>
```

### Alerts

```html
<div id='motion-hybrid-bridge'>
  <div class='flash'>
    <h3>Congratulations!</h3>
    <p>You completed level 2</p>
  </div>
</div>
```

### Navbar items

TBA

## Custom routes

Sometimes you will want to trigger native iOS functionality from the web views, this is done by intercepting URLs that you can intercept and handle using the routing api, so you can do things like:

```ruby
class BaseScreen < MotionHybrid::Screen
  # pops up in-app email composer when clicking mailto: links
  route /^mailto:/ do |request|
    BW::Mail.compose(to: 'bob@example.com', subject: 'In app emailing', message: 'Hi!', animated: true)
  end
  
  # ask for push nofitication permisions when user hits '/setup' url
  route '/setup' do
    app_delegate.register_for_push_notifications :badge, :sound, :alert
  end
end
```


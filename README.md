# motion-rails

motion-rails takes your existing web app and views and wraps it in a native iOS interface 

## Installation


Add to your rubymotion project's Gemfile:

```ruby
  gem 'motion-rails'
```

Run bundle and install required cocoapods:

```bash
$ bundle
$ rake pod:install
```

## Usage

Create a screen that inherits from `MotionRails::Screen` and set the base url of your web app:

```ruby
# app/screens/base_screen.rb
class BaseScreen < MotionRails::Screen
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

### Basic navigation

#### Links

By default, all GET-links are pushed onto the navigation controller stack.

```html
<a href='index_2.html'>Page 2</a>
```

results in this:

![Basic links](https://dl.dropboxusercontent.com/u/3032793/screenshots/get.gif)

#### Modals

Links with anchor `#modal` will be opened in a modal window.
Links _within_ a modal linking to the url of the page that created the modal will automatically close the modal.

```html
<!-- index.html -->
<a href='modal.html#modal'>Page 2</a>

<!-- modal.html -->
<a href='index.html'>This will close the modal</a>
```

![Basic links](https://dl.dropboxusercontent.com/u/3032793/screenshots/modal.gif)



#### Inline

Links with anchor `#self` will open the new url within the current view without pushing a new view on to the stack:

#### POST/PATCH/DELETE

Any non-GET requests (forms etc) will display the result within the current view, and automatically refresh all other views so that all pages are up to date when changing something

### Bridge

The bridge is a small javascript connection between the web app and native app that allows you to use HTML in your web page to control pars of the native app. 

All markup is contained within a div with id `motion-rails-bridge`

#### Title/subtitles

```html
<div id='motion-rails-bridge'>
  <h1>This is the title</h1>
  <h2>This is a subtitle</h2>
</div>
```

#### Alerts

```html
<div id='motion-rails-bridge'>
  <div class='flash'>
    <h3>Congratulations!</h3>
    <p>You completed level 2</p>
  </div>
</div>
```


### Custom routes

TODO: Write usage instructions here

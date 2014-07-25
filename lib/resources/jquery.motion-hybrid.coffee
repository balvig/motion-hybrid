class window.MotionHybrid
  @getParams: ->
    bridge = $('#motion_hybrid_bridge')

    params = {}
    params.title = bridge.find('h1').text()
    params.subtitle = bridge.find('h2').text()
    params.flash = parseFlash bridge.find('.flash')
    params.nav_bar_buttons = {}
    params.nav_bar_buttons.left = parseButton bridge.find('#nav_bar_left_button')
    params.nav_bar_buttons.right = parseButton bridge.find('#nav_bar_right_button')

    params.refreshable = $('[data-refreshable]').length > 0
    JSON.stringify params

  parseFlash = (flash) ->
    { title: flash.find('h3').text() || flash.text().trim(), subtitle: flash.find('p').text() } if flash.length

  parseButton = (button) ->
    { id: button.attr('id'), options: button.children().map(-> this.innerText).get(), icon: button.data('icon'), label: button.text().trim() } if button.length

  @clicked: (target, childIndex) ->
    target = $("##{target}")
    target = target.children() if childIndex
    target.get(childIndex || 0).click()

  @waitForJqueryAndDom: ->
    #alert 'finding jquery'
    if window.$
      #alert 'found'
      jQuery -> document.location.href = 'motionhybrid://ready'
    else
      #alert 'waiting'
      setTimeout MotionHybrid.waitForJqueryAndDom, 100

MotionHybrid.waitForJqueryAndDom()

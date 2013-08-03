"use strict"

new class FacebookSearch
  constructor: ->
    console.log('constructor')
    @text = undefined
    setTimeout(@initialize.bind(this), 2000)

  initialize: ->
    globalObserver = new MutationObserver (changes) =>
      @lastUrl = undefined
      contentObserver = new MutationObserver (changes) => @lastUrl = undefined
      contentObserver.observe $('#contentCol')[0], childList: true
    globalObserver.observe $('#content')[0], childList: true
   
    if $('#contentCol').length
      contentObserver = new MutationObserver (changes) => @lastUrl = undefined
      contentObserver.observe $('#contentCol')[0], childList: true

    that = this
    $(document).on 'keyup', '.uiSearchInput input', ->
      that.hook()
      that.text = $(this).val()
      that.filter()

  hook: ->
    return if @lastUrl == document.location.href
    @lastUrl = document.location.href
    console.log('hook')
    observer = new MutationObserver (changes) => @filter()
    observer.observe $('.fbGroupsStream')[0], childList: true

  filter: ->
    return unless @text?
    regexp = new RegExp(@text, "i")
    $('.uiStreamStory').each ->
      text = $(this).text()
      if text.match(regexp)
        $(this).show()
      else
        $(this).hide()

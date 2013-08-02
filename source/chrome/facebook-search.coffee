"use strict"

new class FacebookSearch
  constructor: ->
    @text = undefined
    setTimeout(@initialize.bind(this), 2000)

  initialize: ->
    observer = new MutationObserver (changes) => @filter()
    observer.observe $('.fbGroupsStream')[0], childList: true

    that = this
    $('.uiSearchInput input').on 'keyup', ->
      that.text = $(this).val()
      that.filter()

  filter: ->
    return unless @text?
    regexp = new RegExp(@text, "i")
    $('.uiStreamStory').each ->
      text = $(this).text()
      if text.match(regexp)
        $(this).show()
      else
        $(this).hide()

attrEscape = (attr) ->
  attr.replace(/"/g, '%22').replace(/'/g, '%27')

pixelValue = (value) ->
  "#{value}px"

after = (ms, cb) -> setTimeout cb, ms

@generateHoverImages = ->
  $('.hover-image').remove()

  $('img.hover-zoom').each((i) ->
    $this = $(@)
    largeImgSrc = $this.data('img-large')
    return unless largeImgSrc?

    hoverImageId = "hover-image-#{i}"

    $('body').append """
      <div id='#{hoverImageId}' class='hover-image'>
        <img src='#{attrEscape largeImgSrc}' />
      </div>
    """
    $this.data 'hover-image-el', $("##{hoverImageId}")

  ).mousemove((e) ->
    $hoverImage    = $(@).data('hover-image-el')
    {pageX, pageY} = e
    windowHeight   = $(window).height()
    windowWidth    = $(window).width()
    imageHeight    = $hoverImage.outerHeight()
    mouseOffset    = 25

    if (pageY + imageHeight) > windowHeight
      pageY = Math.round((windowHeight - imageHeight) / 2)

    if pageX > (windowWidth / 2)
      # on right side of screen
      right = pixelValue(windowWidth - pageX + mouseOffset)
      left  = ''
    else
      left  = pixelValue(pageX + mouseOffset)
      right = ''

    $hoverImage.css
      display: 'block'
      left:    left
      right:   right
      top:     pixelValue(pageY)

  ).mouseleave ->
    $(@).data('hover-image-el').css 'display', 'none'

$ ->
  generateHoverImages()

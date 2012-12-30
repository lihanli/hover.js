attrEscape = (attr) ->
  attr.replace(/"/g, '%22').replace(/'/g, '%27')

pixelValue = (value) ->
  "#{value}px"

@generateHoverImages = ->
  $('.hover-image').remove()

  $('img.hover-zoom').each((i) ->
    $this       = $(@)
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
    $hoverImage        = $(@).data('hover-image-el')
    {clientX, clientY} = e
    windowHeight       = innerHeight
    windowWidth        = innerWidth
    imageHeight        = $hoverImage.outerHeight()
    mouseOffset        = 25

    if (clientY + imageHeight) > windowHeight
      clientY = Math.round((windowHeight - imageHeight) / 2)

    if clientX > (windowWidth / 2)
      # on right side of screen
      right = pixelValue(windowWidth - clientX + mouseOffset)
      left  = ''
    else
      left  = pixelValue(clientX + mouseOffset)
      right = ''

    $hoverImage.css
      display: 'block'
      left:    left
      right:   right
      top:     pixelValue(clientY)

  ).mouseleave ->
    $(@).data('hover-image-el').css 'display', 'none'

$ ->
  generateHoverImages()

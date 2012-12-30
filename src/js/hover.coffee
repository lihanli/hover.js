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

    $hoverImage = $("##{hoverImageId}")
    $this.data 'hover-image-div', $hoverImage
    $this.data 'hover-image-img', $hoverImage.find('img')

  ).mousemove((e) ->
    $this              = $(@)
    $hoverImage        = $this.data('hover-image-div')
    {clientX, clientY} = e
    windowHeight       = innerHeight
    windowWidth        = innerWidth
    imageHeight        = $hoverImage.outerHeight()
    mouseOffset        = 25
    hasScrollBar       = $(document).height() > $(window).height()
    scrollBarOffset    = 15

    absOffsets =
      right:  false
      left:   false
      top:    clientY
      bottom: false

    imgPadding =
      top:  20
      side: 20

    if (clientY + imageHeight + imgPadding.top) > windowHeight
      absOffsets.top    = false
      absOffsets.bottom = 6

    if clientX > (windowWidth / 2)
      # on right side of screen
      absOffsets.right = windowWidth - clientX + mouseOffset
      absOffsets.right -= scrollBarOffset if hasScrollBar
    else
      absOffsets.left = clientX + mouseOffset
      imgPadding.side += scrollBarOffset if hasScrollBar

    $this.data('hover-image-img').css
      'max-width':  ((if absOffsets.left then (windowWidth - mouseOffset - clientX) else (clientX - mouseOffset)) - imgPadding.side)
      'max-height': windowHeight - imgPadding.top

    $hoverImage.css 'display', 'block'

    for k, v of absOffsets
      $hoverImage.css(k, if v == false then '' else pixelValue(v))

  ).mouseleave ->
    $(@).data('hover-image-div').css 'display', 'none'

$ ->
  generateHoverImages()

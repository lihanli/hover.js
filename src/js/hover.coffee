attrEscape = (attr) ->
  attr.replace(/"/g, '%22').replace(/'/g, '%27')

@generateHoverImages = ->
  $('.hover-image').remove()

  $('img.hover-zoom').each((i) ->
    $this       = $(@)
    largeImgSrc = $this.data('img-large')
    throw 'missing data-img-large attribute for an image' unless largeImgSrc?

    hoverImageId = "hover-image-#{i}"

    $('body').append """
      <div id='#{hoverImageId}' class='hover-image'>
        <img src='#{attrEscape largeImgSrc}' />
      </div>
    """
    $this.data 'hover-image-div', $("##{hoverImageId}")

  ).mouseenter(->
    $this = $(@)
    $this.off 'mousemove'

    $hoverDiv       = $this.data('hover-image-div')
    $hoverImg       = $hoverDiv.find('img')
    windowHeight    = innerHeight
    windowWidth     = innerWidth
    mouseOffset     = 25
    hasScrollBar    = $(document).height() > $(window).height()
    scrollBarOffset = 15

    $hoverDiv.fadeIn '250ms'

    $this.mousemove (e) ->
      imageHeight        = $hoverDiv.outerHeight()
      {clientX, clientY} = e

      imgPadding =
        top:  20
        side: 20

      absOffsets =
        right:  false
        left:   false
        top:    clientY
        bottom: false

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

      $hoverImg.css
        'max-width':  ((if absOffsets.left then (windowWidth - mouseOffset - clientX) else (clientX - mouseOffset)) - imgPadding.side)
        'max-height': windowHeight - imgPadding.top

      for k, v of absOffsets
        $hoverDiv.css(k, if v == false then '' else v)

  ).mouseleave ->
    $(@).data('hover-image-div').hide()

$ ->
  generateHoverImages()

dom = undefined

attrEscape = (attr) ->
  attr.replace(/"/g, '%22').replace(/'/g, '%27')

@generateHoverImages = ->
  $('.hover-image').remove()
  dom.hoverImgThumbs = $('img.hover-zoom')

  dom.hoverImgThumbs.each (i) ->
    $this       = $(@)
    largeImgSrc = $this.data('img-large')
    throw 'missing data-img-large attribute for an image' unless largeImgSrc?

    dom.body.append """
      <div class='hover-image'>
        <img src='#{attrEscape largeImgSrc}' />
      </div>
    """

    $hoverDiv = $('.hover-image:last')

    $this.data 'hover-image-div', $hoverDiv
    $this.data 'hover-image-img', $hoverDiv.find('img')

  dom.hoverImgs = $('.hover-image')

  dom.hoverImgThumbs.mouseenter(->
    $this = $(@)
    $this.off 'mousemove'
    dom.hoverImgs.hide()

    $hoverDiv       = $this.data('hover-image-div')
    $hoverImg       = $this.data('hover-image-img')
    windowHeight    = innerHeight
    windowWidth     = innerWidth
    mouseOffset     = 25
    hasScrollBar    = dom.document.height() > dom.window.height()
    scrollBarOffset = 15
    bottomPadding   = 6

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

      if (clientY + imageHeight + imgPadding.top - (bottomPadding * 2)) > windowHeight
        absOffsets.top    = false
        absOffsets.bottom = bottomPadding

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
    dom.hoverImgs.hide()

$ ->
  dom =
    document: $(document)
    window:   $(window)
    body:     $('body')

  generateHoverImages()

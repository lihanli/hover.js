# Hover.js

Zoom images on mouseover

### <a target="_blank" href="http://lihanli.github.com/hover.js/">Demo</a>

## Features

- Images are automatically resized with the correct aspect ratio to fit the browser window
- Images are optimally positioned to the right or left of the mouse

## Usage

- Add jQuery, hover.js, and hover.css to the page
- Add image tags with a 'hover-zoom' class and a 'data-img-large' attribute that contains the location of the original image

```html
<img class='hover-zoom' data-img-large='/img/foo_large.jpg' src='/img/foo_thumb.jpg' />
```

- When you dynamically add or remove images from the page rerun the window.generateHoverImages() function (it's automatically run once on page load)

## Why use it?

Browser extensions which implement this feature are very popular. See https://chrome.google.com/webstore/detail/photo-zoom-for-facebook/elioihkkcdgakfbahdoddophfngopipi?hl=en

## Requirements
- jQuery

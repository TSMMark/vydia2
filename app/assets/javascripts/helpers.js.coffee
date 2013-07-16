

window.Helper =
  embed_code: (video, network, ad_bottom=false)->
    extra_height  = !!ad_bottom
    height        = Var.iframe.default_height
    height       += Var.iframe.ad_bottom_height if extra_height
    width         = Var.iframe.default_width

    src = "//#{Var.domain}/videos/#{video}/embed/#{network}"
    iframe_inner  = "" # "Your browser is extremely old. <a href='//google.com/chrome'>Upgrade it</a>."

    "<iframe width=\"#{width}\" height=\"#{height}\" src=\"#{src}\" frameborder=\"0\" allowfullscreen>#{iframe_inner}</iframe>"

  load_js: (url)->
    (((d,e,l)->
      t = d.createElement(e)
      t.src = l
      t.async = true
      s = d.getElementsByTagName(e)[0]
      s.parentNode.insertBefore t, s
    )(window.document, 'script', url))



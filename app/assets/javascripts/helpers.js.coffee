

window.Helper =
  embed_code: (video, network)->
    src = "//#{Var.domain}/videos/#{video}/embed/#{network}"
    iframe_inner  = "" # "Your browser is extremely old. <a href='//google.com/chrome'>Upgrade it</a>."

    "<iframe width=\"560\" height=\"315\" src=\"#{src}\" frameborder=\"0\" allowfullscreen>#{iframe_inner}</iframe>"

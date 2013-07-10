

window.Helper =
  embed_code: (video, network)->
    src = "//#{Var.domain}/videos/#{video}/embed/#{network}"
    iframe_inner  = "" # "Your browser is extremely old. <a href='//google.com/chrome'>Upgrade it</a>."

    "<iframe src='#{src}'>#{iframe_inner}</iframe>"



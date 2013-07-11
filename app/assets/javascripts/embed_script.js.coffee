window.Embed ||= {}

# when iframe_api is loaded and ready to be used
#   basically an initializer
window.onYouTubeIframeAPIReady = ->
  Embed.player = new YT.Player(Embed.player_id,
    height: "100%"
    width: "100%"
    videoId: Embed.video
    events:
      onReady: onPlayerReady
      onStateChange: onPlayerStateChange
  )

# load youtube api
Helper.load_js "//www.youtube.com/iframe_api"

# when our video has been loaded in and is ready
onPlayerReady = (playerId) ->
  window.player_ready and window.player_ready(playerId)
  window.player_is_ready = true

onPlayerStateChange = (newState) ->
  console.log newState
  switch newState.data
    when 1
      Embed.play_begin()
    when 0
      Embed.play_complete()

Embed.play_begin = ->
  console.log "Video Duration", Embed.player.getDuration()

Embed.play_complete = ->
  src = Embed.tracking_url
  f = document.getElementsByTagName("img")[0]
  
  # don't add if already there
  return false  if f.src.indexOf(src) isnt -1
  i = document.createElement("img")
  i.src = src
  f.parentNode.insertBefore i, f
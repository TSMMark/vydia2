window.Embed ||= 
  "video"         : null
  "network"       : null
  "tracking_url"  : null
  "player_id"     : null
  "player"        : null
  "duration"      : null


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
    when 2
      Embed.play_pause()
    when 0
      Embed.play_complete()

Embed.play_begin  = ->
  Embed.duration  = Embed.player.getDuration()
  Embed.timer     = setInterval Embed.interval, 1000
  console.log "Video Duration", Embed.duration
  Embed.interval()

Embed.play_pause  = ->
  clearInterval Embed.timer

Embed.play_complete = ->
  Embed.play_pause()

  src = Embed.tracking_url
  f = document.getElementsByTagName("img")[0]
  
  # don't add if already there
  return false  if f.src.indexOf(src) isnt -1
  i = document.createElement("img")
  i.src = src
  f.parentNode.insertBefore i, f

Embed.state_complete = (state)->
  return false if state == Embed.last_state
  Embed.last_state = state
  console.log "state", state

Embed.interval = ->
  duration      = Embed.duration
  current_time  = Embed.player.getCurrentTime()
  percentage    = current_time / duration
  console.log "#{current_time} / #{duration} = #{percentage}"
  state = switch
    when percentage > .99 then 4
    when percentage > .74 then 3
    when percentage > .49 then 2
    when percentage > .24 then 1
    else 0

  Embed.state_complete state








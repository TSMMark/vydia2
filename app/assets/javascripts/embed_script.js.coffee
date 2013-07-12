window.Embed ||= 
  "video"         : null
  "network"       : null
  "tracking_url"  : null
  "player_id"     : null
  "player"        : null
  "duration"      : null
  "current_state" : null

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
  switch newState.data
    when 1
      Embed.on_begin()
    when 2
      Embed.on_pause()
    when 0
      Embed.on_complete()

Embed.on_begin  = ->
  Embed.duration  = Embed.player.getDuration()
  Embed.timer     = setInterval Embed.interval, 1000
  Embed.interval()

Embed.on_pause  = ->
  Embed.stop_timer()

Embed.on_complete = ->
  Embed.stop_timer()
  Embed.state_complete(4)

Embed.stop_timer  = ->
  clearInterval Embed.timer  

Embed.get_state_url = ->
  return Embed.tracking_url + "?state=#{Embed.current_state}"

Embed.state_complete = (state)->
  Embed.stop_timer() if state is 4
  return false if state is Embed.current_state
  Embed.current_state = state
  Embed.send_state()

Embed.send_state = ->
  src = Embed.get_state_url()
  f   = document.getElementsByTagName("img")[0]

  # don't add if already there
  return false unless f.src.indexOf(src) is -1

  # console.log "SENDING STATE: (#{Embed.current_state})"

  i = document.createElement("img")
  i.src = src
  f.parentNode.insertBefore(i, f)

Embed.interval = ->
  duration      = Embed.duration
  current_time  = Embed.player.getCurrentTime()
  
  percentage    = current_time / duration
  cutoff        = 0.24

  # 0-4 for 0%-100%
  state = Math.min(Math.max(Math.floor(percentage / cutoff),0),4)

  # console.log "#{current_time} / #{duration} = #{percentage} (#{state})"

  Embed.state_complete state







//= require variables
//= require helpers
//  
//= require swfobject
//= require embed_script


// // load youtube api
// (function(d,e,l){
// var t = d.createElement(e);
// t.src = l;
// var s = d.getElementsByTagName(e)[0];
// s.parentNode.insertBefore(t,s);
// }(window.document,'script','//www.youtube.com/iframe_api'));


// // when iframe_api is loaded and ready to be used
// function onYouTubeIframeAPIReady(){
//   Embed.player = new YT.Player(Embed.player_id ,{
//     height:   '100%',
//     width:    '100%',
//     videoId:  Embed.video,
//     events:   {
//       'onReady'       : onPlayerReady,
//       'onStateChange' : onPlayerStateChange
//     }
//   });
// };

// // when our video has been loaded in and is ready
// function onPlayerReady(playerId){
//   window.player_ready && window.player_ready(playerId);
//   window.player_is_ready  = true;
// };

// function onPlayerStateChange(newState){
//   console.log(newState);
//   switch(newState.data){
//     case 1:
//       Embed.play_begin();
//       break;
//     case 0:
//       Embed.play_complete();
//       break;
//   }
// };

// Embed.play_begin = function(){
//   console.log("Video Duration", Embed.player.getDuration());
// };

// Embed.play_complete = function(){
//   var src = Embed.tracking_url;
//   var f   = document.getElementsByTagName('img')[0];
  
//   // don't add if already there
//   if(f.src.indexOf(src) !== -1) return false;

//   var i = document.createElement('img');
//   i.src = src;
//   f.parentNode.insertBefore(i, f);
// };






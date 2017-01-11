# simple-pomodoro
Simple Linux bash script to give the user a little "low-tech" Pomodoro feedback. Enjoy!

Hi, this is my first public git commit project and I thought I'd share my little 
Pomodoro pride and joy. I run this in an Ubuntu environment and find it VERY useful.

If you are unfamiliar with the Pomodoro Technique, here is the link: http://cirillocompany.de/pages/pomodoro-technique

In a nutshell, this script set has grown to do the following:
* Display a toaster pop-up of the status of your pomodoro.
* Give the user an audio clue of what stage of the Pomodoro you are in. 
  Some light brown-noise to let you know you are still working.
  And some louder white noise to let you know to take your break.
* Also I use purple-remote to send the status of my Pomodoro out to my Pidgin IM client.
* I even included a trap to catch a ctrl-c and clean up all the statusii...statuses...whatever.

I hope this is helpful and would be interested in suggestions.

Thanks, Sean

Dependencies:
An active Pidgin instance plus the tool "purple-remote"
The desktop status popup tool, "notify-send"
The music/sound command "play"

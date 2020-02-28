# Lightsaber
 A cool lightsaber app made in SwiftUI

   Here's my Lightsaber app. I worked hard on animating the lightsaber to turn on and off (and matching the visuals with the sound).
   The saber part is actually not an image; it's a dynamically made view which allowed for me to change the color of the saber (try holding on the screen!)
   Onto the motion functions:
   - On/Off: Hold upright and tap to turn on, hold upside down and tap to turn off. To detect if the phone is vertical I used the device's percieved gravity vector (based on accelerometer). If the y value of the vector is below -9.5, then it is upright. If it it above 9.5, then it is upside down.
   - Swing: Took me a while to get the sounds not to overlap, but basically it checks if the magnitude of the acceleration is greater than an arbitrary amount (I just did a bunch of testing).
   - Clash: This one took me even longer because I tried to overcomplicate it, but then I realized all that has to be done is that if the dy/dx (difference between last acceleration and current acceleration) is above a certain amount (I found 2 to work well) then it will play the clash sound. This surprisingly works well.

   Bugs:
   - Don't ask me why, but after a while the clash sound will just stop working. Even though the sound isn't playing, the .isPlaying property returns true. You may ask "well why don't you just not check if it's playing?" Well I have to or else the sounds overlap. Not sure how to fix this
   - Sometimes, the app just crashes. This one makes no sense. I think it happens if too many sounds are played in rapid succession, either way it gives an error on the line of one of the audio player's .play() method calls.
   - Another one that makes no sense is that sometimes the swing sound can play while the saber is off. It does still seem linked to the device's motion, which makes no sense considering it should only run that code if isOn is true.

   As you can tell, I've never worked with AVAudioPlayer before. Also, the reason I have so many different player variables in the SaberManager is because the sound to be played is set on initialization (which takes processing time). Creating them all at once not only allows for the sounds to be played immediately when called instead of loaded again, but it also allows me to play multiple sounds at a time. This is how I fade the hum sound in when the saber is turned on, how I play the hum sound and the swing sound at the same time, and how I *play the swing sound and the crash sound at the same time* (yes of course I did the extra credit).

   Overall great assignment I rate 9.5/10

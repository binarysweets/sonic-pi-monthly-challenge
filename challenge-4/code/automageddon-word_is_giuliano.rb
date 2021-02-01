# Word is Giuliano
# 01000111 01101001 01110101 01101100 01101001 01100001 01101110 01101111

use_bpm 139
use_debug false
#Metronome 16th
in_thread do
  live_loop :metronome do
    cue :tick
    sleep 0.25
  end
end

#Metronome 8th
in_thread do
  live_loop :metronomeSlow do
    cue :tickHalf
    sleep 0.50
  end
end


#Variables

loop1 = [0,1,0,0,0,1,1,1,0,1,1,0,1,0,0,1]
loop2 = [0,1,1,1,0,1,0,1,0,1,1,0,1,1,0,0]
loop3 = [0,1,1,0,1,0,0,1,0,1,1,0,0,0,0,1]
loop4 = [0,1,1,0,1,1,1,0,0,1,1,0,1,1,1,1]

#Kick heavy
define :kick do
  with_fx :distortion do
    sample :bd_mehackit, mix: 0.6, distort: 0.5, amp: 0.7
  end
end

#Kick light
define :kicklight do
  sample :bd_mehackit, amp: 0.3
end


#KickGroove half
define :kicks do |n|
  live_loop :kick do
    16.times do |i|
      sync :tickHalf if n == 1
      sync :tick if n == 2
      stop if n == 0
      kick if loop1[i] == 0
      kicklight if loop1[i]== 1
    end
  end
end


#GlitchSound
define :glitch do
  with_fx :reverb do
    sample :glitch_perc4, amp: 0.7, pan: rrand(-0.25, 0.25), start: rrand(0, 0.5), sustain: rrand(0.1, 0.4), room: 7, rate: [-2, 1, 3].choose
  end
end

#Glitch groove
define :glitches do |n|
  live_loop :chh do
    rrand_i(4, 16).times do |i|
      sync :tick if n == 1
      stop if n == 0
      glitch if loop2 [i] == 1
    end
  end
end


#Bass Sound
define :bass do
  with_fx :bitcrusher do
    sample :bass_hard_c, amp: 0.2, attack: 0.5, release: 0.5
  end
end

#Bass groove
define :bass1 do |n|
  live_loop :bassline1 do
    16.times do |i|
      sync :tick if n == 1
      stop if n == 0
      bass if loop3 [i] == 0 if one_in (2)
    end
  end
end

#Bass SoundShort
define :bassShort do
  sample :bass_hit_c, amp: 1, pitch: +3
end

#Bass groove
define :bass2 do |n|
  live_loop :bassline2 do
    16.times do |i|
      sync :tick if n == 1
      stop if n == 0
      bassShort if loop4 [i] == 1
    end
  end
end

#Lead sound
define :lead do
  with_fx :reverb do
    with_fx :wobble do
      sample :loop_electric, start: rrand(0.1, 0.6), pitch: [1, 3, 5, -3].choose, amp: 1, attack: 0.25, sustain: 0, release: 0.25
    end
  end
end

#Lead synth
define :leads do |n|
  live_loop :lead do
    16.times do |i|
      sync :tick if n ==1
      stop if n ==0
      lead if loop4 [i] == 0
    end
  end
end


#kicks 1== slow; 2== fast; 0== stop
#glitches 0= stop; 1 play
#bass1 0= stop; 1 play
#bass2 0= stop; 1 play
#leads 0= stop; 1 play
#
### set the 0 below to 1 to play that pattern
bass2 0
glitches 0
kicks 0
bass1 0
leads 0

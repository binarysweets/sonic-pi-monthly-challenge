# Doggy naps
# 01000100 01101111 01100111 01100111 01111001 00100000 01101110 01100001 01110000 01110011

#Variables
loop1 = [0,1,0,0,0,1,0,0,0,1,1,0,1,1,1,1]
loop2 = [0,1,1,0,0,1,1,1,0,1,1,0,0,1,1,0]
loop3 = [0,1,1,1,1,0,0,1,0,0,1,0,0,0,0,0]
loop4 = [0,1,1,0,1,1,1,0,0,1,1,0,0,0,0,1]
loop5 = [0,1,1,1,0,0,0,0,0,1,1,1,0,0,1,1]

use_bpm 110
use_debug false

in_thread do
  live_loop :metronome do
    cue :tick
    sleep 1
  end
end

in_thread do
  live_loop :metronomeSlow do
    cue :tickHalf
    sleep 0.50
  end
end

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
    sample :glitch_perc4, amp: 1.7, pan: rrand(-0.25, 0.25), start: rrand(0, 0.5), sustain: rrand(0.1, 0.4), room: 7, rate: [-2, 1, 3].choose
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
    use_synth:fm
    play_pattern_timed [:f2,:d2],[0.25] , amp: 2,release:0.5
    #sample :bass_hard_c, amp: 0.2, attack: 0.5, release: 0.5
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
  sample :bass_hit_c, amp: 3, pitch: +3
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

###########################################

#synth chop
define :synthChop do
  with_transpose 0 do
    use_synth:tech_saws
    play_pattern_timed [:c3,:d4],[0.25] ,release:0.5 if one_in (2)
    play_pattern_timed [:c4,:d5,:r,:f5],[0.25] ,amp:0.5 ,release:0.5 if one_in (4)
  end
end

#Bass groove
define :synthchop do |n|
  live_loop :chops do
    16.times do |i|
      sync :tick if n == 1
      stop if n == 0
      synthChop if loop5 [i] == 1
    end
  end
end


amp_funky = 1
#amp_funky = 0
live_loop :funky do
  use_synth:piano
  use_synth_defaults release:0.025 ,amp: amp_funky
  with_transpose 0 do
    play_pattern_timed [:c3,:d4],[0.25] ,release:0.5
    play_pattern_timed [:c4,:d5,:r,:f5],[0.25] ,release:0.5 if one_in (4)
  end
  sleep 4
end

amp_funky2 = 1
#amp_funky2 = 0
live_loop :funky2 do
  #use_synth :tech_saws
  use_synth :piano
  use_synth_defaults release:0.025 ,amp: amp_funky2
  with_transpose 12 do
    play :c3
    sleep 4
    play_pattern_timed [:C3,:B2,:A2,:r],[1]
    play_pattern_timed [:r,:F2,:r],[0.25,0.75,3]
    play_pattern_timed [:C2,:r,:D2,:r],[0.25,0.5,1.25,2]
  end
end

amp_funky3 = 1
#amp_funky3 = 0
live_loop :funky3 do
  use_synth :piano
  use_synth_defaults release:0.025 ,amp: amp_funky3
  with_transpose 12 do
    play :c3
    sleep 4
    play_pattern_timed [:C3,:B2,:A2,:r],[1]
    play_pattern_timed [:r,:F2,:r],[0.25,0.75,3]
    play_pattern_timed [:C2,:r,:D2,:r],[0.25,0.5,1.25,2]
  end
end

# prophet
amp_sub_wave = 0.5
#amp_sub_wave = 0
live_loop :sub_wave do
  use_synth :tb303
  use_synth_defaults cuttoff: 70 ,lpf: 200 ,amp: amp_sub_wave ,release: 0.125
  with_fx :ixi_techno ,phase:0.25 do
    with_fx :distortion ,distort:0.5 do
      with_fx :pitch_shift, pitch_dis:0.01 do
        play_pattern_timed [:C3,:r,:D3,:r,:F3,:r,:r,:d3],[0.25]
        sleep 8
      end
    end
  end
end

# brass or synth ########################################################
amp_chord = 1.25
#amp_chord = 0
kick_cnt2 = 0
live_loop :synth_chord do
  use_synth :hoover
  use_synth_defaults cuttoff: 70 ,amp: amp_chord ,release: 0.5
  with_transpose 12 do
    with_fx :pitch_shift, pitch_dis:0.01 do
      with_fx :echo do
        sleep 1
        play_chord (ring :A3, :D4)
        sleep 0.75
        play_chord (ring :A3, :A4)
        sleep 1.5
        play_chord (ring :A3, :E4)
        sleep 0.75
        play_chord (ring :A3, :F4)
        sleep 1.5
        if (kick_cnt2%4 == 0) then
          play_chord (ring :A3, :G4)
        else
          play_chord (ring :A3, :E4)
        end
        sleep 2.5
      end
      kick_cnt2 += 1
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
synthchop 1
bass2 1
glitches 1
kicks 1
bass1 1
leads 1

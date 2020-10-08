# Sonic Pi Monthly Challenge #1 (October 2020)
# Toad Mode By Binarysweets
# Sample used: https://freesound.org/people/bbmario/sounds/107919/

# Settings
use_bpm 150
use_random_seed 20201005
freesound_sample = "?/107919__bbmario__puti32.wav"
mode = :diatonic
set :scl, scale(:cs2, mode, num_octaves: 2)
sample_base_note = 57
swing = (ring 0.01, -0.01)

# Functions
define :get_pitch_from_note do |note, base_note|
  return note - base_note
end

# Loops
live_loop :melody_part do ; tick
  scl = get :scl
  notes = (ring 8,9,10,11,12,13,14,15).repeat(3) +
    (ring 8,9,10,11,12,13,14,15).reverse
  notes2 = (ring 1,2,3,4,5,6,7,8)
  
  sample_start = [0.2]
  sample_finish = [0.3]
  
  if one_in 8
    sample_start = [0.1,0.2,0.3]
    sample_finish = [0.1,0.2,0.3]
  end
  
  with_fx :eq, low_note: 59, low: -0.2 do
    sample freesound_sample,
      rpitch: get_pitch_from_note(scl[notes.look], sample_base_note),
      amp: rrand(1, 1.2),
      pan: 0.5,
      start: sample_start.choose,
      finish: sample_finish.choose if bools(1,0,0,0, 1,0,0,0, 1,1,0,1, 0,1,0,0).look
    
    sample freesound_sample,
      rpitch: get_pitch_from_note(scl[notes2.look], sample_base_note),
      amp: rrand(1, 1.2),
      pan: 0.5,
      start: sample_start.choose,
      finish: sample_finish.choose if bools(0,1,1,0, 1,0,0,1, 1,0,0,1, 0,1,0,1).look
        
    #with_fx :wobble, phase: 0.125 do
    #  with_fx :echo, decay: 8, mix: 0.2 do
    #    sample freesound_sample,
    #      rpitch: get_pitch_from_note(scl[notes.look], sample_base_note - [24, 12].choose),
    #      amp: rrand(0.7, 0.9),
    #      pan: -0.7,
    #      start: sample_start.choose,
    #      finish: sample_finish.choose if bools(1,0,0,1, 0,0,0,0, 0,1,0,1, 0,1,0,1).look
    #  end
    #end
  end
  
  sleep 0.25 + swing.look
end

live_loop :chord_part do ; tick
  scl = get :scl
  
  chords = (chord_degree (ring 2,1,2,5, 2,3,7,4).look, scl[8], mode, 5)
  with_fx :eq, low_note: 59, low: -0.5 do
    chords.each do |note|
      with_fx :echo, decay: 8, phase: 0.5 do
        sample freesound_sample,
          rpitch: get_pitch_from_note(note, sample_base_note),
          amp: rrand(0.3, 0.4),
          pan: -0.4,
          start: 0.2
      end
    end
    
    sleep 4 + swing.look
  end
end

live_loop :low_part do ; tick
  notes = (ring 1,1,1,1, 2,3,4,5)
  scl = get :scl
  
  with_fx :eq, low_note: 59, low: -0.5 do
    with_fx :lpf, cutoff: (line 50, 80, steps: 32).mirror.look do
      with_fx :tanh, krunch: 10 do
        sample freesound_sample,
          rpitch: (get_pitch_from_note scl[notes.look], sample_base_note),
          pan: -0.8,
          amp: rrand(1.2, 1.4)
      end
    end
  end
  
  sleep 2 + swing.look
end

live_loop :high_part do ; tick
  notes = (ring 12,10,7,11)
  scl = get :scl
  
  with_fx :ping_pong do
    sample freesound_sample,
      rpitch: (get_pitch_from_note scl[notes.look], sample_base_note - 12),
      amp: rrand(0.4, 0.6),
      start: 0.3,
      finish: 0.4
    
    sleep 0.5 + swing.look
  end
end

live_loop :scale_changer do
  sleep 32
  
  set :scl, scale((ring :cs2, :d2).tick, mode, num_octaves: 2)
end
# Sonic Pi Monthly Challenge #1 (October 2020)
# Toad Mode By Binarysweets
# Sample used: https://freesound.org/people/bbmario/sounds/107919/

# Settings
use_bpm 150
use_random_seed 20201005
bar_length = 4
freesound_sample = "?/107919__bbmario__puti32.wav"
mode = :diatonic
set :scl, scale(:cs2, mode, num_octaves: 2)
sample_base_note = 57
swing = (ring 0.01, 0.02, -0.02, -0.01)

# Functions
define :get_pitch_from_note do |note, base_note|
  return note - base_note
end
define :bar do |length = 8|
  sleep bar_length * length
end

# Loops
define :melody_part do |length = 8, part = 1|
  in_thread do
    scl = get :scl
    notes = (ring 8,9,10,11,12,13,14,15).repeat(3) +
      (ring 8,9,10,11,12,13,14,15).reverse
    
    notes2 = (ring 1,2,3,4,5,6,7,8)
    
    sample_start = 0.2
    sample_finish = 0.3
    
    with_fx :eq, low_note: 59, low: -0.2 do
      ((bar_length * length) * 4).times do ; tick
        
        if one_in 8
          sample_start = 0.3
          sample_finish = [0.1, 0.2].choose
        end
        
        sample freesound_sample,
          rpitch: get_pitch_from_note(scl[notes.look], sample_base_note),
          amp: rrand(1, 1.2),
          pan: 0.5,
          start: sample_start,
          finish: sample_finish if bools(1,0,0,0, 1,0,0,0, 1,1,0,1, 0,1,0,0).look
        
        sample freesound_sample,
          rpitch: get_pitch_from_note(scl[notes2.look], sample_base_note),
          amp: rrand(1, 1.2),
          pan: 0.5,
          start: sample_start,
          finish: sample_finish if bools(0,1,1,0, 1,0,0,1, 1,0,0,1, 0,1,0,1).look
        
        if part == 2
          with_fx :wobble, phase: 0.125 do
            with_fx :echo, decay: 8, mix: 0.2 do
              sample freesound_sample,
                rpitch: get_pitch_from_note(scl[notes.look], sample_base_note - [24, 12].choose),
                amp: rrand(0.7, 0.9),
                pan: -0.5,
                start: sample_start,
                finish: sample_finish if bools(1,0,0,1, 0,0,0,0, 0,1,0,1, 0,1,0,1).look
            end
          end
        end
        
        sleep 0.25 + swing.look
      end
    end
  end
end

define :chord_part do |length = 8|
  in_thread do
    scl = get :scl
    
    with_fx :eq, low_note: 59, low: -0.5 do
      ((bar_length * length) / 4).times do ; tick
        chords = (chord_degree (ring 2,1,2,5, 2,3,7,4).look, scl[8], mode, 5)
        
        chords.each do |note|
          with_fx :echo, decay: 8, phase: 0.5 do
            sample freesound_sample,
              rpitch: get_pitch_from_note(note, sample_base_note),
              amp: rrand(0.4, 0.5),
              pan: -0.5,
              start: 0.2
          end
        end
        
        sleep 4 + swing.look
      end
    end
  end
end

define :low_part do |length = 8|
  in_thread do
    notes = (ring 1,1,1,1, 2,3,4,5)
    scl = get :scl
    idx = get[:low_part_counter]
    
    with_fx :eq, low_note: 59, low: -0.5 do
      ((bar_length * length) / 2).times do ; tick
        idx += 1
        with_fx :lpf, cutoff: (line 60, 100, steps: 64)[idx] do
          with_fx :tanh, krunch: 15 do
            sample freesound_sample,
              rpitch: (get_pitch_from_note scl[notes.look], sample_base_note),
              pan: -0.5,
              amp: rrand(0.7, 0.8)
          end
        end
        
        sleep 2 + swing.look
        set :low_part_counter, idx
      end
    end
  end
end

define :high_part do |length = 8|
  in_thread do
    notes = (ring 12,10,7,11)
    scl = get :scl
    
    with_fx :ping_pong do
      ((bar_length * length) * 2).times do ; tick
        sample freesound_sample,
          rpitch: (get_pitch_from_note scl[notes.look], sample_base_note - 12),
          amp: rrand(0.4, 0.5),
          start: 0.3,
          finish: 0.4
        
        sleep 0.5 + swing.look
      end
    end
  end
end

define :endbar_part do |length = 8|
  in_thread do
    scl = get :scl
    
    with_fx :wobble, phase: 0.01 do
      with_fx :bitcrusher, bits: 4 do
        ((bar_length * length) * 2).times do ; tick
          sample freesound_sample,
            rpitch: (get_pitch_from_note scl[0], sample_base_note - 12),
            amp: 0.2,
            start: 0.3,
            finish: 0.4
          
          sleep 0.25 + swing.look
        end
      end
    end
  end
end

# Reset globals
set :low_part_counter, 0

# Structure
with_fx :compressor, threshold: 0.2, pre_amp: 2 do
  endbar_part(1) ; bar (1)
  low_part ; bar
  low_part(7) ; bar(7) ; endbar_part(1) ; bar (1)
  low_part ; melody_part ; bar
  low_part ; melody_part(7) ; bar
  melody_part ; high_part ; bar
  melody_part ; high_part ; bar
  set :scl, scale(:d2, mode, num_octaves: 2)
  melody_part(7,1) ; chord_part ; bar
  melody_part(8,2) ; chord_part ; bar
  set :scl, scale(:cs2, mode, num_octaves: 2)
  melody_part(8,2) ; chord_part ; high_part ; bar
  melody_part(7,2) ; chord_part(7) ; high_part(7) ; bar(7) ; endbar_part(1) ; bar (1)
  set :scl, scale(:d2, mode, num_octaves: 2)
  melody_part ; high_part ; bar
  melody_part(8,2) ; high_part ; bar
  high_part ; bar
end

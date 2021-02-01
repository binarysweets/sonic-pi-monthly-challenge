# Sonic Pi Challenge #4 - Text > Binary > Music
# Coded by Binarysweets, Jan 2021
# Sonic Pi v3.2.2 (Win10)

# Settings
use_bpm 150
use_tuning :meantone
use_random_seed 20210107
mode = :augmented
scl = scale(:a1, mode, num_octaves: 4)
swing = (ring 0.05,-0.05)

# Loops
live_loop :metronome do
  sleep 1
end

live_loop :lead, sync: :metronome do ; tick
  # COVID-19
  steps = [0,1,0,0,0,0,1,1, 0,1,0,0,1,1,1,1, 0,1,0,1,0,1,1,0, 0,1,0,0,1,0,0,1,
           0,1,0,0,0,1,0,0, 0,0,1,0,1,1,0,1, 0,0,1,1,0,0,0,1, 0,0,1,1,1,0,0,1].ring.reverse
  notes = [12,15,15,15, 12,15,15,15, 14,15,16,17, 18,19,20,21, 22,23,24,25,
           21,14,14,7, 9,10].ring.mirror
  
  with_fx :echo, mix: 0.1 do
    with_fx :bitcrusher, bits: 8, sample_rate: [10000,1000].choose do
      with_synth :tri do
        play scl[notes.tick(:n)],
          amp: 0.6,
          pan: [0.2,-0.2].choose,
          attack: 0,
          sustain: ((ring 0.125,0.25,0.5).repeat(8)+(ring 2)).tick(:s),
          decay: 0,
          release: 0.125 if steps.look > 0
      end
    end
  end
  
  sleep 0.25 + swing.look
end

live_loop :chords, sync: :metronome do ; tick
  # NHS
  steps = [0,1,0,0,1,1,1,0, 0,1,0,0,1,0,0,0, 0,1,0,1,0,0,1,1].ring.reverse
  notes = (ring 6,8,9).reflect.repeat(2)+(ring 10,10,9)
  
  with_fx :bitcrusher, bits: 8, sample_rate: [10000,1000].choose do
    with_synth :tri do
      play (chord scl[notes.tick(:n)], 'm+5'),
        amp: 0.7,
        pan: -0.2,
        attack: 0,
        sustain: steps.look,
        decay: 0,
        release: 3 if steps.look > 0
    end
  end
  
  sleep 2 + swing.look
end

live_loop :bass, sync: :metronome do ; tick
  # Mask
  steps = [0,1,0,0,1,1,0,1, 0,1,1,0,0,0,0,1,
           0,1,1,1,0,0,1,1, 0,1,1,0,1,0,1,1]
  notes = (ring 1,3,2,4)
  
  with_synth :tri do
    play scl[notes.tick(:n)],
      amp: 0.3,
      attack: 0,
      sustain: 2,
      release: 0 if steps.look > 0
  end
  
  sleep 2 + swing.look
end

live_loop :percussion, sync: :metronome do ; tick
  # Lockdown
  steps = [0,1,0,0,1,1,0,0, 0,1,1,0,1,1,1,1, 0,1,1,0,0,0,1,1, 0,1,1,0,1,0,1,1,
           0,1,1,0,0,1,0,0, 0,1,1,0,1,1,1,1, 0,1,1,1,0,1,1,1, 0,1,1,0,1,1,1,0]
  
  with_fx :hpf, cutoff: (line 90, 80, steps: 64).mirror.look do
    with_fx :ping_pong do
      with_synth :cnoise do
        play :c4,
          amp: 1,
          attack: 0,
          sustain: 0.125,
          decay: 0,
          release: 0 if steps.look > 0
      end
    end
  end
  sleep 0.5 + swing.look
end

live_loop :vaccine, sync: :metronome do ; tick
  stop
  # Vaccine
  steps = [0,1,0,1,0,1,1,0, 0,1,1,0,0,0,0,1, 0,1,1,0,0,0,1,1, 0,1,1,0,0,0,1,1,
           0,1,1,0,1,0,0,1, 0,1,1,0,1,1,1,0, 0,1,1,0,0,1,0,1].ring.reverse
  notes = (ring 12,13,14,15)
  
  with_fx :bitcrusher, bits: 8, sample_rate: (line 500, 100, steps: 128).look do
    with_synth :tri do
      play scl[notes.tick(:n)],
        amp: 0.5,
        pan: (ring -0.5,-0.4,-0.3,-0.2, 0.2,0.3,0.4,0.5).mirror.tick(:p),
        attack: 0,
        sustain: (ring 0.75,0.75,0.75,0.5).tick(:s),
        release: 0.125 if steps.look > 0
    end
  end
  
  sleep 0.25 + swing.look
end

live_loop :beats, sync: :metronome do ; tick
  sample :bd_ada, amp: 1.2
  
  sleep 1 + swing.look
end

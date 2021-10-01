use_debug false
use_cue_logging false

#set :rootNote, 30
defonce :setRootNoteStart do
  set :rootNote, 30
end

setRootNoteStart()

live_loop :rootSetter do
  tick
  if get(:rootNote) > 130
    set :rootNote, 30
    tick_reset
  else
    set :rootNote, get(:rootNote) + look
  end
  sleep 4
end

define :getNotes do | var, x |
  tempArray = []
  x.times do
    tempArray.append(get(:rootNote) + rand(var))
  end
  return tempArray
end

define :getSleeps do | x |
  sls = []
  x.times do
    sls.append([0.125, 0.25, 0.5, 0.75, 1, 2].sample)
  end
  return sls
end

live_loop :s1 do
  tick
  if tick > 100
    tick_reset
  end
  use_synth :piano
  with_fx :reverb, damp: range(0, 0.5, 0.05).mirror.look, room: range(0.1, 0.9, 0.05).mirror.look do
    play_pattern_timed getNotes(rand(5)+1, 5), getSleeps(4), amp: range(0.2, 0.8, 0.01).ramp.look
  end
end

live_loop :s2 do
  tick
  use_synth :fm
  with_fx :distortion, distort: range(0.1, 0.9, 0.01).mirror.look, mix: range(0.1, 0.8, 0.03).mirror.look do
    with_fx :hpf, cutoff: range(0.1, 129, 0.5).mirror.look, mix: 0.8 do
      
      play_pattern_timed getNotes(3, 7), getSleeps(5), amp: range(0, 1, 0.01).mirror.look
    end
  end
end

live_loop :s3 do
  tick
  use_synth [:tri, :pretty_bell, :sine, :saw, :hoover].sample
  with_fx :ping_pong, feedback: range(0.1, 0.6, 0.1).to_a.sample, phase: [0.111, 0.333, 0.666, 0.999].sample, mix: rand(10) / 10.0 do
    play range(get(:rootNote) - 10, get(:rootNote) - 9, 0.01).to_a.sample, amp: range(0.2, 0.6, 0.05).mirror.look
    sleep [0.25, 0.5, 0.75, 1, 1.5, 2].sample
  end
end

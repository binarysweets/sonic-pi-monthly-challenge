# sample '456833__florianreichelt__interior-sound-of-a-bus'

use_bpm 120


define :playsample do |time, duration, amp, rate|
  d = $mymusicpath + "etc/interior-bus/"
  s = "bus.ogg"
  l = bt(sample_duration(d + s))
  #puts "duration " + l.to_s
  x1 = time / l
  x2 = x1 + duration / l
  if x2 > 1.0 then
    x2 = 1.0
  end if
  #puts x1.to_s + ", " + x2.to_s
  sample d, s, amp: amp, start: x1, finish: x2, rate: rate, release: 0.0
end

live_loop "start" do
  set(:barNo, 0)
  sync "null"
end


live_loop "bar" do
  #Testing individual loops
  #set(:barNo, 0)
  #cue "1"
  
  
  barNo = get(:barNo)
  if !barNo then
    barNo = 0
  end
  
  puts "bar " + barNo.to_s
  
  #Foreground
  if true then
    if barNo > 8 and barNo < 24 then
      
      if dice(6) > 3 then
        cue "1"
      end
      if dice(6) > 3 then
        cue "2"
      end
      if dice(6) > 4 then
        cue "3"
      end
      if dice(6) > 4 then
        cue "4"
      end
      if dice(6) > 4 then
        cue "vowel"
      end
      if dice(6) > 5 then
        cue "oh"
      end
      if dice(6) > 3 then
        cue "sampler"
      end
      if dice(6) > 3 then
        cue "percussion"
      end
    end
  end
  
  #Background
  if true then
    cue "drone"
    if barNo > 0 and barNo < 32 then
      if barNo > 2 then
        cue "throb"
      end
      if barNo > 4 then
        cue "note"
      end
      if barNo > 8 then
        cue "low"
      end
    end
  end
  
  barNo = barNo+1
  set :barNo, barNo
  sleep 8
end


live_loop "1" do
  sync "/cue/1"
  with_fx :echo, phase: 1.5, decay: 50, mix: 0.5 do
    sleep 4
    playsample(22.65, 2.0, 1.5, 1)
  end
  sleep 8
end

live_loop "2" do
  sync "/cue/2"
  with_fx :echo, phase: 1.5, decay: 50, mix: 0.5 do
    sleep 6
    playsample(34.2, 0.5, 1.5, 1)
  end
  sleep 8
end

live_loop "3" do
  sync "/cue/3"
  with_fx :echo, phase: 1.5, decay: 100, mix: 0.5, amp: 0.02 do
    with_fx :nbpf, res: 0.7 do |bpf|
      i = 0
      16.times do
        control bpf, centre: 50 + i
        i = i + 4
        playsample(34.093, 0.2, 2.0, 1)
        sleep 0.5
      end
    end
  end
end

live_loop "4" do
  sync "/cue/4"
  sleep 2.0
  with_fx :reverb, room: 0.8, damp: 0.1 do
    with_fx :echo, phase: 1.5, decay: 30, mix: 0.5 do
      with_fx :bpf, centre: 70 do
        3.times do
          playsample(7.0, 0.4, 4.0, 1)
          sleep 3
        end
      end
    end
  end
end

live_loop "note" do
  sync "/cue/note"
  vs = [2,3,4].ring.tick
  p  = [0,-12, -24].ring.tick("p")
  v  = [1.5, 1.7, 2].ring.tick("v")
  with_fx :pitch_shift, pitch: p do
    with_fx :vowel do |vowel|
      8.times do
        control vowel, vowel_sound: vs, voice: 4
        playsample(8.33, 0.4, v, 0.2)
        sleep 1
      end
    end
  end
end

live_loop "vowel" do
  sync "/cue/vowel"
  rates = [0.15, 0.12, 0.17].ring
  volume = rrand(0.8, 1.0)
  with_fx :pan, pan: [-0.8, 0.8].ring.tick("pan") do
    with_fx :echo, phase: 1.5, decay: 3, mix: 0.1 do
      with_fx :vowel do |vowel|
        8.times do
          control vowel, vowel_sound: [1,2,3,4,5].ring.tick("vowel")
          playsample(8.33, 0.4, volume, rates.tick("rates"))
          sleep 1
        end
      end
    end
  end
end

live_loop "drone" do
  sync "/cue/drone"
  in_thread do
    with_fx :slicer, phase: 1.0/6, amp_min: 1, amp_max: 3, wave: 2 do
      with_fx :bpf, res: 0.8 do |filter|
        16.times do
          control filter, centre: 60 + 20 * Math::sin(vt/2.0)
          playsample(33.1, 0.25, 0.8, 0.4)
          sleep 0.5
        end
      end
    end
  end
  sleep 1
end


live_loop "oh" do
  sync "/cue/oh"
  notes = [:C4, :E4, :Gb4, :C5, :Eb5].ring
  n = [32, 16, 8].ring.tick("n")
  rhythm = [0.25, 0.33, 0.75].ring
  r = rhythm.tick
  with_fx :autotuner do |at|
    n.times do
      control at, note: notes.tick("notes")-12
      playsample(34.02, 0.4, 0.3, 1.0)
      sleep r
    end
  end
end

live_loop "throb" do
  sync "/cue/throb"
  in_thread do
    with_fx :pitch_shift, pitch: -24 do
      with_fx :slicer, phase: 1.0 do
        with_fx :vowel do |vowel|
          8.times do
            control vowel, vowel_sound: 3, voice: [1,2,3,4].tick
            playsample(8.33, 0.3, 5, 0.2)
            sleep 1
          end
        end
      end
    end
  end
end


live_loop "sampler" do
  sync "/cue/sampler"
  
  #Advance through the sample
  t = get(:hightime)
  if !t then
    t = 0.5
  end
  t = t + 3.3847
  if t > 37 then
    t = 0.0
  end
  set :hightime, t
  
  in_thread do
    with_fx :compressor, mix: 1.0, threshold: 0.2, amp: 3.0 do
      with_fx :lpf do |filter|
        24.times do
          control filter, cutoff: 60 + 40 * Math::sin(vt/3.0)
          playsample(t, 0.3, 2, 4)
          sleep 1.0/3
        end
      end
    end
  end
  sleep 1
end

live_loop "low" do
  sync "/cue/low"
  a = rrand(0.5, 1)
  with_fx :echo, mix: 0.7, phase: 3.0, decay: 10.0 do
    playsample(1.192, 0.2, 1, 0.2)
  end
  sleep 16
end

live_loop "percussion" do
  sync "/cue/percussion"
  
  with_fx :reverb do
    with_fx :echo, mix: 0.3, phase: 1.0/3 do
      #Clave-ish
      in_thread do
        with_fx :nbpf, centre: 80, res: 0.7, amp: 0.05 do |bpf|
          5.times do
            clave = [0.0, 1.5, 2.0, 1.0, 1.5].ring
            sleep clave.tick
            control bpf, centre: 80 + 10 * Math::sin(2*vt/3.14)
            playsample(21.95, 0.08, 1.0, 0.75)
          end
        end
      end
      
      #Hihat-ish
      in_thread do
        4.times do
          sleep 1
          playsample(37.817, 0.8, 0.5, 1.0)
          sleep 1
        end
      end
      
      #Boom
      in_thread do
        with_fx :nbpf, centre: 20, amp: 0.2 do
          playsample(37.221, 0.03, 1.0, 0.1)
        end
      end
      
    end
  end
end

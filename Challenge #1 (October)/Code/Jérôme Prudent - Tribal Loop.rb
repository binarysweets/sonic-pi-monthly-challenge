# Copyleft - Jérôme Prudent
# https://in-thread.sonic-pi.net/t/sonic-pi-monthly-challenge-1/4442
# Sonic Pi monthly challenge : "Make any piece of sound from a single sample"
# The sample for this piece is downloadable at https://freesound.org/people/Kyster/sounds/140615/

sample_path = "/home/jerome/p/songs/Library/Sound FX & Scratches/bottle-cork-in-and-out-2012-1-4.wav"
sample_d = sample_duration(sample_path)
puts "sample duration #{sample_d}"

define :sample_slicer do |start_end|
  start_end.collect { |x| (sample_d - x) / sample_d }
end

percu = sample_slicer([3.49, 3.23])
puts "percu : #{percu}"

t1 = 1.0
t2 = t1 / 2
t4 = t2/ 2
t8 = t4/ 2

b = bass = 0.5
m = medium = 0.75
h = high = 1
r = repos = 0
rs = [
  #0
  (ring b, b, m, m,  b, b, h, h, b, b, m, m, b, b, h, h),
  (ring b, r, m, m,  r, r, h, r),
  (ring b, r, m, m,  r, b, h, r,  b, r, r, m,  b, b, m, r),
  (ring b, m, m, r,  b, r, h, h,  b, h, r, h,  b, r, h, h),
  #4
  (ring h, r, r, h,  h, r, m, m),
  (ring b, r, r, b,  b, r, m, m),
  (ring h, r, r, h,  h, r, b, r,  h, r, m, m,  h, r, b, r),
  (ring b, b, m, m,  b, b, h, h,  b, b, m, m,  b, b, h, h),
  #8
  (ring b, r, m, m,  b, h, h, r,  b, r, m, m,  b, h, h, r),
  (ring m, m, r, h,  m, m, h, r,  m, m, h, r,  m, m, h, r),
  
]

set :timbre, rs.first
set :rythm, (ring t8)
set :chord, (chord knit(0, 20, 3, 1).choose, knit(:m7, 3, :dim7, 2, :dom7, 1).tick(:x))

live_loop :ticks do |cpt|
  use_bpm 100
  sleep t8+0.001
  set :guiro, false
  if (factor?(cpt, 10 * 16))
    x = rs.tick(:rs)
    puts "Change rythm #{x}"
    set :timbre, x
    set :rythm, (ring t8)
  end
  if (factor?(cpt, 16))
    ch = (chord knit(0, 9, 3, 1).choose, knit(:m7, 3, :dim7, 2, :dom7, 1).tick(:x))
    puts "Change chord #{x}"
    set :chord, ch
  end
  if (factor?(cpt, [4,8].choose*16 + 8))
    set :guiro, true
  end
  
  cpt += 1
end

#you can change the pattern easily

with_fx :lpf do
  with_fx :distortion do
    live_loop :percu do
      sync :ticks
      timbre = get :timbre
      t =  timbre.tick(:timbre)
      cutoff = 90
      if (factor?(look(:timbre), 4))
        puts look(:timbre)
        cutoff = 120
      end
      p = false
      if (t != repos)
        p = sample sample_path, amp: 1, start: percu[0], finish: percu[1],
          rate: t, cutoff: cutoff
      end
      rythm = get :rythm
      r = rythm.tick(:rythm)
      
      sleep r
    end
  end
end

live_loop :fast_tictictic do
  sync :ticks
  speed = knit(0, 2, 1, 2, 2, 1).choose
  probability = (knit true, 2, false, 1)
  with_fx :hpf do
    t = (sync :current_rythm) - 0.001
    speed.times do
      sample sample_path, amp: 1, start: percu[0], finish: percu[1], rate: 8
      sleep t / speed
    end
  end
end

with_fx :reverb do
  live_loop :melody do
    sync :ticks
    if ((ring true, true, false, false).tick(:p))
      ch = get :chord
      a, b, c = ch
      if(one_in(3))
        puts "reverse"
        ch = ch.reverse
      end
      
      n = t8 / (ring 2, 1, 1, 1, 1, 1, 1, 1, 1).tick(:n)
      sample sample_path, amp: 1, start: percu[0], finish: percu[1], rate: 2, rpitch: a
      sleep n
      sample sample_path, amp: 1, start: percu[0], finish: percu[1], rate: 2, rpitch: b
      sleep n
      sample sample_path, amp: 1, start: percu[0], finish: percu[1], rate: 2, rpitch: c
      sleep n
    end
  end
end

guiro1 = sample_slicer([3.783, 3.497])
puts "guiro1 : #{guiro1}"

guiro2 = sample_slicer([sample_d, 4.016])
puts "guiro2 : #{guiro2}"

scratch = sample_slicer([0.834, 0.3])
puts "scratch : #{scratch}"

live_loop :guiro2 do
  s, e = [guiro1, guiro2, scratch].tick(:g)
  if(sync :guiro)
    with_fx :ping_pong do
      with_fx :hpf do
        s = sample sample_path, amp: 1, start: s, finish: e, rate: 0.5
      end
    end
  end
end

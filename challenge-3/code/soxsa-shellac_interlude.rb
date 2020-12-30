#Sonic Pi Challenge Dec 2020
#SOXSA
#Shellac Interlude

set_volume! 5
use_bpm 78
sleep 3

use_synth :noise
with_fx :bpf, centre: 80, amp: 0.5 do
  play :e4, sustain: 0.05, release: 0.0
end

live_loop :surfacenoise do
  if tick < 140 then
    use_synth :noise
    with_fx :bpf, centre: 80 do
      play :e4, amp: 0.1, sustain: 1.0
    end
    sleep 0.6
    with_fx :bpf, centre: 30 do
      play :e4, amp: 0.6, sustain: 1.0
    end
    sleep 0.4
  else
    sleep 1
  end
end


x=0.43
y=0.1
z=0.9
live_loop :scratches do
  if tick>5 and look<110 then
    x = rrand(0.0,1.0) if one_in(13)
    y = rrand(0.0,1.0) if one_in(17)
    z = rrand(0.0,1.0) if one_in(19)
    with_fx :bpf, centre: 80, amp: 8.0 do
      at x do
        sample :ambi_swoosh, beat_stretch: 0.01, amp: 0.5
      end
      at y do
        sample :ambi_swoosh, beat_stretch: 0.02, amp: 0.1
      end
      at z do
        sample :ambi_swoosh, beat_stretch: 0.04, amp: 0.1
      end
    end
  end
  sleep 1
end

live_loop :randomnoises do
  if tick<110 and one_in(7) then
    sleep rrand(0.1,1.0)
    use_synth :noise
    with_fx :bpf, centre: 80, amp: rrand(0.3,0.5) do
      play :e4, sustain: 0.05, release: 0.0
    end
  end
  sleep 1
end

live_loop :choir do
  if tick>8 and look<100 then
    with_fx :reverb, mix: 0.8, damp: 0.1 do
      with_fx :nbpf, centre: 80, amp: 0.1 do
        a=[3,4,3,2,6,6,2,8,4].ring.look + rrand(0.0,0.1)
        sample :ambi_choir, amp: 0.1, beat_stretch: a
      end
    end
  end
  sleep 1
end

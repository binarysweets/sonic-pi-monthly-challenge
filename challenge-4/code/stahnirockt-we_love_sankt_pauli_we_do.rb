# We love Sankt Pauli - we do!
# Sonic Pi Challange Number 4

live_loop :progressionLoop do
  tick(:proTick)
  $a_chord = ring(chord(:D, :maj), chord(:b, :min), chord(:G, :maj), chord(:A, :maj)).tick
  $bar = look(:proTick)
  puts $bar
  sleep 4
end


live_loop :beat_quater do
  tick(:beat_tick)
  #stop
  #we 01110111 01100101
  if $bar >= 4 and $bar <21
    sample :bd_haus if bools(0,1,1,1,0,1,1,1,0,1,1,0,0,1,0,1).reverse.look(:beat_tick)
  end
  #love 01101100 01101111 01110110 01100101
  if $bar >= 4 and $bar <31
    sample :drum_cymbal_closed if bools(0,1,1,0,1,1,0,0,0,1,1,0,1,1,1,1,0,1,1,1,0,1,1,0,0,1,1,0,0,1,0,1).look(:beat_tick)
  end
  if $bar >= 4 and $bar <21
    sample :bd_tek, pan: 0.25 if bools(0,1,0,0,0,0,1,1).reverse.look(:beat_tick)
  end
  #F 01000110 (0,1,0,0,0,1,1,0)
  #C 01000011 (0,1,0,0,0,0,1,1)
  #S 01010011 (0,1,0,1,0,0,1,1)
  #sample :drum_snare_soft if bools(0,1,0,1,0,0,1,1).look(:beat_tick)
  #P 01010000 (0,1,0,1,0,0,1,1)
  sleep 0.25
end

live_loop :beat_full do
  tick(:b_full)
  sample :bd_mehackit if bools(1,1,1,1,1,1,0,1).look(:b_full) if $bar >= 1 and $bar <33
  #Sankt 01010011 01100001 01101110 01101011 01110100
  with_fx :pan, pan: 0.5 do
    with_fx :slicer, phase: 0.75, pulse_width: 0.75 do
      with_fx :bitcrusher, bits: 32, sample_rate: 15000, cutoff: 100 do
        sample :elec_blip, rate: 0.125, amp: 10 if bools(0,1,0,1,0,0,1,1,0,1,1,0,0,0,0,1,0,1,1,0,1,1,1,0,0,1,1,0,1,0,1,1,0,1,1,1,0,1,0,0).look(:b_full) if $bar < 4 or ($bar >= 24 and $bar < 33)
      end
    end
  end
  #F 01000110 (0,1,0,0,0,1,1,0)
  #C 01000011 (0,1,0,0,0,0,1,1)
  #S 01010011 (0,1,0,1,0,0,1,1)
  sample :drum_snare_soft if bools(0,1,0,1,0,0,1,1).rotate(1).look(:b_full) if $bar >= 2 and $bar <33
  #P 01010000 (0,1,0,1,0,0,1,1)
  sleep 0.5
end

live_loop :beat_eights do
  #stop
  #Pauli 01010000 01100001 01110101 01101100 01101001
  if $bar >= 6 and $bar <25
    sample :drum_cymbal_closed if bools(0,1,0,1,0,0,0,0,0,1,1,0,0,0,0,1,0,1,1,1,0,1,0,1,0,1,1,0,1,1,0,0,0,1,1,0,1,0,0,1).tick(:b_eights)
  end
  sleep 0.125
end

live_loop :bass do
  with_random_seed 1910 do
    #we 01110111 01100101
    16.times do
      if bools(0,1,1,1,0,1,1,1,0,1,1,0,0,1,0,1).reverse.rotate(2).tick(:bs_tick)
        with_fx :reverb, room: 0.25, mix: 0.3 do
          synth :fm, note: $a_chord.choose+[-24,-24,-12,-24].choose, release: 0.2, amp: 3 if $bar >= 4 and $bar <25
        end
      end
      sleep 0.125
    end
  end
end

live_loop :melody do
  #stop
  if $bar >= 8 and $bar <21
    with_fx :ixi_techno, cutoff_max: 110, cutoff_min: 90, res: 0.7, phase: 0.75 do
      64.times do
        tick(:mel_tick)
        synth :pluck, release: 0.5, amp: 2, note: $a_chord[0] if bools(0,1,1,1,0,1,1,1,0,1,1,0,0,1,0,1).reverse.look(:mel_tick)
        synth :pluck, release: 0.5, amp: 2, note: $a_chord[1] if bools(0,1,1,0,1,1,0,0,0,1,1,0,1,1,1,1,0,1,1,1,0,1,1,0,0,1,1,0,0,1,0,1).rotate(1).look(:mel_tick)
        synth :pluck, release: 0.5, amp: 2, note: $a_chord[2] if bools(0,1,0,1,0,0,1,1,0,1,1,0,0,0,0,1,0,1,1,0,1,1,1,0,0,1,1,0,1,0,1,1,0,1,1,1,0,1,0,0).look(:mel_tick)
        #synth :pluck, release: 0.5, amp: 2, note: $a_chord[3] if bools(0,1,0,1,0,0,0,0,0,1,1,0,0,0,0,1,0,1,1,1,0,1,0,1,0,1,1,0,1,1,0,0,0,1,1,0,1,0,0,1).look(:mel_tick)
        sleep 0.25
      end
      8.times do
        with_fx :ping_pong, phase: 0.75 do
          synth :pluck, sustain: 1.5, amp: 4, note: $a_chord[0]
          synth :pluck, sustain: 1.5, amp: 4, note: $a_chord[1]
          synth :pluck, sustain: 1.5, amp: 4, note: $a_chord[2]
          synth :pluck, sustain: 1.5, amp: 4, note: $a_chord[3]
          sleep 1
        end
      end
      128.times do
        tick(:mel_tick)
        synth :pluck, release: 0.5, amp: 2, note: $a_chord[0] if bools(0,1,1,1,0,1,1,1,0,1,1,0,0,1,0,1).reverse.look(:mel_tick)
        synth :pluck, release: 0.5, amp: 2, note: $a_chord[1] if bools(0,1,1,0,1,1,0,0,0,1,1,0,1,1,1,1,0,1,1,1,0,1,1,0,0,1,1,0,0,1,0,1).rotate(1).look(:mel_tick)
        synth :pluck, release: 0.5, amp: 2, note: $a_chord[2] if bools(0,1,0,1,0,0,1,1,0,1,1,0,0,0,0,1,0,1,1,0,1,1,1,0,0,1,1,0,1,0,1,1,0,1,1,1,0,1,0,0).look(:mel_tick)
        synth :pluck, release: 0.5, amp: 2, note: $a_chord[3] if bools(0,1,0,1,0,0,0,0,0,1,1,0,0,0,0,1,0,1,1,1,0,1,0,1,0,1,1,0,1,1,0,0,0,1,1,0,1,0,0,1).look(:mel_tick)
        sleep 0.125
      end
      8.times do
        with_fx :ping_pong, phase: 0.75 do
          synth :pluck, sustain: 1.5, amp: 4, note: $a_chord[0]
          synth :pluck, sustain: 1.5, amp: 4, note: $a_chord[1]
          synth :pluck, sustain: 1.5, amp: 4, note: $a_chord[2]
          synth :pluck, sustain: 1.5, amp: 4, note: $a_chord[3]
          sleep 1
        end
      end
    end
  else
    sleep 1
  end
end

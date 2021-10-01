use_bpm 100

root = 220
chords = [[1/1.0,  5/4.0,   3/2.0],
          [3/2.0, 15/8.0,   9/4.0],
          [9/8.0, 45/32.0, 27/16.0],
          [9/8.0,  3/2.0,   9/5.0],
          [3/2.0,  2/1.0,  24/10.0],
          [1/1.0,  5/4.0,   3/2.0]]

in_thread do
  (chords.length * chords[0].length * 2 - 1).times do
    sleep 0.5
    sample :drum_cymbal_closed
    sleep 0.5
  end
end

in_thread do
  (chords.length * chords[0].length).times do
    sleep 1
    sample :bd_fat, amp: 4
    sleep 1
  end
end

in_thread do
  use_synth :blade
  use_synth_defaults attack: 0.25, release: 1.5
  chords.each do |chord|
    3.times do
      in_thread do
        chord.each do |r|
          play hz_to_midi(root * r)
          sleep 0.125
        end
      end
      sleep 2
    end
  end
end

in_thread do
  use_synth :sine
  use_synth_defaults release: 1, amp: 2
  chords.take(chords.length - 1).each do |chrd|
    chrd.each do |r|
      2.times do
        play hz_to_midi(root * r / 2)
        sleep 1
      end
    end
  end
  chrd = chords.last
  chrd.take(chrd.length - 1).each do |r|
    2.times do
      play hz_to_midi(root * r / 2)
      sleep 1
    end
  end
  chrd.each do |r|
    play hz_to_midi(root * r / 2), release: 3, amp: 1
  end
end

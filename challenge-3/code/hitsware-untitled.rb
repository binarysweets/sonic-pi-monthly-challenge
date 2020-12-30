# Demonstrates the interaction of
# 'use_bpm', 'sleep', and implicit
# release

for time in 1..10
  
  use_bpm(33*time)
  
  for octave in 0..3
    
    play hz_to_midi 100*(2**octave)
    
    sleep (33*time)/60.0

  end

end

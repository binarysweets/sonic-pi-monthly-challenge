# A Sonic Pi tribute to the turntable - by Binarysweets
# Settings can be adjusted while playing
# Change :deck1_on or :deck2_on to true to start playing the decks
# Use the :deck1_speed_adj / :deck1_speed_adj to fine tune the tempo

# Choose the record speed, 33, 45 or 78
rpm = 45

# Select a scale
set :scl, scale(:bb1, :diatonic, num_octaves: 3)

# It's DJ time!
######################################################################
#                    ___                                          ___#
# __________________/  /                       __________________/  /#
#| _    _______    /  /                       | _    _______    /  / #
#|(_) .d########b.//)| _____________________ |(_) .d########b.//)|   #
#|  .d############//  ||        _____        ||  .d############//  | #
#| .d######""####//b. ||() ||  [D JAY]  || ()|| .d######""####//b. | #
#| 9######(  )#_//##P ||()|__|  | = |  |__|()|| 9######(  )#_//##P | #
#| 'b######++#/_/##d' ||() ||   | = |   || ()|| 'b######++#/_/##d' | #
; set :deck1_on, true             ;             set :deck2_on, true
#|  _"9a#######aP"    ||  _   _____..__   _  ||  _"9a#######aP"    | #
#| |_|  `""""''       || (_) |_____||__| (_) || |_|  `""""''       | #
#|  ___..___________  ||_____________________||  ___..___________  | #
;set :deck1_speed_adj,3           ;           set :deck2_speed_adj,3
#|____________________|                       |____________________| #
#                                                                    #
######################################################################


set :bpm, rpm * 3
use_bpm get :bpm

live_loop :deck1 do ; tick
  use_bpm get[:bpm] + get[:deck1_speed_adj]
  
  if get[:deck1_on] == true
    sample :loop_compus, slice: look,
      amp: rrand(3, 3.2),
      beat_stretch: [16, 32].choose if bools(1,0,1,1).look
  end
  
  sleep 0.25
end

live_loop :deck2 do ; tick
  use_bpm get[:bpm] + get[:deck2_speed_adj]
  
  if get[:deck2_on] == true
    scl = get :scl
    notes = (ring 0,1,1,2, 0,2,2,3).mirror
    
    with_fx :bitcrusher, sample_rate: 2000, bits: [6,4].choose do
      with_synth :square do
        play scl[notes.look], amp: rrand(1.0, 1.2),
          release: 0.5 if bools(0,1,1,0).look
      end
    end
  end
  
  sleep 1
end

# The ascii art isn't mine - https://ascii.co.uk/art/turntables

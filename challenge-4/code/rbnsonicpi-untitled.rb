#Sonic Pi Challenge #4 by Robin Newman
#I decided to generate my own binary string from text input
#which allows you to render any text here
#I liked initial code by theibbster at https://in-thread.sonic-pi.net/t/chord-progression-tool/4947
#I developed this and put the two ideas together below
use_debug false
use_random_seed 6148
L= "Robin Newman's Sonic Pi challenge #4" #the text input I used
S=[] #array to hold binary represention of the string L
L.bytes.to_a.each do |x| #convert to binary 7 bit numbers for each character
  S += [ x.to_s(2).rjust(7,"0")]
end
puts "Test string is #{L}"
puts "Translates to binary Array:",S
puts

define :chrd do |deg, tonic, sca| #function from theibbster to modify degrees containing 7
  n = 3
  if deg.match?('7')
    n = 4
    deg = deg.slice(0,deg.length-1).to_sym
  end
  return (chord_degree deg, tonic, sca, n)
end
#list of seven progressions that can be used
p1 = [:i,:v,:vi,:iv]
p2 = [:i,:iv,:v,:iv]
p3 = [:ii7,:v7,:i7]
p4 = [:i,:vi,:iv,:v]
p5 = [:i,:v,:vi,:iii,:iv,:i,:iv,:v]
p6 = [:i,:vi,:ii,:v]
p7 = [:i,:iii,:iv,:ii]
pl=(ring p1,p2,p3,p4,p5,p6,p7).shuffle #set up ring of progressions



with_fx :reverb,room: 0.8,mix: 0.7 do #add reverb
  with_fx :level,amp: 1 do |vol| #vary vol as piece progresses
    set :vol,vol #stopre ref to fx_level for control
    live_loop :vet do #control level output on 10 sec up/down ramp
      vlev=[0.4,1].tick
      control get(:vol),amp: vlev,amp_slide: 10
      sleep 10
    end
    S.each.with_index do |v,i| #iterate through binary character strings
      sample :drum_snare_hard,amp: 2 #drum and roll at start of each new character
      sample :drum_roll,amp: 1.5
      puts "Binary: #{v} index #{i} character "+L[i]
      progplay=[]
      8.times do |id|
        n=v[id].to_i
        progplay+= pl[id] if n==1 #insert next progression if binary 1 otherwise omit
      end
      puts "Selected progression is #{progplay}"
      
      
      progression = progplay  #set next assembled progression to be played
      #vary tonic note for each iteration using sequence below
      tonic = (ring 62.5,62.5+7,62.5-5,62.5-12,62.5+7-12,62.5-5-12).tick
      set :tonic,tonic
      #choose scale type from specified list
      myScale = (ring :major,:mixolydian,:minor,:minor_pentatonic,:dorian,:aeolian).choose# or tick(:sc)
      #process next progression
      progression.each_with_index  do |deg,i|
        nl=(chrd deg, tonic, myScale) #get notes to play
        use_synth :dsaw #play bass note with dsaw as a drone
        play nl[0]-12,\
          sustain: (nl.length)*0.9*0.095,release: 0.005,\
          amp: 0.7,pan: 1*(-1)**i #alternate notes on pan +-1
        use_synth :pulse #use pulse for faster notes
        nl.each do |n| #play notes in sequence
          play n,\
            sustain: 0.095,release: 0.005,\
            amp: 0.5,pan: 0.5*(-1)**tick(:iloop) #alternate notes on pan +-0.5
          sleep 0.1
        end
      end#progression
    end#loop
    #play final note to finish
    sample :drum_roll
    synth :dsaw,note: get(:tonic)-24,release: (sample_duration :drum_roll)
  end#level
end#reverb

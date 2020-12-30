#Carol_of_the_Bells.rb
#coded for Sonic Pi by Robin Newman, Dec 22 2020

use_bpm 2*78 #twice 78rpm!! criterion for Monthly Challenge #3
s=0.95;r=0.1 #set sustain release fractions
pp=0.3;p=0.4;mf=0.6;f=0.8;ff=1 #defeine vol levels

with_fx :reverb,room: 0.8,mix: 0.8 do
  use_synth :beep #synth for top part
  with_fx :level ,amp: 1.3 do #most toop part relative to the others
    with_fx :level,amp: pp do |v1| #set initial volume
      set :v1,v1 #pointer to fx_level
      #control volume at times specified by "at" this part also has variable slide times
      at [12*3,16*3, 24*3,25*3,26*3,27*3,44*3,48*3,56*3,57*3,58*3,59*3],
      [[mf,0],[f,0],[ff,3],[mf,3],[f,3],[p,3],[mf,0],[f,0],[ff,3],[mf,3],[f,3],[p,3]] do |vol1|
        control get(:v1),amp: vol1[0],amp_slide: vol1[1]
      end
      
      a1=[:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:D5,:C5,:D5,:Bf4,:D5,:C5,:D5,:Bf4,:D5,:C5,:D5,:Bf4,:D5,:C5,:D5,:Bf4,:G5,:G5,:G5,:F5,:Ef5,:D5,:D5,:D5,:C5,:Bf4,:C5,:C5,:C5,:D5,:C5,:G4,:G4,:G4,:G4,:D4,:E4,:Fs4,:G4,:A4,:Bf4,:C5,:D5,:C5,:Bf4,:D4,:E4,:Fs4,:G4,:A4,:Bf4,:C5,:D5,:C5,:Bf4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:D5,:C5,:D5,:Bf4,:D5,:C5,:D5,:Bf4,:D5,:C5,:D5,:Bf4,:D5,:C5,:D5,:Bf4,:G5,:G5,:G5,:F5,:Ef5,:D5,:D5,:D5,:C5,:Bf4,:C5,:C5,:C5,:D5,:C5,:G4,:G4,:G4,:G4,:D4,:E4,:Fs4,:G4,:A4,:Bf4,:C5,:D5,:C5,:Bf4,:D4,:E4,:Fs4,:G4,:A4,:Bf4,:C5,:D5,:C5,:Bf4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:G4]
      b1=[1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,0.5,0.5,1.0,0.5,0.5,0.5,0.5,1.0,0.5,0.5,0.5,0.5,1.0,0.5,0.5,1.0,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,1.0,1.0,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,1.0,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,0.5,0.5,1.0,0.5,0.5,0.5,0.5,1.0,0.5,0.5,0.5,0.5,1.0,0.5,0.5,1.0,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,1.0,1.0,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,1.0,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,12.0]
      in_thread do
        for i in 0..a1.length-1
          play a1[i],sustain: b1[i]*s,release: b1[i]*r,pan: -0.6
          sleep b1[i]
        end
      end
    end #level1
  end #level part boost
  use_synth :blade#for remaining parts
  with_fx :level,amp: 0.8 do# balance parts 2-4 reduced
    with_fx :level,amp: pp do |v2| #set initial volume
      set :v2,v2
      at [12*3,16*3,28*3,36*3,44*3,48*3,60*3],[mf,f,p,pp,mf,f,p] do |vol2|
        control get(:v2),amp: vol2,amp_slide: 0.5 #fixed slide times
      end
      
      a2=[:r,:r,:r,:r,:G4,:F4,:Ef4,:D4,:G4,:F4,:Ef4,:D4,:G4,:G4,:G4,:G4,:G4,:G4,:G4,:G4,:G4,:G4,:G4,:G4,:G4,:G4,:G4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:G4,:A4,:A4,:G4,:G4,:A4,:Bf4,:G4,:G4,:A4,:Bf4,:D5,:G4,:G4,:G4,:G4,:D4,:E4,:Fs4,:G4,:D4,:E4,:Fs4,:G4,:D4,:C4,:F4,:Ef4,:D4,:r,:G4,:F4,:Ef4,:D4,:G4,:F4,:Ef4,:D4,:G4,:G4,:G4,:G4,:G4,:G4,:G4,:G4,:G4,:G4,:G4,:G4,:G4,:G4,:G4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:Bf4,:A4,:Bf4,:G4,:G4,:A4,:A4,:G4,:G4,:A4,:Bf4,:G4,:G4,:A4,:Bf4,:D5,:G4,:G4,:G4,:G4,:D4,:E4,:Fs4,:G4,:D4,:E4,:Fs4,:G4,:D4,:C4,:F4,:Ef4,:D4]
      b2=[3.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,3.0,1.0,1.0,1.0,3.0,1.0,1.0,1.0,3.0,3.0,3.0,3.0,9.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,3.0,1.0,1.0,1.0,3.0,1.0,1.0,1.0,3.0,3.0,3.0,3.0,12.0]
      in_thread do
        for i in 0..a2.length-1
          play a2[i],sustain: b2[i]*s,release: b2[i]*r,pan: -0.2
          sleep b2[i]
        end
      end
    end#level2
    
    with_fx :level,amp: pp do |v3| #set initial volume
      set :v3,v3
      at [12*3,16*3,24*3,28*3,40*3,44*3,48*3,56*3,60*3],[mf,f,ff,p,pp,mf,f,ff,p] do |vol3|
        control get(:v3),amp: vol3,amp_slide: 0.5 #fixed slide times
      end
      
      a3=[:r,:r,:r,:r,:r,:r,:r,:r,:Ef4,:D4,:C4,:G3,:C4,:C4,:C4,:C4,:D4,:D4,:D4,:D4,:Ef4,:Ef4,:Ef4,:Ef4,:D4,:D4,:D4,:D4,:D4,:E4,:F4,:Ef4,:D4,:G4,:F4,:Ef4,:D4,:D4,:Ef4,:Ef4,:D4,:C4,:D4,:D4,:D4,:D4,:Ef4,:Ef4,:Ef4,:F4,:Ef4,:D4,:D4,:D4,:D4,:Bf3,:A3,:Bf3,:G3,:Bf3,:A3,:Bf3,:G3,:Bf3,:A3,:Bf3,:G3,:Bf3,:A3,:Bf3,:G3,:G3,:G3,:G3,:G3,:G3,:r,:r,:r,:r,:r,:Ef4,:D4,:C4,:G3,:C4,:C4,:C4,:C4,:D4,:D4,:D4,:D4,:Ef4,:Ef4,:Ef4,:Ef4,:D4,:D4,:D4,:D4,:D4,:E4,:F4,:Ef4,:D4,:G4,:F4,:Ef4,:D4,:D4,:Ef4,:Ef4,:D4,:C4,:D4,:D4,:D4,:D4,:Ef4,:Ef4,:Ef4,:F4,:Ef4,:D4,:D4,:D4,:D4,:Bf3,:A3,:Bf3,:G3,:Bf3,:A3,:Bf3,:G3,:Bf3,:A3,:Bf3,:G3,:Bf3,:A3,:Bf3,:G3,:G3,:G3,:G3,:G3,:Bf3,:A3,:Bf3,:G3,:Bf3,:A3,:Bf3,:G3,:Bf3,:A3,:Bf3,:G3,:Bf3,:A3,:Bf3,:G3]
      b3=[3.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,3.0,3.0,1.0,1.0,1.0,0.5,0.5,1.0,1.0,1.0,0.5,0.5,0.5,0.5,1.0,0.5,0.5,1.0,1.0,0.5,0.5,0.5,0.5,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,3.0,3.0,3.0,3.0,9.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,3.0,3.0,1.0,1.0,1.0,0.5,0.5,1.0,1.0,1.0,0.5,0.5,0.5,0.5,1.0,0.5,0.5,1.0,1.0,0.5,0.5,0.5,0.5,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,3.0,3.0,3.0,3.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0]
      in_thread do
        for i in 0..a3.length-1
          play a3[i],sustain: b3[i]*s,release: b3[i]*r,pan: 0.2
          sleep b3[i]
        end
      end
    end#level3
    
    
    with_fx :level,amp: mf do |v4| #set initial volume
      set :v4,v4
      at [16*3,24*3,28*3,44*3,48*3,56*3,60*3],[f,ff,p,mf,f,ff,p] do |vol4|
        control get(:v4),amp: vol4,amp_slide: 0.5 #fixed slide times
      end
      
      a4=[:r,:r,:r,:r,:r,:r,:r,:r,:r,:r,:r,:r,:Ef3,:Ef3,:Ef3,:Ef3,:G3,:G3,:G3,:G3,:C4,:C4,:C4,:C4,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:Bf3,:A3,:Bf3,:G3,:Bf3,:A3,:Bf3,:G3,:Bf3,:A3,:Bf3,:G3,:Bf3,:A3,:Bf3,:G3,:D3,:D3,:D3,:D3,:E3,:F3,:Ef3,:D3,:C3,:G2,:r,:r,:r,:r,:r,:r,:r,:r,:r,:Ef3,:Ef3,:Ef3,:Ef3,:G3,:G3,:G3,:G3,:C4,:C4,:C4,:C4,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:G3,:Bf3,:A3,:Bf3,:G3,:Bf3,:A3,:Bf3,:G3,:Bf3,:A3,:Bf3,:G3,:Bf3,:A3,:Bf3,:G3,:D3,:D3,:D3,:D3,:E3,:F3,:Ef3,:D3,:C3,:G2]
      b4=[3.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,3.0,3.0,3.0,2.0,1.0,3.0,3.0,3.0,3.0,9.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0,3.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,1.0,0.5,0.5,1.0,3.0,3.0,3.0,2.0,1.0,3.0,3.0,3.0,3.0,12.0]
      in_thread do
        for i in 0..a4.length-1
          play a4[i],sustain: b4[i]*s,release: b4[i]*r,pan: 0.6
          sleep b4[i]
        end
      end
    end#level4
  end#level balance parts 2-4
  
end#fx

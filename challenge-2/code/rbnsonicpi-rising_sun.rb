#House of the Rising Sun, coded for Sonic Pi by Robin Newman, August 2015
#Based on version by M Ludenhoof at http://imslp.org/wiki/House_of_the_Rising_Sun_(Ludenhoff,_Martin)
#Creative Commons 3.0 licence. One or two notes modified.
#version 2. Different play structure, and alternative instrument for middle section


#samples used with their natural pitches
inst0=:bass_woodsy_c
samplepitch0=:c3
samplepitch1=:c3
inst1=inst0
inst2=:ambi_glass_rub
samplepitch2=:fs5

#define variable that needs to be used globally
s=1 #note duration scale factor: redefined in use_bpm function

#this function plays the sample at the relevant pitch for the note desired
#the note duration is used to set up the envelope parameters
define :pl do |inst,samplepitch,nval,dval,vol=1,pan=0|
  shift=note(nval)-note(samplepitch)
  sample inst,rate: (pitch_to_ratio shift),attack: 0.02,attack_level: 1.2,decay: 0.1,sustain_level: 1,sustain: 0.9*dval,release: 0.1*dval,amp: vol,pan: pan
end

#this function plays an array of notes and associated array of durations
#also uses sample name (inst), sample normal pitch,sample start and shift (transpose) parameters
define :plarray do |inst,samplepitch,narray,darray,shift=0,vol=1,pan=0|
  
  narray.zip(darray) do |nv,dv|
    
    if nv != :r
      pl(inst,samplepitch,note(nv)+shift,dv*s,vol,pan)
      
    end
    sleep dv*s
  end
end


#set_bpm sets bpm required adjusting note duration variables accordingly
define :set_bpm do |n|
  s=1.0/8*60/n.to_f
end

#set relative note duration variables (not all used)
dsq = 1.0 #must be float as divided later
sq = 2
sqd = 3
q = 4
qt = 2.0/3*q
qd = 6
qdd = 7
c = 8
cd = 12
cdd = 14
m = 16
md = 24
mdd = 28
b = 32
bd = 48
#define the parts. n1 = base,n2 = middle part, n3 = tune
#b suffix signifies second half, end signifies last time end two bars
n1=[ :a3,:c4,:d4,:f4]+[:a3,:e3,:a3,:e3]+[:a3,:r,:c4,:r,:d4,:f4]+[:a3,:c4,:e3,:e3]+[:a3,:r,:c4,:r,:d4,:f4]
#l6
n1.concat [:a3,:e3,:a3,:c4]+[:d4,:f4,:a3,:e3]+[:a3]
n1b=[:e3,:a3,:c4]+[:d4,:d4,:r,:f4,:r,:a3,:c4]+[:e3,:e3,:a3,:c4]
n1b.concat [:d4,:f3,:a3,:e3]+[:a3,:e3]
d1=[md]*9+[q,m,q]+[md]*7+[q,m,q]+[md]*11
d1b=[md]*3+[m,c,q,m,q]+[md]*12
n1end=[:e3,:a3]
d1end=[md]*2

#l1
n2=[:r,:e4,:a4,:c5,:e5,:c5,:a4]+[:r,:e4,:g4,:c5,:e5,:c5,:g4]+[:r,:fs4,:a4,:d5,:fs5,:d5,:a4]+[:r,:f4,:a4,:c5,:f5,:c5,:a4]
d2=[q,sq,sq,q,q,q,q]*4
#l2
n2.concat [:r,:e4,:a4,:c5,:e5,:c5,:a4]+[:r,:b3,:e4,:gs4,:b4,:e5,:b4,:gs4]+[:r,:e4,:a4,:c5,:e5,:c5,:a4]+[:r,:b3,:e4,:gs4,:b4,:e5,:b4,:r]
d2.concat [q,sq,sq,q,q,q,q]+[q,sq,sq,sq,sq,q,q,q]+[q,sq,sq,q,q,q,q]+[q,sq,sq,sq,sq,q,q,q]
#l3
n2.concat [:r,:a4,:c5,:e5,:a4,:c5,:r]+[:r,:g4,:e5,:g4,:e5,:r]+[:r,:fs5,:d5,:fs5]+[:r,:a4,:c5,:f5,:a4,:c5,:r]
d2.concat [q,sq,sq,q,q,q,q]+[qd,sq,q,q,q,q]+[cd,q,q,q]+[q,sq,sq,q,q,q,q]
#l4
n2.concat [:r,:a4,:c5,:e5,:a4,:c5,:r]+[:r,:e4,:g4,:c5,:e4,:g4,:r]+[:r,:e4,:gs4,:b4,:e4,:gs4,:b4]+[:r,:b3,:e4,:gs4,:b4,:r]
d2.concat [q,sq,sq,q,q,q,q]*3+[q,sq,sq,q,c,q]
#l5
n2.concat [:r,:a4,:c5,:e5,:a4,:c5,:r]+[:r,:g4,:e5,:g4,:e5,:r]+[:r,:fs5,:d5,:fs5,:r]+[:r,:a4,:c5,:f5,:a4,:c5,:r]
d2.concat [q,sq,sq,q,q,q,q]+[qd,sq,q,q,q,q]+[c,q,q,q,q]+[q,sq,sq,q,q,q,q]
#l6
n2.concat [:r,:a4,:c5,:e5,:a4,:c5,:r]+[:r,:b4,:gs4,:b4,:r]+[:r,:a4,:c5,:e5,:a4,:c5,:e5]+[:r,:e4,:g4,:c5,:e5,:c5,:g4]
d2.concat [q,sq,sq,q,q,q,q]+[c,q,q,q,q]+[q,sq,sq,q,q,q,q]*2
#l7
n2.concat [:r,:fs4,:a4,:d5,:fs5,:d5,:a4]+[:r,:f4,:a4,:c5,:f5,:c5,:a4]+[:r,:e4,:a4,:c5,:e5,:c5,:a4]+[:r,:b3,:e4,:gs4,:b4,:e5,:b4,:gs4]
d2.concat [q,sq,sq,q,q,q,q]*3+[q,sq,sq,sq,sq,q,q,q]
#l8
n2.concat [:r,:e4,:a4,:c5,:e5,:c5,:a4]
d2.concat [q,sq,sq,q,q,q,q]

n2b=[:r,:b3,:e4,:gs4,:b4,:e5,:b4,:r]+[:c5,:c5,:c5,:r]+[:r,:c5,:r,:g4,:r]
d2b=[q,sq,sq,sq,sq,q,q,q]+[q,cd,q,q]+[q,q,c,q,q]
#p2l1
n2b.concat [:d5,:d5,:r]+[:r,:a4,:f5,:r]+[:r,:c5,:c5,:r]+[:r,:c5,:r,:g4,:r]
d2b.concat [q,q,m]+[c,q,q,c]+[q,cd,q,q]+[q,q,c,q,q]
#p2l2
n2b.concat [:r,:gs4,:r,:b4,:r]+[:r,:gs4,:b4,:e5,:r]+[:r,:c5,:c5,:r]+[:r,:g4,:r,:g4,:r]
d2b.concat [q,q,c,q,q]+[q,q,q,q,c]+[q,cd,q,q]+[q,q,c,q,q]
#p2l3
n2b.concat [:r,:a4,:r,:a4,:r]+[:r,:f4,:a4,:c5,:r]+[:r,:c5,:c5,:r]+[:r,:gs4,:r,:b4,:r]
d2b.concat [q,q,c,q,q]+[q,q,q,q,c]+[q,cd,q,q]+[q,q,c,q,q]
#p2l4
n2b.concat [:r,:c5,:c5,:r]+[:r,:gs4,:b4,:e5]
d2b.concat [q,c,c,q]+[q,q,q,cd]

n2end=[:r,:b3,:e4,:gs4,:b4,:e5,:b4,:gs4]+[:a4,:c5]
d2end=[q,sq,sq,sq,sq,q,q,q]+[cd,cd]

n3=[:r]+[:r,:a5]+[:a5,:r,:b5]+[:c6,:r,:e6]+[:d6,:a5,:a5]+[:r,:a5]
d3=[md*7]+[m+q,q]+[m,q,q]*2+[q,q,m]+[m+q,q]
#l4
n3.concat [:a5,:r,:a5]+[:g5,:r,:e5]+[:e5]+[:r,:a5]
d3.concat [m,q,q]*2+[md]+[m+q,q]
#l5
n3.concat [:a5,:r,:b5]+[:c6,:r,:e6]+[:d6,:a5,:a5]+[:a5,:r,:a5]
d3.concat [m,q,q]*2+[q,m,q]+[m,q,q]
#l6
n3.concat [:a5,:r,:a5]+[:gs5,:a5,:gs5,:e5,:gs5]+[:a5]+[:r]
d3.concat [m,q,q]+[dsq,dsq,sq,m,q]+[md]+[md]
#l7-first half 8
n3.concat [:r]
d3.concat [md*5]

#l8 bar 2
n3b= [:r,:a5]+[:a5,:b5,:c6,:b5,:a5]+[:g5,:f5,:e5,:g5]
d3b= [m+q,q]+[c,q,c,sq,sq]+[c,q,c,q]
#p2l1
n3b.concat [:a5,:g5,:fs5,:g5,:fs5,:a5,:b5]+[:c6,:r,:a5]+[:a5,:b5,:c6,:b5,:a5]+[:g5,:f5,:e5,:a5]
d3b.concat [c,q,dsq,dsq,c-sq,sq,sq]+[m,q,q]+[c,q,c,sq,sq]+[c,q,c,q]
#p2l2
n3b.concat [:b5,:a5,:gs5,:a5,:gs5,:a5]+[:b5,:r,:a5,:b5]+[:c6,:b5,:a5,:b5,:a5,:g5,:f5]+[:e5,:f5,:g5,:a5,:g5]
d3b.concat [c,q,dsq,dsq,c-sq,q]+[m,q,sq,sq]+[c,q,dsq,dsq,c-sq,sq,sq]+[c,q,c,sq,sq]
#p2l3
n3b.concat [:fs5,:e5,:d5,:e5,:d5,:e5]+[:f5,:r,:a5,:b5]+[:c6,:b5,:a5,:b5,:a5,:g5,:f5]+[:e5,:fs5,:gs5,:a5,:b5]
d3b.concat [c,q,dsq,dsq,c-sq,q]+[m,q,sq,sq]+[c,q,dsq,dsq,c-sq,sq,sq]+[c,q,c,sq,sq]
#p2l4
n3b.concat [:c6,:b5]+[:a5,:gs5,:a5]+[:b5]
d3b.concat [c,q]+[c,sq,sq]+[md]

n3end=[:r]+[:r,:a5]
d3end=[md]+[cd,cd]

comment do #uncomment to check lengths
  puts "pairs should be equal"
  puts n1.length
  puts d1.length
  puts n1b.length
  puts d1b.length
  puts n2.length
  puts d2.length
  puts n2b.length
  puts d2b.length
  puts n3.length
  puts d3.length
  puts n3b.length
  puts d3b.length
  sleep 6
end

define :len do |d| #for checking durations of parts
  ld=0
  d.each do |d|
    ld += d
  end
  return ld
end
comment do #uncomment to check durations are equal
  puts "groups of three should be equal"
  puts len(d1)
  puts len(d2)
  puts len(d3)
  puts len(d1b)
  puts len(d2b)
  puts len(d3b)
  puts len(d1end)
  puts len(d2end)
  puts len(d3end)
  sleep 6
end
set_bpm(130)
playlist=[n1,d1,n2,d2,n3,d3, n1b,d1b,n2b,d2b,n3b,d3b,  n1end,d1end,n2end,d2end,n3end,d3end]

define :playtune do |i,inst1=inst0| #set default inst1 to be the same as inst0
  in_thread do
    plarray(inst0,samplepitch0,playlist[0+6*i],playlist[1+6*i],0,2)
  end
  in_thread do
    plarray(inst1,samplepitch1,playlist[2+6*i],playlist[3+6*i],0,0.6)
  end
  plarray(inst2,samplepitch2,playlist[4+6*i],playlist[5+6*i],0,4)
end
with_fx :reverb,room: 0.8 do
  #you can adjust the sequence of how the piece is played here selecting part 0,1 or the end part 2
  #you can add more (or fewer) verses etc
  #one verse has an alternative style for the second instrument
  playtune(0)
  playtune(1)
  playtune(0,:bass_hard_c)
  playtune(1,:bass_hard_c)
  playtune(0)
  playtune(2)
end

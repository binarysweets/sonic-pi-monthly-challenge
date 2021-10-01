###################### Winter Sun , Summer Rain ##########################

mn=[:r]                                         #set midi-number 0 as rest
s=[]                                            #pretty_bell track
t=[]                                            #pluck track
u=[]                                            #fm track
m=[0,0,0,0,64,81,90,96,120]                     #scale
p=[0,1,2,3,4,5,6,7,8,9]                         #possibilities

for f in 1..1023
  mn[f]=hz_to_midi(f*4)
end                                             #use frequencies as notes

loop do
  for i in 0..15
    if choose(p)==0 then s[i]=mn[choose(m)]; end #fill pretty_bell track
    if choose(p)==1 then t[i]=mn[choose(m)]; end #fill pluck track
    if choose(p)==2 then u[i]=mn[choose(m)]; end #fill fm track
    synth :pretty_bell, note: s[i], release: 0.1 #play pretty_bell
    synth :pluck, note: t[i]                     #play pluck
    synth :fm, note: u[i]-12, amp: 0.5           #play fm
    sleep 0.25                                   #rest
  end
end

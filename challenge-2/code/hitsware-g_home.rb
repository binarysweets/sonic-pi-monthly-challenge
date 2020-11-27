############## Go'in Home ############

mn=[:r]; for jn in 1..1023
  mn[jn]=hz_to_midi(4*jn)
end; use_bpm 120

c=[36,36,34,32,30,30,30,30,
   30,30,30,30,30,30,30,30,
   27,27,27,27,30,30,30,30]
v=[0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0]
e=[0,0,1,0,0,0,0,0,2,0,0,0,0,0,0,0]
p=[1,1,2,0,1,1,4,0,1,1,2,0,1,1,4,0]
k=[60,72,81,90,108,0]; t=[1,2,3,4]

for y in 0..31
  synth :zawa, note:mn[120], release: 0.01, amp: p[y%8]/2.0
sleep 0.25; end

live_loop :main do
  for x in 0..23; for b in 0..7; y=((x%2)*8)+b
      synth :fm, note: mn[c[x]], release: e[y]/1.5,
    amp: v[y]
  synth :zawa, note:mn[120], release: 0.01, amp: p[y]/2.0
sleep 0.25; end; end; end

live_loop :lead do; n=choose(k); a=choose(t)/4.0
  s=choose(t)/4.0; r=choose(t)/4.0
  synth :hollow,note: mn[n], attack: a, sustain: s,
    release: r, amp: 0.4
  synth :beep, note: mn[n], attack: a, sustain: s,
    release: r, amp: 0.3
sleep (a+s+r); end

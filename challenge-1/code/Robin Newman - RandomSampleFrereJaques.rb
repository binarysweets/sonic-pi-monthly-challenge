#random sample tune using Freres Jaques by Robin Newman, Oct 2020
#for random sample competition
#the random sample I was presented with was of a random elictricity buzz
#I read and save the onset info which produced 14 sections
#the first consisted of clicks, but the remainder I use to produce a "synth"
#with differnt tones. I then used these to play four aprt rounds of frere jaques
#finishing with one load very low frequency version.
use_debug false

#s holds the path to the sample from https://freesound.org/search/?q=260832
#adjust path to suit your installation
s= "/Users/rbn/Downloads/260832__sophronsinesounddesign__random11-electricity.wav"

#listOnsets uses a lanbda function to save a list of the onset maps
define :listOnsets do |s|
  set :onsetsMaps,[] #initialise a blank list
  l = lambda {|c| set :onsetsMaps,c.to_a; c[0]} #set the info obtained in :listonsets
  sample s, onset: l,amp: 0,finish: 0 #trigger the lambda function played sample at 0 volume and finish=0
  return get(:onsetsMaps)
end

#nfr and fr hold the note and duration info for the tune frere jaques
nfr=[:c4,:d4,:e4,:c4]*2+[:e4,:f4,:g4]*2+[:g4,:a4,:g4,:f4,:e4,:c4]*2+[:c4,:g3,:c4]*2
dfr=[1,1,1,1,1,1,1,1,1,1,2,1,1,2,0.5,0.5,0.5,0.5,1,1,0.5,0.5,0.5,0.5,1,1,1,1,2,1,1,2]
#puts nfr
#puts dfr

#d stores the duration of the sample, and od stores the onset info in a list in the form
#[(map start: 0.0, finish: 0.004517767793026575, index: 0), (map start: 0.004517767793026575, finish: 0.052125084005523396, index: 1),....

d= sample_duration s
od = listOnsets s
#puts od #fordebug/checking

#l holds the number of onsets
l =od.length
#sd willl hod list of onset data in form [[start fraction,finish fraction,finish-start][start....
sd=[]
l.times do |x|
  sd[x]= od[x][:start],od[x][:finish], (od[x][:finish]-od[x][:start])
end
#puts sd #for debug/checking

#pl plays a given onset of the sample at a relative pitch adjusted to give a desired note
#the amount of the offset can be adjusted by parameter d (0-1)
#the pan settting can be specified as can the amplitude and a note offset for transposition
#use of min function to prevent wrap round of onset to start playing again
define :pl do |n,os,d=1,p=0,a=1,off=0|
  sample s,rpitch: note(n)-56+off,start: sd[os][0],finish: (sd[os][0]+sd[os][2]*[d,1].min),pan: p,amp: a,cutoff: 108
end
#plfr plays the tune frere jaques in a thread, using a given onset number as the basis of the notes
#the pan settings can be specified, and the transposition
#del is used to adjust the tempo,and factor the length of notes
define :plfr do |num,pan,del,factor,offset|
  in_thread do
    nfr.zip(dfr) do |nx,dx|
      pl nx,num,2*del*factor*dx,pan,1,offset
      sleep dx*del
    end
  end
end

#start playing here========================================
puts "The random sample from freesound.org was:"
puts "https://freesound.org/search/?q=260832"
puts "260832__sophronsinesounddesign__random11-electricity.wav"
sample s #first play the original sample
sleep d
sleep  2

puts "now use the sample onsets to produce different tinbre 'synths'"
puts "and play 3 sets of four part rounds"
#now play four part rounds using differnt "synth voices" from differnt onsets

with_fx :lpf,cutoff: 124 do
  
  with_fx  :wobble,phase: 16,wave: 3,mix: 0.7 do |wb|
    set :wb,wb #save reference to wobble fx so it can be cpntrolled
    olist=[0,7,12];dv=[0.5,0.35,0.2];fac=[1,0.8,0.5]
    3.times do |nx| #loop 3 times to use 12 different osnet produced "synths"
      tick
      #adjust wobble phase to sync to frere jaques tempo
      control get(:wb),phase: [16,16*0.35/0.5,16*0.2/0.5].look
      #use nextfour onsets to generage 4 aprt frere jaques
      plfr 1+nx*4,-0.8,dv.look,fac.look,olist.look
      sleep 8*dv.look
      plfr 2+nx*4,-0.3,dv.look,fac.look,olist.look
      sleep 8*dv.look
      plfr 3+nx*4,0.3,dv.look,fac.look,olist.look
      sleep 8*dv.look
      plfr 4+nx*4,0.6,dv.look,fac.look,olist.look
      sleep 32*dv.look
    end
  end #wobble
  puts "finish with stonking loud frere jaques. Mind your speakers!"
  sleep 1
  
  #use last onset (13) to give a stonking loud frere jqaues to finish. Mind your speakers!
  with_fx :gverb,room: 40,mix: 0.7 do #gverb to boost it!
    plfr 13,0,0.75,1,-12
  end
  
end #lpf

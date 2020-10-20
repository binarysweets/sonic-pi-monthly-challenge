use_random_seed 202010190001001
# Sonic Pi Monthly Challenge 1
# https://in-thread.sonic-pi.net/t/sonic-pi-monthly-challenge-1/4442
# featuring voice sample from 'Katy T' (aka Katy Theodossiou)
# https://freesound.org/people/digifishmusic/sounds/84243/
# Original file name:
# 84243__digifishmusic__oooooo-accapela-katytheodossiou.wav
# Work name:
# accapela-katytheodossiou.wav

set_mixer_control! hpf: 35
set_mixer_control! amp: 0.99

duree_intro = 7
duree_outro = 6

duree_totale = 140
print "durée totale: ", duree_totale / 60, " mn et", duree_totale % 60, " s"

bibsmp = "G:/media/perso/enkid0/_SonicPi_monthly/001"

smp_Katy = "accapela-katytheodossiou.wav"
duree_voix =  sample_duration bibsmp, smp_Katy
print duree_voix

continuer = true

in_thread do
  while continuer == true
    sleep 1
    if beat > duree_totale
      continuer = false
      print "fin du morceau !"
    end
  end
end

with_fx :compressor, mix: 1 do
  
  
  in_thread do
    with_fx :hpf, cutoff: 0, cutoff_slide: 7, mix: 0.7 do |hpf|
      with_fx :lpf, cutoff: 130, cutoff_slide: 6, mix: 0.7 do |lpf|
        with_fx :whammy, mix: 0.16 do
          with_fx :panslicer, wave: 1, mix: 0.12 do
            print "zero"
            
            sample bibsmp, smp_Katy,
              sample_duration: duree_totale,
              rate: duree_voix/duree_totale,
              amp: 0.41
            
            sleep duree_intro
            
            in_thread do
              while continuer == true
                sleep 7
                control hpf, cutoff: rrand_i(0, 88)
              end
            end
            
            while continuer == true
              sleep 10
              control lpf, cutoff: rrand_i(98, 130)
            end
            
          end
        end
      end
    end
  end
  
  in_thread do
    with_fx :hpf, cutoff: 0, cutoff_slide: 7, mix: 0.7 do |hpf|
      with_fx :lpf, cutoff: 130, cutoff_slide: 6, mix: 0.7 do |lpf|
        with_fx :whammy, mix: 0.13 do
          with_fx :panslicer, wave: 1, mix: 0.12 do
            print "minus zero"
            
            sample bibsmp, smp_Katy,
              sample_duration: duree_totale,
              rate: -duree_voix/duree_totale,
              amp: 0.36
            
            sleep duree_intro
            
            in_thread do
              while continuer == true
                sleep 6
                control hpf, cutoff: rrand_i(0, 88)
              end
            end
            
            while continuer == true
              sleep 9
              control lpf, cutoff: rrand_i(98, 130)
            end
            
          end
        end
      end
    end
  end
  
  in_thread do
    sleep duree_intro
    while continuer == true
      print "un"
      with_fx :reverb, room: 0.45, mix: 0.45 do
        sample bibsmp, smp_Katy,
          beat_stretch: rrand(3, 7),
          start: rrand(0.2, 0.49),
          finish: rrand(0.51, 0.8),
          attack: 0.2,
          release: 0.2,
          amp: rrand(0.54, 0.96)
        sleep 7 + rrand_i(0, 4)
      end
    end
  end
  
  in_thread do
    sleep duree_intro * 3
    while continuer == true
      print "deux"
      with_fx :reverb, room: 0.32, mix: 0.51 do
        with_fx :echo, mix: 0.3 do
          sample bibsmp, smp_Katy,
            rate: [-3, -2, 4, 6].choose,
            attack: 1.2,
            release: 1.2,
            start: rrand(0.05, 0.3),
            finish: rrand(0.7, 0.95),
            amp: rrand(0.5, 0.98)
          sleep 9 + rrand_i(0, 4.5)
        end
      end
    end
  end
  
  in_thread do
    sleep duree_intro * 2
    while continuer == true
      print "trois"
      with_fx :echo, decay: 0.2, phase: 0.15, mix: 0.25 do
        with_fx :wobble, mix: 0.04 do
          with_fx :panslicer, mix: 0.1 do
            sample bibsmp, smp_Katy,
              beat_stretch: rrand(11, 18),
              start: rrand(0, 0.49),
              finish: rrand(0.51, 1),
              attack: 2,
              release: 2,
              amp: rrand(0.5, 0.95)
            sleep 11 + rrand_i(0, 5)
          end
        end
      end
    end
  end
  
  in_thread do
    sleep duree_intro * 3
    while continuer == true
      print "quatre"
      with_fx :echo, decay: 0.3, phase: 0.17, mix: 0.3 do
        with_fx :ping_pong, mix: 0.2 do
          with_fx :flanger, mix: 0.2 do
            sample bibsmp, smp_Katy,
              beat_stretch: rrand(13, 25),
              start: rrand(0, 0.49),
              finish: rrand(0.51, 1),
              attack: 3,
              release: 3,
              amp: rrand(0.5, 0.95)
            sleep 13 + rrand_i(0, 5.5)
          end
        end
      end
    end
  end
  
  in_thread do
    sleep duree_intro * 1.5
    while continuer == true
      print "cinq"
      with_fx :echo, decay: 0.3, phase: 0.17, mix: 0.2 do
        with_fx :distortion, mix: 0.14 do
          with_fx :bitcrusher, mix: 0.13 do
            sample bibsmp, smp_Katy,
              beat_stretch: rrand(16, 28),
              start: rrand(0, 0.49),
              finish: rrand(0.51, 1),
              attack: 4,
              release: 4,
              amp: rrand(0.1, 0.25)
            sleep 17 + rrand_i(0, 6.5)
          end
        end
      end
    end
  end
  
  in_thread do
    sleep duree_intro * 1.2
    while continuer == true
      print "six"
      with_fx :echo, decay: 0.11, phase: 0.14, mix: 0.3 do
        with_fx :ixi_techno, mix: 0.14 do
          with_fx :tremolo, mix: 0.13 do
            sample bibsmp, smp_Katy,
              beat_stretch: rrand(19, 31),
              start: rrand(0, 0.49),
              finish: rrand(0.51, 1),
              attack: 4,
              release: 4,
              rate: -1,
              amp: rrand(0.2, 0.35)
            sleep 14 + rrand_i(0, 3.5)
          end
        end
      end
    end
  end
  
end

cp rcompresso bombtriangles
exe2adf-linux64bit -i bombtriangles -l bombtriangles_$(date +'%F_%T') -a bombtriangles_$(date +'%F_%T').adf
exe2adf-linux64bit -i reffect -l flash2022effect_$(date +'%F_%T') -a flash2022effect_$(date +'%F_%T').adf
exe2adf-linux64bit -i r -l flash2022r_$(date +'%F_%T') -a flash2022r_$(date +'%F_%T').adf
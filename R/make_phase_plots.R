# Comparing StrandPhaseR output

full_res_link = '/Users/hoeps/PhD/hack_23/strandphaser/full_res/strand_states/fullres_finals.txt'
pool_res_link = '/Users/hoeps/PhD/hack_23/strandphaser/pool_res/StrandPhaseR_final_output.txt'


fr = read.table(full_res_link, header=T, sep='\t')
pr = read.table(pool_res_link, header=T, sep='\t')

cell = pr$cell[1]

frsub = fr[fr$cell == cell,]
prsub = pr[pr$cell == cell,]

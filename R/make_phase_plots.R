# Comparing StrandPhaseR output

library(ggplot2)
library(dplyr)

full_res_link = '../data/fullres_finals.txt'
pool_res_link = '../data/StrandPhaseR_final_output.txt'


fullres = read.table(full_res_link, header=T, sep='\t')
poolres = read.table(pool_res_link, header=T, sep='\t')

fullres$source = 0
poolres$source = 0.3

cells = poolres$cell

for (cell in cells){
  

fullres_cell = fullres[fullres$cell == cell,]
poolres_cell = poolres[poolres$cell == cell,]

mixedres_cell = rbind(fullres_cell, poolres_cell)

mixedres_cell[mixedres_cell$chrom == 'chrX', 'chrom'] = 'chr23'
mixedres_cell[mixedres_cell$chrom == 'chrY', 'chrom'] = 'chr24'

mixedres_cell$y_position = as.numeric(sub("chr", "", mixedres_cell$chrom))

plot = ggplot(mixedres_cell) + geom_segment(aes(x=start, 
                                         xend = end, 
                                         y= - (y_position + source), 
                                         yend =  - (y_position + source), 
                                         color=class),
                                     size=2) + 
  labs(x='position[bp]', y='chromsome', title=paste0(cell, ' (top: full; bottom: pooled)')) + theme_bw()

ggsave(file = paste0('../plots/', cell, '.pdf'), plot, width=16, height = 16, units = 'cm', device='pdf' )
}

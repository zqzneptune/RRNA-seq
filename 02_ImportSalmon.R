library(tximport)
fileTx <-
  read.delim(file = "salmonIndex/mouse_gencodeM23/transcripts.txt", 
             header = FALSE, sep = "|",
             stringsAsFactors = FALSE)
colnames(fileTx) <-
  c("transcript_id", "gene_id", "havana_gene", "havana_transcript",
    "transcript_name", "gene_name", "transcript_len", "gene_type")
dirProject <-
  "/home/zhang40q/scott"
dirSalmon <-
  file.path(dirProject, "salmon")
sfFiles <-
  file.path(dirSalmon, dir(dirSalmon), "quant.sf")
txi.salmon <- 
  tximport(sfFiles, type = "salmon", 
           tx2gene = fileTx[, c(1, 2)])
colnames(txi.salmon$counts) <-
  dir(dirSalmon)
saveRDS(txi.salmon, 
        file = file.path(dirProject, paste0(fnProject, "_txisalmon.RDS")))

#### Output TPM for plot graphs ###
library(dplyr)
library(WriteXLS)
mTPM <-
  txi.salmon$abundance
colnames(mTPM)  <-
  dir(dirSalmon)
datTPM <-
  data.frame(`gene_id` = rownames(mTPM),
             mTPM,
             stringsAsFactors = FALSE)
geneAnno <-
  unique(fileTx[, c("gene_id", "gene_name")])
outputTPM <-
  right_join(geneAnno, datTPM, by ="gene_id")
WriteXLS(outputTPM, 
         ExcelFileName = 
           file.path(dirProject, paste0(fnProject, "_GeneTPM.xlsx")))

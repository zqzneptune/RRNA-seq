library(DESeq2)
txi <-
  readRDS("project/scott/scott_txisalmon.RDS")
sampleTable <- 
  data.frame(`condition` = c("A", "B", "A", "B"))
rownames(sampleTable) <- 
  colnames(txi$counts)

ddsTxi <- 
  DESeqDataSetFromTximport(txi, sampleTable, ~ `condition`)
keep <- 
  rowSums(counts(ddsTxi)) >= 10
dds <- 
  ddsTxi[keep, ]

dds$Condition <-
  relevel(dds$Condition, ref = "A")
dds <- 
  DESeq(dds)
res <-
  results(dds, independentFiltering = FALSE,
          contrast = c("Condition", "B", "A"))

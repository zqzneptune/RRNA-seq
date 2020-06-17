# Step 1
Navigate to directory *salmonIndex*, and run `gencodeHs.sh` and/or `gencodeMm.sh` to generate Salmon index for human and/or mouse respectively. Prerequisite software needs to be downloaded, see the shell script for instructions.

# Step 2 
Run `01_RunSalmon.R` to run Salmon on each samples to generate *quant.sf*

# Step 3
Run `02_ImportSalmon.R` to collect Salmon output and output matrix data for downstream analysis.

# Step 4
Run `03_DEseq2.R` to run differential gene expression analysis.
salmonBin <-
  "/home/zhang40q/.salmon-1.2.1/bin/salmon"
salmonIndex <-
  "salmonIndex/mouse_gencodeM23/"
dirProject <-
  "/home/zhang40q/scott"
dirFastq <-
  file.path(dirProject, "fastq")
fnFastq <-
  dir(dirFastq, pattern = "_R(1|2)_001.fastq.gz")
fnSample <-
  unique(gsub("_R(1|2)_001.fastq.gz", "", fnFastq))
for(fn in fnSample){
  fnDir <-
    file.path(dirProject, "salmon", fn)
  if(!dir.exists(fnDir)){
    dir.create(fnDir, recursive = TRUE)
  }
  message(fn)
  if(file.exists(file.path(fnDir, "quant.sf"))){
    message("Done!")
  }else{
    message("Precessing ...")
    system(paste0(salmonBin,
                  " quant -i ",
                  salmonIndex,
                  " -l A -1 ",
                  paste0(dirFastq, "/", fnSample, "_R1_001.fastq.gz"),
                  " -2 ",
                  paste0(dirFastq, "/", fnSample, "_R2_001.fastq. gz"),
                  " --validateMappings -o ", fnDir))
  }
}

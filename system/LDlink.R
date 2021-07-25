#!/usr/bin/Rscript

library(LDlinkR)
setwd("temporary")
snps<-as.matrix(read.table("tempsnps"))
input<-c(snps)
SNPclip(input, pop = "CEU", r2_threshold = "0.1", maf_threshold = "0.01", token = "enter_yours", file = "tempa")

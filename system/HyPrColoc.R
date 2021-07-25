#!/usr/bin/Rscript

library(hyprcoloc)
setwd("temporary")
beta = dir(pattern='_HyPrColoc_Beta.txt')
beta_table = read.table(beta, header=T, stringsAsFactor=F)
se = dir(pattern='_HyPrColoc_SE.txt')
se_table = read.table(se, header=T, stringsAsFactor=F)
betas <- as.matrix(beta_table,header=T,row.names=1)
ses <- as.matrix(se_table,header=T,row.names=1)
id<-row.names(ses[which(is.na(ses)),])
ses<-ses[setdiff(row.names(ses),id),]
betas<-betas[setdiff(row.names(ses),id),]
id<-row.names(betas[which(is.na(betas)),])
betas<-betas[setdiff(row.names(betas),id),]
ses<-ses[setdiff(row.names(betas),id),]
traits <- paste0("T", 1:dim(betas)[2]);
rsid <- rownames(betas);
res <- hyprcoloc(betas, ses, trait.names=traits, snp.id=rsid);
write.table(res$results[,c(3:6)],"out_hyprcoloc.txt",quote=F,row.names=F,sep="\t")


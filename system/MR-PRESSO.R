#!/usr/bin/Rscript

library(MRPRESSO)
setwd("temporary")
input = dir(pattern='MR-PRESSO')
gene<-as.data.frame(read.table(input, header=T, row.names=1))
output<-mr_presso(BetaOutcome="Y_Effect", BetaExposure="E1_Effect", SdOutcome="Y_se", SdExposure="E1_se", OUTLIERtest=TRUE, DISTORTIONtest=TRUE, data=gene, NbDistribution=1000, SignifThreshold=0.05)
write.table(output$`Main MR results`, paste("Main_MR_results_",input,".txt",sep=""), quote=F, row.names=F,sep="\t")
write.table(output$`MR-PRESSO results`$`Global Test`$Pvalue, paste("Global_Test_",input,".txt",sep=""), quote=F, row.names=F,col.names="Global_test_P", sep="\t")
write.table(output$`MR-PRESSO results`$`Outlier Test`, paste("Outlier_Test_",input,".txt",sep=""), quote=F, row.names=T,sep="\t")
write.table(output$`MR-PRESSO results`$`Distortion Test`$Pvalue, paste("Distortion_Test_",input,".txt",sep=""), quote=F, row.names=F,col.names="Distortion_Test_P", sep="\t")
write.table(output$`MR-PRESSO results`$`Distortion Test`$`Outliers Indices`, paste("Outliers_Indices_",input,".txt",sep=""), quote=F, row.names=F,col.names="Outliers_Indices", sep="\t")

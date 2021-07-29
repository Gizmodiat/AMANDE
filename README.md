# Automated Mendelian rAndomization aND bayEsian colocalization (AMANDE)
AMANDE performs automated Mendelian randomizations, Bayesian colocalizations and horizontal pleiotropy detections from genetic association studies.  
AMANDE uses eQTLGen, GTEx V8 and INTERVAL as exposures and Genome-Wide association studies (GWAS) as outomes to perform analysis from a list of exposures (genes or proteins). Instrumental variables (IVs) pruning for Mendelian randomizations and harmonizations for alleles are performed automatically.  
AMANDE is designed for **hg19/build37**.  
_(tested with Ubuntu 20.04.2 LTS, R version 4.1.0 and python2.7)_

# **Prerequired**  
Install the following R packages: LDlinkR, MendelianRandomization, hyprcoloc, MRPRESSO.  
_**Retrieve a token for LDlink after registration at https://ldlink.nci.nih.gov/?tab=apiaccess**_  
Keep your own registered token.  

Ensure python2 is installed.  

Download eQTLGen data (4.5GB compressed) from:  
https://www.dropbox.com/s/nf0rxyls5bgudsh/eQTLGen_for_AMANDE.zip?dl=0  
Unzip:  
`unzip eQTLGen_for_AMANDE.zip`  

Download GTEx v8 data:  
_**Please contact me (arnaud.chignon@hotmail.com).**_  
AMANDE uses data reformatted from the cis-eQTL associations tested in each tissue. Original data available in a requester pays bucket must be downloaded prior to use the reformatted GTEx data for AMANDE. More information here: https://gtexportal.org/home/datasets  
After the download of original GTEx data, I will provide a compressed file 'GTExv8_AMANDE_FORMAT.zip' (49 tissues ~115GB compressed).  
Unzip this file:  
`unzip GTExv8_AMANDE_FORMAT.zip`

Download INTERVAL data (3,283 SOMAmers used to assay the 2,995 proteins ~2.4TB when uncompressed) from:  
https://app.box.com/s/u3flbp13zjydegrxjb2uepagp1vb6bj2 or alternatively connect to the site using rclone or lftp. For instructions please contact Adam Butterworth (asb38@medschl.cam.ac.uk).  
Download the entire dataset or protein(s) of interest if needed  (see Sun et al. _Nature_, 2018).  
Each folder, which is named according to the ID of the SOMAmer, must be unzipped. In addition, the 22 gzipped files in folders must be uncompressed to obtain '.tsv' text files.  
_**Create a folder named 'INTERVAL_for_AMANDE' and put folders unzipped containing the ungzipped '.tsv' files inside it.**_  

Download snp151 data (9.64GB compressed) from:  
https://www.dropbox.com/s/6crvgalonj68q6u/snp151_for_AMANDE.zip?dl=0  
Unzip:  
`unzip snp151_for_AMANDE.zip`  

# **Installation and configuration**  

Clone AMANDE to your home folder and give permissions:  
`cd ~`  
`git clone https://github.com/Gizmodiat/AMANDE.git`  
`chmod -R 777 AMANDE`  
`cd AMANDE`  

Replace the example token `token="enter_yours"` with your own token in the LDlink.R file:  
`gedit system/LDlink.R`  

Create a 'GTEx_for_AMANDE' folder. Select tissues of interest by  creating symbolic links in this folder from tissues in the 'GTExv8_AMANDE_FORMAT' folder. 
To perform analysis on whole blood and testis for example, enter:  
`cd path_to_GTEx_for_AMANDE`  
`ln -s path_to_GTExv8_AMANDE_FORMAT/GTEx_Analysis_v8_eQTL_all_associations_Whole_Blood`  
`ln -s path_to_GTExv8_AMANDE_FORMAT/GTEx_Analysis_v8_eQTL_all_associations_Testis`  

Edit the config.txt file with your own paths to the folders eQTLGen_for_AMANDE, GTEx_for_AMANDE, INTERVAL_for_AMANDE and snp151_for_AMANDE:  
`cd ~`  
`cd AMANDE`  
`gedit config.txt`  

_Optional:  
Adjust settings for IVs pruning (default settings are CEU population, LD r2 threshold <0.1 and MAF>0.01) by modifying `pop = "CEU", r2_threshold = "0.1", maf_threshold = "0.01"` in the LDlink.R file (population codes for LDlink are given below):_  
`gedit system/LDlink.R`   

# **Input files**  
AMANDE needs two input files: one for exposures and one for the outcome.  

_**Prepare an input file for exposures**_: genes (eQTLGen or GTEx) or proteins (INTERVAL):  
For genes, prepare a '.txt' file containing a list of the Ensembl ID of the exposures and the genomic positions (chromosome and position) from which perform IVs pruning and colocalizations: each line of this file will contain the Ensembl ID of an exposure and a genomic position like `ENSG00000042493_2_85645555` (see 'example_ENSEMBL_list.txt' in the 'example' folder).  

For proteins, prepare an equivalent '.txt' file containning the ID of SOMAmers and proteins, and the genomic positions like `IL6R.8092.29.3_1_154377669` (see 'example_INTERVAL_list.txt' in the example folder).  

_**Prepare an input file for the outcome**_  
The outcome '.txt' file is prepared from GWAS summary statistics, and must contain the 6 following columns: rs _or_ chr:position | Effect Allele | Other Allele | Beta | se | Pvalue. Example:
`chr1:1234 A T 0.8 0.002 1.23e-10`
_or_
`rs1234 A T 0.8 0.002 1.23e-10`  
_**IMPORTANT: don't forget to remove duplicates, `0` and/or `NA/Na/nan...` in outcome data if necessary.**_  

# **Usage**  

Run AMANDE with the following syntax:  
`./AMANDE.exe <input_exposures.txt> <input_outcome.txt> [-rs | -chr] [-eqtlgen | -gtex | interval] [-window] [-pvalue] [-output]`  

`-rs | -chr`: select the snp ID format of outcome.  
`-eqtlgen | -gtex | interval`: select the exposure of interest.  
-`window`: set the window from which performs Mendelian randomizations and colocalizations in kilobases (for example `-500` will set a window of 500 kilobases arround the genomic positions entered for exposures in the 'input_exposures.txt' file).  
`-pvalue`: the P-value threshold for the associations between snps and exposures for IVs pruning.  
`-output`: the output prefix name. This name will be the name of the main output folder and the prefix of sub-folders and files.  

_Example for eQTLGen:_  
`./AMANDE.exe example_ENSEMBL_list.txt CAD.txt -chr -eqtlgen -250 -0.001 -eQTLGen_CAD_250kb_p001`  

# **Outputs**  

_**Summary of analysis**_  
The 'summary.txt' file in the main folder gives several important data from the Mendelian randomizations and colocalizations analysis:  

Column #1 and #2:  
`Gene/Protein`: ID of exposures.  
 `IV`: number of IVs according to the puning settings. _**Minimum 3 to perform Mendelian randomizations, and 4 for MR-PRESSO.**_  

Columns #3 to #8: Mendelian Randomizations (from the MendelianRandomization R package) :  
`IVW_QQ_P`: Cochran's Q test P-value about the inverse-variance weighted estimate.  
`IVW_Estimate`: inverse-variance weighted estimate.  
`IVW_P`: inverse-variance weighted P-value.  
`Egger_Estimate`: Egger estimate.  
`Egger_P`: Egger P-value.  
`Egger_Intercept_P`: Egger intercept P-value.  

Columns #9 to #12: Bayesian colocalizations (from the hyprcoloc R package):  _**WARNING: empty if there are duplicates, 0 or NAs in outcome data. Don't forget to remove them.**_  
`Posterior_prob`: posterior probability.  
`Regional_prob`: regional probability.  
`Candidate_snp`: causal candidate snp.  
`Posterior_explained_by_snp`: posterior probability of the causal candidate snp.  

Columns #13 to #18: Evaluation of horizontal pleiotropy (from the MPRESSO R package). _**Can be empty if there are less than 4 IVs**_: 
`Global_Test_P`: P-value of the global test.  
`Estimate`: inverse-variance weighted estimate.  
`P`: inverse-variance weighted P-value.  
`Estimate_Out-Corr`: inverse-variance weighted estimate after outlier(s) removal.  
`P_Out-Corr`: inverse-variance weighted P-value after outlier(s) removal.  
`Distortion_Test_P`: distorsion test P-value. Can be empty if the outlier test does not detect which IV(s) is/are outlier(s).  

_**Details of analysis**_  
Subfolders of AMANDE contain input files for each package, and output files generated (for example the inverse-variance weighted and Egger regression plots as '.pdf' files for Mendelian Randomizations, and a list of outliers if identified by MR-PRESSO).  

The subfolders 'IVs' provides details about the IVs pruning, including potential IVs, list of IVs...  
_**In case of error during pruning, pay attention to the 'log_SNPClip.txt' file to check if it is due to a LDlink server error**_

_Please note that harmonizations are performed after IVs pruning, so for inputs files of packages. Thus, data about IVs in the 'IVs' folders are not harmonized._ 

# **Don't forget to cite...**  
_...and read these papers :blush:_

_**Please cite all or a part of the following papers depending on exposures data used:**_

**LDlink:** Machiela and Chanock. LDlink: a web-based application for exploring population-specific haplotype structure and linking correlated alleles of possible functional variants. _Bioinformatics_, 2015.  

**MendelianRandomization:** Yavorska and Burgess. MendelianRandomization: an R package for performing Mendelian randomization analyses using summarized data. _Int J Epidemiol_, 2017.  

**hyprcoloc:**  Foley et al. A fast and efficient colocalization algorithm for identifying shared genetic risk factors across multiple traits. _Nat Commun._, 2021.  

**MR-PRESSO:** Verbanck et al. Detection of widespread horizontal pleiotropy in causal relationships inferred from Mendelian randomization between complex traits and diseases. _Nat Genet._, 2018.  

**eQTLGen:** Võsa et al. Unraveling the polygenic architecture of complex traits using blood eQTL metaanalysis. _bioRxiv_, 2018.  

**GTEx:** The GTEx Consortium. The GTEx Consortium atlas of genetic regulatory effects across human tissues. _Science_, 2020.  

**INTERVAL:** Sun et al.  Genomic atlas of the human plasma proteome. _Nature_, 2018. 

**LDlink population codes:**  
pop_code, super_pop_code, pop_name:  
`ALL            ALL                           ALL POPULATIONS`  
`AFR            AFR                                   AFRICAN`  
`YRI            AFR                  Yoruba in Ibadan, Nigera`  
`LWK            AFR                    Luhya in Webuye, Kenya`  
`GWD            AFR                 Gambian in Western Gambia`  
`MSL            AFR                     Mende in Sierra Leone`  
`ESN            AFR                            Esan in Nigera`  
`ASW            AFR   Americans of African Ancestry in SW USA`  
`ACB            AFR           African Carribbeans in Barbados`  
`AMR            AMR                         AD MIXED AMERICAN`  
`MXL            AMR    Mexican Ancestry from Los Angeles, USA`  
`PUR            AMR            Puerto Ricans from Puerto Rico`  
`CLM            AMR        Colombians from Medellin, Colombia`  
`PEL            AMR                 Peruvians from Lima, Peru`  
`EAS            EAS                                EAST ASIAN`  
`CHB            EAS              Han Chinese in Bejing, China`  
`JPT            EAS                  Japanese in Tokyo, Japan`  
`CHS            EAS                      Southern Han Chinese`  
`CDX            EAS       Chinese Dai in Xishuangbanna, China`  
`KHV            EAS         Kinh in Ho Chi Minh City, Vietnam`  
`EUR            EUR                                  EUROPEAN`  
`CEU            EUR Utah Residents from North and West Europe`  
`TSI            EUR                         Toscani in Italia`  
`FIN            EUR                        Finnish in Finland`  
`GBR            EUR           British in England and Scotland`  
`IBS            EUR               Iberian population in Spain`  
`SAS            SAS                               SOUTH ASIAN`  
`GIH            SAS  Gujarati Indian from Houston, Texas, USA`  
`PJL            SAS             Punjabi from Lahore, Pakistan`  
`BEB            SAS                   Bengali from Bangladesh`  
`STU            SAS              Sri Lankan Tamil from the UK`  
`ITU            SAS                 Indian Telugu from the UK`  

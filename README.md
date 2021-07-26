# Automated Mendelian rAndomization aND bayEsian colocalization (AMANDE)
AMANDE performs automated Mendelian randomizations, Bayesian colocalizations and horizontal pleiotropy detections from genetic association studies.

# **Prerequired:**  
Install the following R packages: LDlinkR, MendelianRandomization, hyprcoloc, MRPRESSO.  
_**Retrieve a token for LDlink after registration at https://ldlink.nci.nih.gov/?tab=apiaccess**_  
Keep your own registered token.  

Download eQTLGen data (4.5GB compressed) from:  
https://www.dropbox.com/s/nf0rxyls5bgudsh/eQTLGen_for_AMANDE.zip?dl=0  
Unzip:  
`unzip eQTLGen_for_AMANDE.zip`  

Download GTEx v8 data:  
_**Please contact me.**_  
AMANDE uses data reformatted from the cis-eQTL associations tested in each tissue. Original data available in a requester pays bucket must be downloaded prior to use the reformatted GTEx data for AMANDE. More information here: https://gtexportal.org/home/datasets  
After downloading the original GTEx data, I will provide a compressed file "GTEx_for_AMANDE.zip" (49 tissues ~115GB).  
Unzip it:  
`unzip GTEx_for_AMANDE.zip`

Download INTERVAL data (3,283 SOMAmers used to assay the 2,995 proteins ~2.4TB uncompressed) from:  
https://app.box.com/s/u3flbp13zjydegrxjb2uepagp1vb6bj2  
Download the entire dataset or protein(s) of interest if needed.  
Each folder, which is named according to the ID of the SOMAmer, must be unzipped. In addition, the 22 gzipped files in each folder must be uncompressed to obtain .tsv text files.  
_**Folders unzipped containing the ungzipped .tsv files must be located in a folder named "INTERVAL_for_AMANDE".**_

Download snp151 data (9.64GB compressed) from:  
https://www.dropbox.com/s/6crvgalonj68q6u/snp151_for_AMANDE.zip?dl=0  
Unzip:  
`unzip snp151_for_AMANDE.zip`  

# **Installation and configuration:**  
Clone AMANDE to your home folder:  
`cd ~`  
`git clone https://github.com/Gizmodiat/AMANDE.git`  
`unzip AMANDE.zip`  
`cd AMANDE`  

Replace the example token `token="enter_yours"` with your own token in the LDlink.R file:  
`gedit system/LDlink.R`  

Edit the config.txt file with your own paths to the folders eQTLGen_for_AMANDE, GTEx_for_AMANDE, INTERVAL_for_AMANDE and snp151_for_AMANDE:  
`gedit config.txt`  

_Optional:_
Adjust settings for instrumental variables (IVs) pruning are CEU population, LD r2 threshold <0.1 and MAF>0.01. If necessary adjust the settings by editing


# **Usage:**  
Input files


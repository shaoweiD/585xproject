<center> Bovine Spongiform Encephalopathy Surveillance Statistics in the United Kingdom </center>
========================================================
Bovine Spongiform Encephalopathy(BSE), or the so called "Mad Cow" disease,is a kind of prion related disease, which is fatal and trigger neurological dysfunction in Cattles. Prions are neither bacteria nor viruses, with no genetic informaiton, but still causes disease. It has long invubation period and progess inexorably once clinical conditions occur.(Araujo,2013) BSE can be transmitted by eating food containing brain,spinal cord or other nervous system tissue fro an infected animal, and prions begin to slowly transform normal protein into the abonormal prion shape, which eventually leads to fatal damage to the nervous system.The human form of BSE is called Creutzfeldt-Jakob Disease(CJD).BSE can cause death usually within one year of onset of illness.

Bovine Spongiform Encephalopathy disease was first found in the mid-1980s from 16 cattle, and that number dramatically increased to over 190,000 cases worldwide, with the majority of them in Europe.(Lee et al., 2013) ,Which led to a disaster to human, the agricultural industry and the food industry. The worst case of BSE was happened in the United Kingdom, and in this analysis, we will take a close look at the developent of BSE in the United Kingdom.

These data is obtained from Animal Health and Veterinary Laboratories Agency,"http://www.defra.gov.uk/ahvla-en/publication/tse-stats-cattle/". Four pdfs have data from before year 1987 to 2014, and then I converted them to csv format.Additionally, I downloaded the UK shape file, which can be used to plot the distribution of BSE. 

#Required Packages<br/>

library(reshape)<br/>
library(ggplot2)<br/>
library(knitr)<br/>
library(maptools)



```r
overall <- read.csv("C:/Users/sding/Documents/GitHub/585xproject/OVERALL.csv")
```



<center> Bovine Spongiform Encephalopathy Surveillance Statistics in United Kingdom </center>
========================================================
**Background**<br/>
Bovine Spongiform Encephalopathy(BSE), or the so called "Mad Cow" disease,is a kind of prion related disease, which is fatal and trigger neurological dysfunction in Cattles. Prions are neither bacteria nor viruses, with no genetic informaiton, but still causes disease. It has long invubation period and progess inexorably once clinical conditions occur.(Araujo,2013) BSE can be transmitted by eating food containing brain,spinal cord or other nervous system tissue fro an infected animal, and prions begin to slowly transform normal protein into the abonormal prion shape, which eventually leads to fatal damage to the nervous system.The human form of BSE is called Creutzfeldt-Jakob Disease(CJD).BSE can cause death usually within one year of onset of illness.

**Motivation**<br/>
Bovine Spongiform Encephalopathy disease was first found in the mid-1980s from 16 cattle, and that number dramatically increased to over 190,000 cases worldwide, with the majority of them in Europe.(Lee et al., 2013) ,Which led to a disaster to human, the agricultural industry and the food industry. The worst case of BSE was happened in the United Kingdom, and in this analysis, we will take a close look at the developent of BSE in the United Kingdom.Since the research I am doing is about BSE diagnosis, and I think it is interesting to look at the history of this disease. Moreover, by inverstingating this case, it makes people have a better awareness of the importance of food safety.

**Data Collecting**<br/>
These data is obtained from Animal Health and Veterinary Laboratories Agency,"http://www.defra.gov.uk/ahvla-en/publication/tse-stats-cattle/". Four pdfs have data from before year 1987 to 2014, and then I converted them to csv format.Additionally, I downloaded the UK shape file, which can be used to plot the distribution of BSE.Since the name of every city in two files dont match, I need to do some modification to plot the map.

**Required Packages**<br/>

library(reshape)<br/>
library(ggplot2)<br/>
library(knitr)<br/>
library(maptools)<br/>
library(plyr) 

**Read the data**

```r
overall <- read.csv("C:/Users/sding/Documents/GitHub/585xproject/OVERALL.csv")
city<-read.csv("C:/Users/sding/Documents/GitHub/585xproject/OVERALL.csv")
uk<-readShapeSpatial('C:/Users/sding/Documents/GitHub/585xproject/uk/map.shp')
#there are more dataset that need to be cleaned in order to do analysis
```
**Possible questions that could be answered**<br/>

1. What is the overall trending of BSE from 1987 to 2014? What is the trending of passive Surveillance and active surveillance?<br/>

2. What are the locations of BSE in UK?<br/>

3. What is the percent reduction year on year?<br/>

4. How many confirmed cases of BSE per million head of cattle population over 24 months of age?<br/>

5. What is the trending of BSE by comfirmed cases of BSE in the UK by year of birth and age?<br/>

6. On August 1st, 1996, extra control measures on animal feed containing mammalian meat and bone meal are considered to have been fully implemented, and what is trending of BSE after this date? <br/>

7. Since UK has the great britain and the northern ireland, for all of these problems, we can look at these trendings seperately.<br/>
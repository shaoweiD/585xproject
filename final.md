<center> Bovine Spongiform Encephalopathy Surveillance Statistics in United Kingdom and a Shiny App for Raman Spectra Analysis </center>
========================================================
<center> Shaowei Ding </center>
<center> Ag & Biosystems Engineering </center>
<center> STAT 585X </center>

**Background**<br/>
Bovine Spongiform Encephalopathy(BSE), or the so called "Mad Cow" disease,is a kind of prion related disease, which is fatal and trigger neurological dysfunction in Cattles. Prions are neither bacteria nor viruses, with no genetic informaiton, but still causes disease. It has long incubation period and progess inexorably once clinical conditions occur.(Araujo,2013) BSE can be transmitted by eating food containing brain,spinal cord or other nervous system tissue from an infected animal, and prions begin to slowly transform normal protein into the abnormal prion shape, which eventually leads to fatal damages to the nervous system.The human form of BSE is called Creutzfeldt-Jakob Disease(CJD).BSE can cause death usually within one year of onset of illness.
Currently disease diagnosis is still limited, and there isn't a mature technique that can detect BSE at a earlier stage. Diseased animals have protein transformation in the central nervous system. Since retina is a derivative of forebrain, it is the most exposed portion of the central nervous system. Raman spectroscopy is a kind of non-invasive and non-destructive technique and can be used to measure unique fingerprint for different disease. And by applying this spectroscopy in retina, the most exposed nervous tissue; it is highly possible that BSE can be diagnosed accurately and at earlier stage.<br/>
**Motivation**
Bovine Spongiform Encephalopathy disease was first found in the mid-1980s from 16 cattle, and that number dramatically increased to over 190,000 cases worldwide, with the majority of them in Europe.(Lee et al., 2013) ,Which led to a disaster to human, the agricultural industry and the food industry. The worst case of BSE happened in the United Kingdom, and in this analysis, we will take a closer look at the developent of BSE in the United Kingdom. Since the research I am doing is about BSE diagnosis, and I think it is interesting to look at the history of this disease. Moreover, by investigating this case, it makes people have a better awareness of the importance of food safety.

**Data Collecting**<br/>
These data is obtained from Animal Health and Veterinary Laboratories Agency,"http://www.defra.gov.uk/ahvla-en/publication/tse-stats-cattle/".BSE cases in every year/every month is available, and it is also catagorized into active and passive surveillance. Also the birth date and age of all suspected animals are recorded. Four pdfs have data from before year 1987 to 2014, and then I converted them to csv format.Additionally, I downloaded the UK shape file, which can be used to plot the distribution of BSE.Since the name of every city in two files don't match, I need to do some modification to plot the map.

**Required Packages**<br/>

library(reshape)<br/>
library(ggplot2)<br/>
library(knitr)<br/>
library(maptools)<br/>
library(plyr) <br/>
install.packages("Mcow")


**Possible questions that could be answered**<br/>

1. What is the overall trending of BSE from 1987 to 2014? What is the trending of passive Surveillance and active surveillance?<br/>

2. What are the locations of BSE?<br/>

3. What is the percent reduction year on year?<br/>

4. How many confirmed cases of BSE per million head of cattle population over 24 months of age?<br/>

5. What is the trending of BSE by comfirmed cases of BSE in the UK by year of birth and age?<br/>

6. On August 1st, 1996, extra control measures on animal feed containing mammalian meat and bone meal are considered to have been fully implemented, and what is trending of BSE after this date? <br/>


**trend of passive and active surveillance in united kingdom**<br/>
First let's take a look at the general trend of BSE cases from 1987 to 2014 based on passive and active surveillance.


```r
library(reshape)
```

```
## Loading required package: plyr
## 
## Attaching package: 'reshape'
## 
## The following objects are masked from 'package:plyr':
## 
##     rename, round_any
```

```r
library(ggplot2)
pa <- read.csv("passive and active.csv")
pa$Year <- as.character(pa$Year)
pa$Year[pa$Year == "Pre 1988"] <- "1986-1988"
a.melt <- melt(pa[1:28, c(1:3, 5:6)], id = c("Year"))
pd <- position_dodge(0.1)
ggplot(data = a.melt, aes(x = Year, y = value, colour = variable)) + geom_line(position = pd, 
    aes(group = variable))
```

```
## ymax not defined: adjusting position using y instead
```

![Passive and active surveillance in great britain and northern Ireland](figure/unnamed-chunk-1.png) 

This plot shows the majority of data is from the passive surveillance in great britain, and BSE cases were the most from 1989-1996.Now we can take a look at great britain.

**trend of passive surveillance in great britain**<br/>

```r
overall <- read.csv("OVERALL.csv")
trend <- overall[1:28, ]
trend.det <- melt(trend)
```

```
## Using YEAR as id variables
```

```r
pd <- position_dodge(0.1)
ggplot(data = trend.det, aes(x = YEAR, y = value, colour = variable)) + geom_line(position = pd, 
    aes(group = variable))
```

```
## ymax not defined: adjusting position using y instead
```

![Passive surveillance in great britain](figure/unnamed-chunk-2.png) 


This plot shows the trend of restricted case and confirmed case. They all follow the similar curve, but the amplitude is different. The amount of suspected cases is a lot and almost all of those animals were slaughtered. Among them, the purple curve represents the actual confirmed cases.

**Cattle population over 24 months of ages and number of confirmed cases per million**<br/>
Since  the population of cattles were not constant during the time when people recorded the data, it is meaningful to take a look at the percentage of suspected of animals based on a time interval. Also, because of  a big motaility rate, the analysis can be focused on cattle with age older than 24 months. The x axis is the period when people took measurement, and the y axis is the amount of cattles confirmed with BSE disease.


```r
library(reshape)
library(ggplot2)
library(Mcow)
```

```
## 
## Attaching package: 'Mcow'
## 
## The following object is masked from 'package:base':
## 
##     date
```

```r
age24 <- read.csv("millioncattle.csv")
age24 <- age24[c(1:75), -c(5, 8)]
colnames(age24) <- c("start", "end", "million of cattles", "# of case by date of confirmation", 
    "# of case by date of restriction", "# per million by data of confirmation", 
    "# per million by date of restriction")
age.sub <- age24[-1, ]
age.sub$name <- 1:74
# I couldn't run Mcow packages from a different computer, so I add this
# function in case the package wont be loaded in a different computer.
date <- function(x) {
    as.Date(x = paste("1-", x, sep = ""), format = "%d-%b-%y")
}
age.sub[, 1] <- date(age.sub[, 1])
age.sub[, 2] <- date(age.sub[, 2])
age.sub$"# per million by data of confirmation" <- as.numeric(as.character(age.sub$"# per million by data of confirmation"))
mdfr <- melt(age.sub, measure.vars = c("start", "end"))
mage <- melt(age.sub, measure.vars = c("start", "end"))
layout(t(1:2))
ggplot(mdfr, aes(mdfr$value, as.factor(mdfr$"million of cattles"))) + geom_line(size = 6) + 
    xlab("period") + ylab("million of cattles") + theme_bw()
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-31.png) 

```r
ggplot(mage, aes(mage$value, as.factor(mage$"# per million by data of confirmation"))) + 
    geom_line(size = 6) + xlab("period") + ylab("number per million by data of confirmation") + 
    theme_bw()
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-32.png) 

This plot indicates the population from 1987 to 2014 has been decreasing and the lowest level is in 2014, which might be under the<br/> influence of mad cow diease. BSE caused the decrease of the demand of beef and this corresponds to the trend as shown in the plot.<br/>

```
## Loading required package: sp
## Checking rgeos availability: FALSE
##  	Note: when rgeos is not available, polygon geometry 	computations in maptools depend on gpclib,
##  	which has a restricted licence. It is disabled by default;
##  	to enable gpclib, type gpclibPermit()
```
**Distribution of confimed cases and farms in Great Britain**<br/>

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-41.png) ![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-42.png) 


The color gradient indicates the distribution of BSE cases and farms where BSE cases have been found.<br/>

**Percent Reduction year on year**<br/>

```r
# percent reduction head(trend)
red <- trend[, c(1, 2, 8)]
red$"percent reduction year on year(suspected)" <- NA
red$"percent reduction year on year(confirmed)" <- NA
i <- NA
j <- NA
per <- NA
red[1:28, 2:3] <- as.matrix(sapply(red[1:28, 2:3], as.numeric))
percent <- function(x, digits = 2, format = "f", ...) {
    paste(formatC(100 * x, format = format, digits = digits, ...), "%", sep = "")
}

for (i in 3:(length(red$SUSPECTS.RESTRICTED))) {
    red$"percent reduction year on year(suspected)"[i] <- as.numeric((-red$SUSPECTS.RESTRICTED[i - 
        1] + red$SUSPECTS.RESTRICTED[i])/red$SUSPECTS.RESTRICTED[i - 1])
    red$"percent reduction year on year(confirmed)"[i] <- as.numeric((-red$SLAUGHTERED.SUSPECTS.IN.WHICH.BSE.CONFIRMED[i - 
        1] + red$SLAUGHTERED.SUSPECTS.IN.WHICH.BSE.CONFIRMED[i])/red$SLAUGHTERED.SUSPECTS.IN.WHICH.BSE.CONFIRMED[i - 
        1])
    if (red$SLAUGHTERED.SUSPECTS.IN.WHICH.BSE.CONFIRMED[i - 1] == 0) {
        red$"percent reduction year on year(confirmed)"[i] <- 0
    }
}

red.melt <- melt(red[, c(1, 4, 5)], id = c("YEAR"))
red.melt$value <- as.numeric(red.melt$value)
red.melt$value[is.na(red.melt$value)] <- 0
pd <- position_dodge(0.1)
ggplot(data = red.melt, aes(x = YEAR, y = value, colour = variable)) + geom_line(position = pd, 
    aes(group = variable))
```

```
## ymax not defined: adjusting position using y instead
```

![plot of chunk percent reduction](figure/percent_reduction.png) 

This plot shows the percentage reduction of confirmed and suspected cases year on year.<br/>

**the trend of different age in great britain (confirmed case)** <br/>

```r
age <- read.csv("age.gb.csv")
age <- age[-1, -2]
age$"Birth Period" <- 1982:2006
```

```
## Error: replacement has 25 rows, data has 27
```

```r
colnames(age) <- c("Birth Period", "1 year old", "2 year old", "3 year old", 
    "4 year old", "5 year old", "6 year old", "7 year old", "8 year old", "9 year old", 
    "10 year old")
age.melt <- melt(age, id = "Birth Period")
age.melt$value <- as.numeric(age.melt$value)
age.melt$"Birth Period" <- as.numeric(age.melt$"Birth Period")
age.melt$variable <- as.factor(age.melt$variable)

pd <- position_dodge(0.1)
ggplot(data = age.melt, aes(x = age.melt$"Birth Period", y = value, colour = variable)) + 
    geom_line(position = pd, aes(group = variable))
```

```
## ymax not defined: adjusting position using y instead
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 

If we set age as a factor, age of cattles seems to be proportional to number of cases.<br/> 

**In recent two years, the distribution of BSE cases in great britain** <br/>

```r
recent <- read.csv("C:/Users/sding/Documents/GitHub/585xproject/recent.csv")
a <- recent[-1, c(1, 2, 3, 4)]
recent[, c(2, 3, 4)] <- as.matrix(sapply(recent[, c(2, 3, 4)], as.numeric))
a$cases <- rowSums(recent[-1, c(2, 3, 4)])
a$County <- gsub("&", "and", a$County)
a <- a[, -c(2, 3, 4)]
a$County[a$County == "North-West Wales"] <- "Ceredigion"
colnames(a) <- c("region", "cases")

rec.dis <- merge(oz.subset, a, by = "region")
rec.dis$cases <- as.numeric(rec.dis$cases)
ggplot() + geom_polygon(data = oz.subset, aes(x = x, y = y, order = order, group = group)) + 
    geom_polygon(data = rec.dis, aes(x = x, y = y, order = order, group = group, 
        fill = rec.dis$cases))
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6.png) 


Even though BSE is no longer active in the UK, there are still cases appeared in recent years. Since prion disease is hard to diagnose<br/> and it spread easily through food contamination, attention is still required to monitor the development of BSE.

**A shiny App for Raman Spectra Analysis** <br/>
It can be run from <br/>
library(shiny)<br/>
runGist(11195851)<br/>
In the app, data is uploaded as required format and based on user's preferance, the desired plot will be displayed in the main panel.<br/> Additionally, the result can be downloaded from the buttion on the left. However, uploaded data need to be corrected by polynomial<br/> baseline correction, smoothing and normalization.

**Mcow Package** <br/>
The packages I built for this project is consisted of 4 functions: data,extractPolygons(the function in class),percent and percentage_red<br/>uction. This is not quite complete, and some modifications need to be made.<br/>
date: This function to reformat the date in the given dataset<br/>
extractPolygons: The function to extract polygons<br/>
percent: The function to format data into percentage format<br/>
percent_reduction: This function to calculate percent reduction year on year<br/>
                        
**Discussion and Conclusion** <br/>

From this analysis,BSE cases have been decreasing dramatically during the past decade, however, there are still BSE existing and more<br/> prion diseases like scrapie and CJDs appear, which threaten human and animal health. Since prion caused disease is very hard to<br/> diagnose, with the application of Raman Spectroscopy, people can dectect the protein transformation at a earlier stage, which is<br/> beneficial for diease control, as well leading to a better medical treatment.<br/>                     

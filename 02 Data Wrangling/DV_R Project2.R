require("jsonlite")
require("RCurl")
require(tidyr)
require(dplyr)
require(ggplot2)

# Change the USER and PASS below to be your UTEid
SLID <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from SLID"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_jso464', PASS='orcl_jso464', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))
#SLID
summary(SLID)
head(SLID)

tbl_df(SLID)
View(SLID)

SLID %>% mutate(WAGES_PERCENT = cume_dist(WAGES)) %>% filter(!is.na(WAGES), !is.na(EDUCATION), WAGES_PERCENT <= .20 | WAGES_PERCENT >= .80) %>% ggplot(aes(x = EDUCATION, y = WAGES)) + geom_point(aes(color=SEX))

SLID %>% select (AGE, EDUCATION, LANGUAGE) %>% filter(!is.na(AGE), !is.na(EDUCATION), LANGUAGE %in% c("English", "French", "Other")) %>% ggplot(aes(x = AGE, y = EDUCATION)) + geom_point(aes(color = LANGUAGE))

SLID %>% group_by(WAGES,LANGUAGE,SEX) %>% filter(AGE >= 25) %>% ggplot(aes(x=AGE, y=WAGES, color=SEX)) + geom_point() + facet_wrap(~LANGUAGE)

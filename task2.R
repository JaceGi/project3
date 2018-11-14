library(tidyverse)

args = commandArgs(trailingOnly = TRUE)

file = args[1]

mydat<-read.csv(file,stringsAsFactors=FALSE)

mydat<-as.tibble(mydat)

mydat<-filter(mydat, !grepl("Collabs",mydat$Collabs))


yo <-mydat %>% group_by(Collabs) %>% count %>% arrange(desc(n))


top10<-yo$Collabs[1:10]

words<-tibble(Institute=top10[1:10],Abstract=rep('A',10))

for(i in 1:10){
  words[i,2]<-mydat %>% filter(Collabs==top10[i]) %>% select(Abstract) %>% unlist(.) %>% paste(.,sep = " ",collapse = " ")
}


write.csv(words,"top10.csv",row.names=FALSE)

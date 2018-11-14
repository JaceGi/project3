library(tidyverse)
#regex


args = commandArgs(trailingOnly = TRUE)

file = args[1]

my_dat<-tibble("Authors"=character(),"Abstract"=character(),"Collabs"=character())
use_dat<-tibble("Collabs"=character(),"Abstract"=character())

curr_abs<-readLines(args[1])
for(j in 1:length(curr_abs)){
  if(substring(curr_abs[j],1,6)=="Author"){
    my_dat[1,1]<-curr_abs[j]
    my_dat[1,2]<-curr_abs[j+1]
  }
  
}


find_collabs<-unlist(strsplit(x = as.character(my_dat[1,1]),split = ","))

collabs<-unique(find_collabs[grep(pattern = "(Institute|University|College|Center|Hospital)", x = find_collabs)])
  
temp_dat<-tibble("Collabs"=character(),"Abstract"=character())
  for(k in 1:length(collabs)){
    temp_dat[k,1]<-collabs[k]
    temp_dat[k,2]<-my_dat[1,2]
}
  
fin_dat<-temp_dat


fin_dat<-filter(fin_dat, !grepl("(University of North Carolina|Chapel Hill|ChapelHill|Lineberger|NorthCarolina|North Carolina)",fin_dat$Collabs))
fin_dat<-fin_dat %>% mutate(Collabs = replace(Collabs, Collabs == " Duke University Medical Center", " Duke University"))
fin_dat<-fin_dat %>% mutate(Collabs = replace(Collabs, Collabs == " Duke Cancer Institute", " Duke University"))
fin_dat<-fin_dat %>% mutate(Collabs = replace(Collabs, Collabs == " Duke University School of Medicine" , " Duke University"))
fin_dat<-fin_dat %>% mutate(Collabs = replace(Collabs, Collabs == 'Duke University', " Duke University"))

fileConn = file("out.csv")
write.csv(fin_dat, file='p_abstract.csv', row.names = FALSE)
close(fileConn)




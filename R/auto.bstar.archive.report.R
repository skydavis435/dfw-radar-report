auto.bstar.archive.report <- function(){
#Summary Reporting for the BSTAR V2 at Dallas Fort Worth
#Served daily
  print("Let's get started")
#Variables
  start.date <- "2014-12-10"
  end.date <- "2017-05-01"
#What are we doing today?
  start.date<-as.Date(start.date,format="%Y-%m-%d")
  end.date<-as.Date(end.date,format="%Y-%m-%d")
  date.seq<-seq.Date(from = start.date,to = end.date,by = "day")

#Load Packages
  library(rmarkdown) 
  library(ggmap)
#Let's not stress Google out
  map<-get_map(location = c(-97.0381,32.8969),zoom = 11,maptype = "satellite",color = "bw")
#Loop through date sequence
  for(i in 1:length(date.seq)){
    #Important Variables
      date<-date.seq[i]
      date.yesterday<-date-1
      filename<-as.character(date.yesterday,format="%Y.%m.%d")
      report.filename<-paste0(filename,"_BSTAR_Report.pdf")
    #Create Today's report  
      try(rmarkdown::render('/home/mayer/BSTAR_Reporting/BSTAR_Archive_Report.Rmd',params = list(rmd.date = date, rmd.map = map),output_file = report.filename))
      gc()
    #Move it to the archive
      if(file.exists(file.path("/home/mayer/BSTAR_Reporting",report.filename))==TRUE){
      file.copy(from = file.path("/home/mayer/BSTAR_Reporting",report.filename),to = file.path("/mnt/box/Airport\ Safety\ Management\ Program/Automated\ Reporting/BSTAR\ V2",report.filename),overwrite = T)
      file.remove(file.path("/home/mayer/BSTAR_Reporting",report.filename))
      } else{print("Moving right along")}
    }
}
#Summary Reporting for the BSTAR V2 at Dallas Fort Worth
#Served daily

#Load Packages
  library(mailR)
  library(rmarkdown) 
#Important Variables
  yesterday.date<-Sys.Date()-1
  yesterday.filename<-as.character(yesterday.date,format="%Y.%m.%d")
  yesterday.body<-as.character(yesterday.date,format="%A %B %d, %Y")
  report.filename<-paste0(yesterday.filename,"_BSTAR_Report.pdf")
  email.recipients<-c(
      "cboyles@dfwairport.com",
      "herricks@illinois.edu",
      "sagth70@gmail.com",
      "ccanadensis@gmail.com",
      "urbanbirdbrain@gmail.com",
      "woodwrth@illinois.edu",
      "dmayer2@illinois.edu",
      "shmajumd@illinois.edu"
      )
  email.subject<-paste("DFW BSTAR V2:",yesterday.filename,"Daily Report")
  email.body<-paste('Attached is a bird activity summary report for',yesterday.body,'at Dallas Fort Worth International Airport. The complete archive of automatic BSTAR V2 Reporting is available at the following link: <a href="https://uofi.box.com/s/h3ca0l8wwm0d7j2s0xz70i2brs6qnsq1">BSTAR V2 Reporting Archive</a>. Additionally, the most recent 30 days of BSTAR video is available for playback at the following link: <a href="https://uofi.box.com/s/rl5qe7w7zsnlgacafd8izzit5x34lfs3">BSTAR V2 Video Archive</a>. <br />
                    <br />
                    <br />
                    If you have questions, comments or suggestions please contact <a href="mailto:dmayer2@illinois.edu">Dave Mayer</a>.<br />
                    ')
#Create Today's report  
  rmarkdown::render('/home/mayer/BSTAR_Reporting/BSTAR_Report.Rmd',output_file = report.filename)
  
#Mail it!
  send.mail(from = "ceat-asm@illinois.edu",
          to = email.recipients,
          subject = email.subject,
          body = email.body,
          html = TRUE,
          smtp = list(host.name = "smtp.gmail.com", port = 465, user.name = "herricks.group@gmail.com", passwd = "piscine", ssl = TRUE),
          authenticate = TRUE,
          send = TRUE,
          attach.files = c(file.path("/home/mayer/BSTAR_Reporting",report.filename))
          )
#Move it to the archive
  file.copy(from = file.path("/home/mayer/BSTAR_Reporting",report.filename),to = file.path("/mnt/box/Airport\ Safety\ Management\ Program/Automated\ Reporting/BSTAR\ V2",report.filename),overwrite = T)
  file.remove(file.path("/home/mayer/BSTAR_Reporting",report.filename))
  
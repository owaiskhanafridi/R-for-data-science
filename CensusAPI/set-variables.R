# Packages & Dependencies Section ---------------------------------
library(censusapi)

Sys.setenv(CENSUS_KEY="129b110dadba1874819597fbdac04109a86f34eb") 
census_api_key(Sys.getenv("CENSUS_KEY"))

# Function Definition Section ---------------------------------

#Get & Set ACS Variables 
set_acs_vars = function()
{
  acs1or5 <<- readline(prompt = "Please enter 1 for 1-year ACS data or 5 for 5-years ACS: ")
  input_year <<- as.integer(readline(prompt = "Please enter the year of the required data: "))  
  acs_survey <<- paste0("acs", acs1or5)
  
  #Getting data for the state of Michigan
  state_list <<- c(26)
  
  #get table list as an input
  table_input <- readline(prompt="Please enter table codes (comma separated): ")
  table_list <<- unlist(strsplit(gsub(" ", "", table_input), split=","))
  
  # source id for 1-year or 5-year ACS data (86 and 88 respectively)
  sid <<- 88
  
  #path where the output files are generated
  #out_path <<- paste0("~/CensusAPI_Data/", output_folder_name)
  
}




# Function Execution Section ----------------------------------------

#uncomment this code to debug this method
#debug(set_acs_vars)

set_acs_vars()





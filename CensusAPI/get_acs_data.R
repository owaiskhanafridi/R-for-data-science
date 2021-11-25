#Sequence of execution: set-variables.R > get_acs_data.R

# I can write a function that accomplishes a common analysis task.

# Function Definition Section-----------------------

get_geo_data <- function(geo, file_name, state_list = NULL)
{
  data <- data.frame(matrix(ncol = 0, nrow = 0))
  
  if(!is.null(state_list))
  {
    for(table in table_list)
    {
      temp <- map_dfr(state_list, 
                      ~ get_acs(geography = geo,
                                table = table,
                                year = input_year,
                                survey = acs_survey,
                                state = .
                      )
      )
      data <- bind_rows(data, temp) 
    }
  }
  else 
  {
    for(table in table_list)
    {
      temp <- get_acs(geography = geo,
                      table = table,
                      year = input_year,
                      survey = acs_survey
      )
      data <- bind_rows(data, temp) 
    }
  }
  
  
  #drops NA values (data cleaning)
  data <- data[complete.cases(data), ]
  
  write_to_file(data, file_name)
}

#Writes data to a file
write_to_file <- function(data, file_name)
{
  write.table(data, 
              file = paste0(file_name, ".csv"), 
              append = F, 
              sep=',', 
              row.names=F
  )
}

# I can import data from a variety of sources.

# downloads all the data from Census API
download_data <- function()
{
  start_time = Sys.time()
  
  get_geo_data("state", "state")
  get_geo_data("county", "counties", state_list)
  get_geo_data("county subdivision", "cousub", state_list)
  get_geo_data("place", "places", state_list)
  get_geo_data("tract", "tracts", state_list)
  
  end_time = Sys.time()
  execution_time = end_time - start_time
  print(execution_time)
  
  write_to_file(execution_time, "execution_time")
}

# Function Execution Section-------------------

#uncomment this code to debug this method
#debug(download_data)

#removed all variables from session before making the download
rm(list=ls())

download_data()

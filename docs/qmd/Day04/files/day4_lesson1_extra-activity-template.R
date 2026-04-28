# EXTRA ACTIVITY: DATA CLEANING ################################################

# TEMPLATE SCRIPT
# *how to use this template*
# work through the script line-by-line, wherever you see 3 underscores ('___'), 
# fill in the code snippet to make it run!

# Description ------------------------------------------------------------------

# This script uploads the raw squirrel data and performs the following cleaning
# steps: 
## Renames variables to consistent names with lower caps, no spaces, and no units of measurements
## Checks for duplicates
## Reorder columns
## Fix typos and inconcistsencies in the height column
## Recodes location variable to specify only “groundplane”, “aboveground”, or “both”.
## Saves the cleaned dataset with an informative name different from the raw dataset name

# Organize working environment -------------------------------------------------

# Set working directory
# NOTE: you will have to update this to your working directory, where you saved 
# the squirrel dataset
setwd("a path to your directory")

# Load the tidyverse package
'___'(tidyverse)

# Upload the dataset
squirrel_data <- read_csv('___')

# Check that it was correctly uploaded
squirrel_data

# Rename variables -------------------------------------------------------------
## Rename variables to consistent names with lower caps and no spaces. Also remove 
## references to units of measurements from column names (this should be described
## in the dataset documentation)
squirrel_data <- squirrel_data |>
  rename(
    area_name = "Area Name",
    area_id = '___',
    park_name = '___',
    park_id = '___',
    squirrel_id = '___',
    '___' = "Primary Fur Color",
    '___' = "Highlights in Fur Color",
    '___' ="Color Notes",
    '___' = "Location",
    height_aboveground = '___',
    specific_location = '___',
    activities = '___',
    '___' = "Interactions with Humans",
    '___' = "Other Notes or Observations",
    '___' = "Squirrel Latitude (DD.DDDDDD)",
    '___' = "Squirrel Longitude (-DD.DDDDDD)"
  )

# Check column names
names('___')

# Deal with duplicates ---------------------------------------------------------

# Number of rows in the dataset
'___'(squirrel_data)

# Check number of distinct squirrels
squirrel_data |>
  '___'(squirrel_id)

# No duplicates, nothing to do

## Reorder columns ----

# Move latitude and longitude to after the squirrel ID colum
squirrel_data <- squirrel_data |>
  '___'(latitidude, longitude, .after = '___')

# Fix typos and inconsistencies in height variable -----------------------------

# Check all possibilities
squirrel_data |> 
  distinct('___') |> 
  print(n = '___')

# Recode values. The decision of which values to choose for recoded values,
# or keep them as unknown, is a subjective decision, and you woul need to document
# this decision in the documentation (e.g., all values smaller than 1 were assigned the value 0.5)
# Because the variable is currenly a character vector (we will change it in the next step), the replaced values also have to be character or NA
squirrel_data <- squirrel_data |>
  mutate(
    height_aboveground = replace_values(
      '___',
      "< 1" ~ '___', # a standard way to deal with smaller than values
      "6\x89\xdb\xd218" ~ '___', # Adding as NA as there is no was for us to know. If you had collected the data, you could check your original datasheet.
      "20\x89\xdb\xd240" ~ '___', # same
      "2\x89\xdb\xd26" ~ '___', # same
      "20\x89\xdb\xd230" ~ '___', # same
      "10\x89\xdb\xd212" ~ '___', # same
      "4...3...2...1" ~ '___' # the average of the 4 numbers
    )
  )

# Check if it worked
squirrel_data |> 
  distinct('___') |> 
  print(n = Inf)

# Recode location variable -----------------------------------------------------
## There is no need to mention Specific Location in this variable value when a column
## for specific location exists and details their location
## All entries that say solely “Specific Location” can be assigned to “aboveground” 
## as they describe squirrels seen on a bench, tree, handrail or fence, as detailed in 
## the specific location variable.

# Check all possible values
squirrel_data |>
  '___'(location)

# Recode location
squirrel_data <- squirrel_data |>
  mutate(
    location = '___'(
      '___',
      c('___', '___') ~ "groundplane",
      c('___', '___', "Specific Location") ~ '___',
      c("Ground Plane, Above Ground") ~ '___'
    )
  )

# Check if it worked
squirrel_data |>
  distinct('___')

# Saves the cleaned dataset ----------------------------------------------------

'___'(squirrel_data, "squirrel-data-cleaned.csv")

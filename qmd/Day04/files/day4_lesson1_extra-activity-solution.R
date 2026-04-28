# EXTRA ACTIVITY: DATA CLEANING ################################################

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
library(tidyverse)

# Upload the dataset
squirrel_data <- read_csv("squirrel-data.csv")

# Check that it was correctly uploaded
squirrel_data

# Rename variables -------------------------------------------------------------
## Rename variables to consistent names with lower caps and no spaces. Also remove 
## references to units of measurements from column names (this should be described
## in the dataset documentation)
squirrel_data <- squirrel_data |>
  rename(
    area_name = "Area Name",
    area_id = "Area ID",
    park_name = "Park Name",
    park_id = "Park ID",
    squirrel_id = "Squirrel ID",
    primary_fur_colour = "Primary Fur Color",
    highlights_fur_colour = "Highlights in Fur Color",
    colour_notes ="Color Notes",
    location = "Location",
    height_aboveground = "Above Ground (Height in Feet)",
    specific_location = "Specific Location",
    activities = "Activities",
    interactions = "Interactions with Humans",
    other_notes = "Other Notes or Observations",
    latitidude = "Squirrel Latitude (DD.DDDDDD)",
    longitude = "Squirrel Longitude (-DD.DDDDDD)"
  )

# Check column names
names(squirrel_data)

# Deal with duplicates ---------------------------------------------------------

# Number of rows in the dataset
nrow(squirrel_data)

# Check number of distinct squirrels
squirrel_data |>
  distinct(squirrel_id)

# No duplicates, nothing to do

# Reorder columns --------------------------------------------------------------

# Move latitude and longitude to after the squirrel ID column
squirrel_data <- squirrel_data |>
  relocate(latitidude, longitude, .after = squirrel_id)

# Fix typos and inconsistencies in height variable -----------------------------

# Check all possibilities
squirrel_data |> 
  distinct(height_aboveground) |> 
  print(n = Inf)

# Recode values. The decision of which values to choose for recoded values,
# or keep them as unknown, is a subjective decision, and you would need to document
# this decision in the documentation (e.g., "all values smaller than 1 were assigned the value 0.5")
# Because the variable is currently a character vector, the replaced values also have to be character or NA
squirrel_data <- squirrel_data |>
  mutate(
    height_aboveground = replace_values(
      height_aboveground,
      "< 1" ~ "0.5", # a standard way to deal with smaller than values
      "6\x89\xdb\xd218" ~ NA, # Adding as NA as there is no was for us to know. If you had collected the data, you could check your original datasheet.
      "20\x89\xdb\xd240" ~ NA, # same
      "2\x89\xdb\xd26" ~ NA, # same
      "20\x89\xdb\xd230" ~ NA, # same
      "10\x89\xdb\xd212" ~ NA, # same
      "4...3...2...1" ~ "2.5" # the average of the 4 numbers
    )
  )

# Check if it worked
squirrel_data |> 
  distinct(height_aboveground) |> 
  print(n = Inf)

# Recode location variable ----------------------------------------------------
## There is no need to mention Specific Location in this variable value when a column
## for specific location exists and details their location
## All entries that say solely “Specific Location” can be assigned to “aboveground” 
## as they describe squirrels seen on a bench, tree, handrail or fence, as detailed in 
## the specific location variable.

# Check all possible values
squirrel_data |>
  distinct(location)

# Recode location
squirrel_data <- squirrel_data |>
  mutate(
    location = replace_values(
      location,
      c("Ground Plane", "Ground Plane, Specific Location") ~ "groundplane",
      c("Above Ground", "Above Ground, Specific Location", "Specific Location") ~ "aboveground",
      c("Ground Plane, Above Ground") ~ "both"
    )
  )

# Check if it worked
squirrel_data |>
  distinct(location)

# Saves the cleaned dataset ----------------------------------------------------

write_csv(squirrel_data, "squirrel-data-cleaned.csv")

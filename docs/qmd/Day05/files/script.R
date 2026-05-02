
# 1) ---------------------------------------------------------------

survey <- read_csv("data/raw/survey_faculty-data.csv")

# 2) ---------------------------------------------------------------------

survey_rename <- survey |> 
  
  rename(timestamp = "Timestamp",
         name = "Name",
         email = "Email",
         age = "Age",
         province = "Province",
         gender = "Gender",
         academic_rank = "What is your academic rank?"
         department = "What is your primary department?",
         personal_use = "On average, how many hours per day do you personally spend on social media?",
         platforms = "Which social media platforms do you use?",
         student_use = "On average, how many hours per day do you believe students spend on social media?",
         student_performance = "To what extent do you believe social media affects student academic performance?",
         student_connected = "Please indicate how much you agree or disagree with the following statements about social media and student mental health: [Social media helps students feel connected to others.]",
         student_stressed = "Please indicate how much you agree or disagree with the following statements about social media and student mental health: [Social media makes students feel anxious or stressed.]",
         student_distract = "Please indicate how much you agree or disagree with the following statements about social media and student mental health: [Social media distracts students from academic work.]",
         student_lonely = "Please indicate how much you agree or disagree with the following statements about social media and student mental health: [Social media improves my mood when I feel lonely.]",
         student_disengagement = "Have you observed social media use impacting student engagement in your classes?")

# 3) ---------------------------------------------

survey_unique <- survey_rename |> 
  
  distinct())

# 4) ----------------------------------------------------------------------

survey_anon <- survey_unique |> 
  
  mutate(id = row_number()) |> 
  
  relocate(id) |> 
  
  select(!name,
           email)

# 5) ------------------------------------------------------

survey_reorder <- survey_aon |> 
  
  relocate(gender,
           .after = age) |> 
  
  relocate(timestamp)
  
# 6) --------------------------------------------------

survey_sep <- survey_reorder |> 
  
  separate_wider_delim(cols = platforms,
                       delim = ","",
                       names_sep = "_",
                       too_few = "align_start")

# 6) --------------------------------------------------------

survey_na <- survey_sep |> 
  
  mutate(student_use = replace_na(student_use, 0)) |> 
  
  drop_na(prvince)

# 7) ---------------------------------------------------------------------

survey_na |> distinct(province) |> arrange(province) |> print(n = Inf)
survey_na |> distinct(department) |> arrange(department) |> print(n = Inf)

survey_replace <- survey_na  |> 
  
  mutate(province = case_when(province == "AB" ~ "Alberta",
                              province == "B.C." ~ "British Columbia",
                              province == "BC" ~ "British Columbia",
                              province == "MB" ~ "Manitoba",
                              province == "NB" ~ "New Brunswick",
                              province == "NS" ~ "Nova Scotia",
                              province = "ON" ~ "Ontario",
                              province == "QC" ~ "Quebec",
                              province == "Québec" ~ "Quebec",
                              province == "SK" ~ "Saskatchewan",
                              TRUE ~ province),
         
         department = case_when(department == "Bio" ~ "Biology",
                                department == "biology" ~ "Biology",
                                department == "business" ~ "Business",
                                department == "CS" ~ "Computer Science",
                                department == "Comp Sci" ~ "Computer Science",
                                department == "computer science" ~ "Computer Science",
                                department == "Educ." ~ "Education",
                                department == "education" ~ "Education",
                                department == "english" ~ "English",
                                department == "Hist." ~ "History",
                                department == "history" ~ "History",
                                department == "nursing" ~ "Nursing",
                                department == "physics" ~ "Physics",
                                department == "Psych" ~ "Psycology",
                                department == "psychology" ~ "Psychology",
                                department == "Soc" ~ "Sociology",
                                department == "sociology" ~ "Sociology",
                                TRUE ~ department))

survey_replace |> distinct(province) |> arrange(province) |> print(n = Inf)
survey_replace |> distinct(department) |> arrange(department) |> print(n = Inf)

# 8) ----------------------------------------------------------------------

survey_recode <- survey_replace |> 
  
  mutate(faculty = case_when(department == "Biology" |
                               department == "Computer Science" |
                               department == "Physics" ~ "Science",
                             department == "Commerce" |
                               department == "Business" ~ "Business",
                             department == "Education" ~ "Education",
                             department == "English" |
                               department == "History" ~ "Humanities",
                             department == "Nursing" ~ "Health",
                             department == "Psychology" 
                               department == "Sociology" ~ "Social Sciences")) |> 
  
  relocate(faculty,
           .after = department

# 9) ---------------------------------------------------------

survey_long <- survey_recode |> 
  
  pivot_longer(cols = c(student_performance,
                        student_connected,
                        student_stressed,
                        student_distract,
                        student_lonely,
                        student_disengagement)
               names_to = "social_media_affect",
               values_to = "faculty_response")

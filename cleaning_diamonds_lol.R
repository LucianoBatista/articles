library(tidyverse)
library(recipes)
library(DataExplorer)

lol_data <- read_csv("data/final_dataset.csv")

lol_diamond_tbl <- lol_data %>% 
    filter(tier == "DIAMOND") %>% 
    select(where(is.numeric)) %>% 
    select(-leaguePoints, -wins, -losses, -participantId, -profileIcon,-dominionVictoryScore, 
           -vilemawKills, -playerScore0, -playerScore9, -totalScoreRank, -totalPlayerScore, -objectivePlayerScore,
           -combatPlayerScore, -sightWardsBoughtInGame, -unrealKills)

# removing skewness and variability (better to investigate for correlations)
# we are considering totalDemageDealt as our target
recipe_spec <- recipe(totalDamageDealt ~ .,
                      data = lol_diamond_tbl) %>% 
    step_YeoJohnson(all_numeric()) %>% 
    step_normalize(all_numeric())

lol_diamond_numeric <- recipe_spec %>% 
    prep() %>% 
    juice()

# investigating the missing values
lol_diamond_numeric %>% 
    DataExplorer::plot_missing()

# imputing the missing values
lol_numeric_w_missing_tbl <- lol_diamond_numeric %>% 
    replace_na(replace = list(damageTakenDiffPerMinDeltas_1020 = 0, csDiffPerMinDeltas_1020 = 0, damageTakenDiffPerMinDeltas_010 = 0, csDiffPerMinDeltas_010 = 0, perkSubStyle = 0))

# investigating the missing values
lol_numeric_w_missing_tbl %>% 
    DataExplorer::plot_missing()

# dropping some variables that are not interesting
lol_diamond_numeric_final_tbl <- lol_numeric_w_missing_tbl %>% 
    select(-contains("perk"),
           -starts_with("item"),
           -starts_with("playerScore")) %>% 
    select(totalDamageDealt, everything())

write_csv(lol_diamond_numeric_final_tbl, "data/lol_diamond_numeric_final.csv")

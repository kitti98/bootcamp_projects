# homework 02
# Pao Ying Chub -> Rock, Paper, Scissors
# users play unlimited times

pao_ying_chub <- function () {
  # getting started
  print("Welcome to Pao Ying Chub...")
  print("Choose what you wanna SHOOT!")
  print("Choose a number -> 1: Rock, 2: Paper, 3: Scissors, 4: Score?, 5: Gotta go!")
  print("Let's play!!!")
  
  # empty objects
  chub <- "Let's play"
  count_win  <- 0
  count_lose <- 0
  count_draw <- 0
  
  # loop
  while (chub != "Gotta go!") {
    print("Rock, Paper, Scissors, Shoot!: ")
    
    # bot's turn
    pao <- sample( c(1,2,3), size = 1 )
    ying <- factor(pao,
                   levels = c(1, 2, 3),
                   labels = c("Rock", "Paper", "Scissors"))
    
    # player's turn
    chub <- readLines("stdin", n=1)
    if (chub == "1") {
      chub <- "Rock"
    } else if (chub == "2") {
      chub <- "Paper"
    } else if (chub == "3") {
      chub <- "Scissors"
    } else if (chub == "4") {
      chub <- "Score?"
    } else if (chub == "5") {
      chub <- "Gotta go!"
    }
    
    # scoring
    if (ying == "Rock" & chub == "Paper" |
        ying == "Paper" & chub == "Scissors" |
        ying == "Scissors" & chub == "Rock") {
      count_win  <- count_win + 1
    } else if (ying == chub) {
      count_draw <- count_draw + 1
    } else if (ying == "Paper" & chub == "Rock" |
               ying == "Scissors" & chub == "Paper" |
               ying == "Rock" & chub == "Scissors") {
      count_lose <- count_lose + 1
    }
    
    # display
    if (chub == "Gotta go!") {
      print("Gotta go? Kay Bye!")
      print(paste("Your score -> Win:", count_win, 
                  "Lose:", count_lose,
                  "Draw:", count_draw))
      break
    } else if (chub %in% c("Rock", "Paper", "Scissors")) {
      print(paste("You:", chub, "VS Bot:", ying))
    } else if (chub == "Score?") {
      print(paste("Your score -> Win:", count_win, 
                  "Lose:", count_lose,
                  "Draw:", count_draw))
    } else {
      print("Wrong number!!! Please try again...")
    }
  }
}

pao_ying_chub()

#Variable
h <- "Hammer"
s <- "Scissors"
p <- "Paper"
bot <- c(h,s,p)
win <- 0
lose <- 0
draw <- 0
cancel <- 0

#Function
check <- function(){
  print(" 1.Hammer")
  print(" 2.Scissors")
  print(" 3.Paper")
  print(paste(hero,"status -","Win",win,"Lose",lose,"Draw",draw,"---quit press [q]"))
}

#Start
print("Welcome to game PAO-YING-CHOOP.")
print("How can I call your name?")
hero <- readLines("stdin",n=1)
print(paste("Greet to see you",hero))
print("")
print("Start game PAO-YING-CHOOP !!!!!!!!!!")
print(" 1.Hammer")
print(" 2.Scissors")
print(" 3.Paper")

while (cancel == 0) {
  game <- readLines("stdin",n=1)
  bot_g <- sample(bot,1)
  
  show <- function(bot_g){                 #bot show
    if(bot_g == h) {
    print("Bot : Hammer!!!!")
    print("And")
    }
    else if(bot_g == s){
    print("Bot : Scissors!!!!")
    print("And")
    }
    else if(bot_g == p){
    print("Bot : Paper!!!!")
    print("And")}
      }
    
  showh <- function(game){                 #hero show
    if(game == 1) {
    print(paste(hero,": Hammer!!!!"))}
    
    else if(game == 2){
    print(paste(hero,": Scissors!!!!"))}
    
    else if(game == 3){
    print(paste(hero,": Paper!!!!"))}
      }
  
  if       ((game == 1 & bot_g == h) ||    #loop game
            (game == 2 & bot_g == s) ||
            (game == 3 & bot_g == p))
  { show(bot_g)
   showh(game)
   print("Draw -_-")
   print("----------")
   draw <- draw +1
   check()
  }else if  ((game == 1 & bot_g == s) ||
            (game == 2 & bot_g == p) ||
            (game == 3 & bot_g == h))
  { show(bot_g)
    showh(game)
    print("Win !!!!")
    print("----------")
    win <- win + 1
    check()
  }else if  ((game == 1 & bot_g == p) ||
            (game == 2 & bot_g == h) ||
            (game == 3 & bot_g == s))
  { show(bot_g)
    showh(game)
    print("Lose T_T")
    print("----------")
    lose <- lose + 1
    check()
  }else if (game == "q") {
    print(paste("Good game",hero,",Thankyou for playing."))
    print(paste("Total game =",sum(win,lose,draw),"games."))
    print("----------------------")
    print(paste("Win :",win,"games."))
    print(paste("Lose :",lose,"games."))
    print(paste("Draw :",draw,"games."))
    print("----------------------")
    print("Bye bye, will see you again.")
    cancel <- cancel + 1
    }
}

#PoptatoPizza

#Variable
menu_1 <- c("Bar-B-Q","Seafood","Hawaian","Vegie")
menu_1p <- c(50,80,50,30)
size_1 <- c("Medium","Large")
size_1p <- c(150,200)
menu_2 <- c("Fried chicken","Sandwich","Ice-cream")
menu_2p <- c(100,60,40)
menu_3 <- c("Lemon juice","Soda","Water")
menu_3p <- c("30,15,10")
pizza_p <- 0
ap_p <- 0
skip <- 0

pizza_pf <- function(){                                #function4
            print("Pizza menu")
              print(" 1. Bar-B-Q (50 baht)")
              print(" 2. Seafood (80 baht)")
              print(" 3. Hawaian (50 baht)")
              print(" 4. Vegie (30 baht)")
              print(" 5. I already not want to eat pizza")}

ap_pf <- function(){                                   #function5
            print("Appetizer menu")
              print(" 1. Fried chicken (100 baht)")
              print(" 2. Sandwich (60 baht)")
              print(" 3. Ice-cream (40 baht)")
}

#Show Pizza
print("ooooooo   ooooooo   ooooooo   ooooooo   ooooooo   ooooooo   ooooooo   ")
print("oo   oo   oo   oo   oo   oo     ooo     oo   oo     ooo     oo   oo   ")
print("ooooooo   oo   oo   ooooooo     ooo     ooooooo     ooo     oo   oo   ")
print("oo        oo   oo   oo          ooo     oo   oo     ooo     oo   oo   ")
print("oo        ooooooo   oo          ooo     oo   oo     ooo     ooooooo   ")
print("")
print("ooooooo   oo   ooooooo   ooooooo   ooooooo")
print("oo   oo   oo        oo        oo   oo   oo")
print("ooooooo   oo      oo        oo     ooooooo")
print("oo        oo    oo        oo       oo   oo")
print("oo        oo   ooooooo   ooooooo   oo   oo")
print("")

#Welcome
print("Welcome to Poptato Pizza !!")
print("What should I call your name?")
cust_name <- readLines("stdin",n=1)                   #name
print(paste("Hi!",cust_name," Great to see you."))

#Start
while (skip == 0 ){
print("What Pizza size do you want?") 
    print(" 1. Medium 10 pieces (150 baht)")
    print(" 2. Large 12 pieces (200 baht)")
        size <- readLines("stdin",n=1)               #pizza size

    if(size == 1){
        pizza_size <- size_1[[1]]
        pizza_p <- pizza_p + size_1p[[1]]
        print(paste("Your pizza",pizza_size,"size, What topping do you want ?"))
      skip <- skip + 1
    }else if (size ==2){
        pizza_size <- size_1[[2]]
        pizza_p <- pizza_p + size_1p[[2]]
        print(paste("Your pizza",pizza_size,"size, What topping do you want ?"))
      skip <- skip + 1
    }else{
        print("I don't have another size")
        pizza_size <- "empty"
        pizza_menu <- "empty"        
        skip <- skip + 2
    }}


while (skip == 1){
      pizza_pf()                                            
      num <- readLines("stdin",n=1)                 #pizza order
            if (num == 1){
              pizza_menu <- menu_1[[1]]
              pizza_p <- pizza_p + menu_1p[[1]]
              skip <- skip + 1
            } else if (num == 2) {
              pizza_menu <- menu_1[[2]]
              pizza_p <- pizza_p + menu_1p[[2]]
              skip <- skip + 1
            } else if (num == 3) {
              pizza_menu <- menu_1[[3]]
              pizza_p <- pizza_p + menu_1p[[3]]
              skip <- skip + 1
            } else if (num == 4) {
              pizza_menu <- menu_1[[4]]
              pizza_p <- pizza_p + menu_1p[[4]]
              skip <- skip + 1
            }else if (num == 5){
                  pizza_size <- "empty"
                  pizza_menu <- "empty"
                  pizza_p <- 0
                skip <- skip + 1
            }else {
                  pizza_size <- "empty"
                  pizza_menu <- "empty"
                  pizza_p <- 0
                skip <- skip + 1
            }

print(paste("Your pizza is",pizza_menu,"with",pizza_size,"size,Total price",pizza_p,"baht"))
}

print("Do you want any Appetizer? (yes,no)") 
check2 <- readLines("stdin",n=1)                      #appetizer check

  if (check2 == "yes"){
ap_pf()                                        
num2 <- readLines("stdin",n=1)                        #appetizer order
    
      if (num2 == 1){
        ap_menu <- menu_2[[1]]
        ap_p <- ap_p + menu_2p[[1]]
      } else if (num2 == 2){
        ap_menu <- menu_2[[2]]
        ap_p <- ap_p + menu_2p[[2]]
      } else if (num2 == 3){
        ap_menu <- menu_2[[3]]
        ap_p <- ap_p + menu_2p[[3]]
      } else {
        ap_menu <- "empty"
        ap_p <- ap_p + 0
      }
}else {
    ap_menu <- "empty"
    ap_p <- ap_p + 0
}
print(paste("Your pizza is",pizza_menu,"with",pizza_size,"size,Total price",pizza_p,"baht"))
print(paste("Your appetizer is",ap_menu,"Total price",ap_p,"baht"))
total <- (ap_p + pizza_p)
check_p <- 0

while (check_p == 0){
print(paste("Khun",cust_name,", total price is" ,total, "baht. !!!!"))
print("Please pay your money. (imput number of total cost)")
money <- readLines("stdin",n=1)                      #pay money
if (money == total){
  print(paste("Thankyou Khun",cust_name))
  check_p <- check_p + 1
  }
}

y <- 0
while (y == 0){
print("Will you eat here or back home (here,home)?")
herehome <- readLines("stdin",n=1)                   #here & home
if (herehome == "here"){
    x <- 0
    while (x == 0) {
  print("What drink do you want (Exclude money)?")
    print( " 1. Water")
    print( " 2. Water with ice.")
      water <- readLines("stdin",n=1)
      if (water == 1){
        print("Ok, water.")
        x <- x+1
        y <- y+1
      }else if (water == 2){
        print("Ok, water with ice.")
        x <- x+1
        y <- y+1
      }
    }
  print("Please wait, we will serve you on your table.")
}else if (herehome == "home"){
  print("Please wait, we will pack your meal a minute.")
  print("This meal from your order.")
  y <- y+1
    }
}

print("Thanks !!! See you !!!")

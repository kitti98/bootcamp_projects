# homework 01
# chatbot (rule-based)
# ordering pizza


# menu
df_pizza <- data.frame(id = c("1", "2", "3", "4"),
                       pizza = c("Supreme Pizza", 
                                 "Multi-Meat Pizza",
                                 "Pepperoni Pizza", 
                                 "Pineapple Jalapeño Pizza"))

df_pizza_price <- data.frame(size = c("M", "L", "XL"),
                             Supreme = c(10.50, 12.99, 16.00),
                             'Multi Meat' = c(10.95, 13.99, 17.50),
                             Pepperoni = c(9.99, 11.99, 14.99),
                             'Pineapple Jalapeño' = c(10.35, 12.99, 15.99))

df_appetizers <- data.frame(id = c("1", "2", "3"),
                            appetizers = c("Cheese Sticks", 
                                           "Chicken Wings", 
                                           "Onion Rings"),
                            price = c(4.75, 12.99, 3.00))

# object
description <- NULL
amount <- NULL
price <- NULL

# function
pizza <- function (pizza_id) {
  df_pizza$pizza[as.numeric(pizza_id)]
}

size_and_price <- function (pizza_size) {
  if (pizza_size == "M") {
    price <- df_pizza_price[[as.numeric(pizza_id) + 1]][1]
  } else if (pizza_size == "L") {
    price <- df_pizza_price[[as.numeric(pizza_id) + 1]][2]
  } else if (pizza_size == "XL") {
    price <- df_pizza_price[[as.numeric(pizza_id) + 1]][3]
  }
  price
}

pizza_order_amount <- function(amount) {
  as.integer(amount)
}

appetizer <- function (app_id) {
  df_appetizers$appetizers[as.numeric(app_id)]
}

app_order_amount <- function(amount) {
  as.integer(amount)
}

appetizer_price <- function (app_id) {
  price <- df_appetizers$price[as.numeric(app_id)]
}


# -------------------------------------------------------
print("Welcom to Surfer Boy Pizza!")
print("Hello There!")

# greeting
print("What's your name?: ")
user_name <- readLines("stdin", n=1)
print(paste("Hi", user_name, ", My dude!"))

con_trans <- "Y"

# continue transaction
while (con_trans == "Y") {
  print("How can I help you my dude?")
  print("1. Order Pizzas")
  print("2. Order Appetizers")
  print("3. Check the Order")
  
  wanna_do <- readLines("stdin", n=1)
  if (as.numeric(wanna_do) %in% 1:3) {
    # Order Pizzas
    if (wanna_do == "1") {
      # what pizza?
      print("What pizza would you like to order?")
      print(df_pizza[ , 1:2])
      print("Select pizza id: ")
      pizza_id <- readLines("stdin", n=1)
      if ((as.numeric(pizza_id) %in% 1:4)) {
        description <- append(description, pizza(pizza_id))
        # what pizza size & price?
        print(df_pizza_price[ , c(1, as.numeric(pizza_id) + 1)])
        print("What size? M/L/XL")
        pizza_size <- readLines("stdin", n=1)
        print("How many pizzas would you like? Enter a number: ")
        pizza_amount <- readLines("stdin", n=1)
        amount <- append(amount, pizza_order_amount(pizza_amount))
        price <- append(price, size_and_price(pizza_size) *    pizza_order_amount(pizza_amount))
      } else {
        print("Wrong input!!! Please try again...")
      }
    } else if (wanna_do == "2") {
      # Order Appetizers
      print("What appetizers would you like to order?")
      print(df_appetizers)
      print("Select appetizer id: ")
      app_id <- readLines("stdin", n=1)
      if (as.numeric(app_id) %in% 1:3) {
        description <- append(description, appetizer(app_id))
        
        print("How many appetizers would you like? Enter a number: ")
        app_amount <- readLines("stdin", n=1)
        amount <- append(amount, app_order_amount(app_amount))
        price <- append(price, app_order_amount(app_amount)*
                          appetizer_price(app_id))
      } else {
        print("Wrong input!!! Please try again...")
      }
    } else if (wanna_do == "3") {
      # Check the Order
      cust_order_list <- list(Items = description,
                              Amount = amount,
                              Price = price)
      cust_order_df <- data.frame(cust_order_list)
      if (is.null(cust_order_list[[1]]) == TRUE ) {
        print("Your order is empty...")
        print("Order something my dude!")
      } else {
        print(cust_order_df)
      }
    }
    print("Would you like to order more? Y/N")
    con_trans <- readLines("stdin", n=1)
  } else {
    print("Wrong input!!! Please try again...")
  }
}

# order summary
cust_order_list <- list(Items = description,
                        Amount = amount,
                        Price = price)
cust_order_df <- data.frame(cust_order_list)

print("------------- Order Summary -------------")
print(cust_order_df)
total <- sum(cust_order_df$Price)
print("-----------------------------------------")
print(paste("Total:", total, "$"))
print("-----------------------------------------")
print("Enjoy your meal... Thank my dude")
print("-----------------------------------------")

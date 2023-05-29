#!/bin/bash
PSQL="psql -X -U freecodecamp -d number_guess -tAc"

#create function for the game
PLAY_GAME() {
  #generate secret number
  SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))

  #init guess counter
  GUESS_COUNTER=0
  
  #create while loop to check guess and echo correct string. read new guess
  while [[ $SECRET_NUMBER_GUESS != $SECRET_NUMBER ]]
  do
    if [[ $GUESS_COUNTER == 0 ]]
      then
      
      #prompt user to make first guess
      echo -e "\nGuess the secret number between 1 and 1000:"

    else

      if [[ $SECRET_NUMBER_GUESS -gt $SECRET_NUMBER ]]
        then
        echo "It's lower than that, guess again:"
      else
        echo "It's higher than that, guess again:"
      fi

    fi

    read SECRET_NUMBER_GUESS

    #while guess is not an integer, then guess again
    while [[ ! $SECRET_NUMBER_GUESS =~ ^[0-9]{1,4}$ ]]
    do
      echo -e "\nThat is not an integer, guess again:"
      read SECRET_NUMBER_GUESS
    done

    #increment guess counter
    ((GUESS_COUNTER++))

  done

  #increment games played
  INSERT_PLAYED=$($PSQL "UPDATE game_data SET games_played=($2+1) WHERE username_id=$1")

  #check if this was best game, if it was then insert it into game data
  if [[ $GUESS_COUNTER < $3 || $3 == 0 ]]
    then
    INSERT_BEST=$($PSQL "UPDATE game_data SET best_game=$GUESS_COUNTER WHERE username_id=$1")
  fi
  
  #guessed correct string
  echo "You guessed it in $GUESS_COUNTER tries. The secret number was $SECRET_NUMBER. Nice job!"

}

#game banner
echo -e "\n~~~~ NuMbEr GuEsSiNg GaMe ~~~~\n"

#prompt for username
echo -e "\nEnter your username:"
read USERNAME

#check if username matches my requirements, if it doesn't echo reqs and exit
if [[ ! $USERNAME =~ ^[a-zA-Z0-9_.-]{1,22}$ ]]
  then
  echo -e "\nYou entered a username that does not meet the username criteria."
  echo -e "\nUsernames must be 1-22 characters and can only include numbers, letters, underscores, periods, and/or hyphens."
  echo -e "\nPlease rerun the script and enter a valid username.\n"
  exit
fi

#check if username exists
USERNAME_ID=$($PSQL "SELECT username_id FROM usernames WHERE username='$USERNAME'")

#if the username does not exist then try to add it and play. if the username does exist then welcome back and play
if [[ -z $USERNAME_ID ]]
  then

  #if username does not exist then insert username into table
  INSERT_USERNAME=$($PSQL "INSERT INTO usernames(username) VALUES('$USERNAME')")
  
  #if the insert worked, echo welcome string and call function to play. if the insert failed, echo fail string
  if [[ $INSERT_USERNAME == "INSERT 0 1" ]]
    then
    USERNAME_ID=$($PSQL "SELECT username_id FROM usernames WHERE username='$USERNAME'")
    INSERT_GAME_DATA=$($PSQL "INSERT INTO game_data(username_id) VALUES($USERNAME_ID)")
    #insert worked, welcome string then play
    echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
    PLAY_GAME $USERNAME_ID 0 0

  else

    #insert failed, fail string
    echo -e "\nPlease rerun the script and enter a valid username."

  fi

else

  #username already exists, get data and output welcome back string then play
  GAME_DATA=$($PSQL "SELECT games_played,best_game FROM game_data WHERE username_id=$USERNAME_ID")

  IFS="|" read GAMES_PLAYED BEST_GAME <<< $GAME_DATA
  
  echo -e "\nWelcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  
  PLAY_GAME $USERNAME_ID $GAMES_PLAYED $BEST_GAME

fi
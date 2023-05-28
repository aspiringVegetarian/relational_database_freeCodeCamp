#!/bin/bash
PSQL="psql -X -U freecodecamp -d periodic_table -At -c"

OUTPUT_STRING(){
# get relevant info for the output string
ELEMENT_DATA=$($PSQL "SELECT name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1")
echo $ELEMENT_DATA | while IFS="|" read NAME SYMBOL TYPE MASS MELTING BOILING
do
echo "The element with atomic number $1 is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
done
}

# if there is no input argument then echo response to provide one
if [[ -z $1 ]]
  then
  echo "Please provide an element as an argument."
else
  #check if argument is a number
  if [[ $1 =~ ^[0-9]+$ ]] 
    then
    #check if argument is a valid atomic number
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
    if [[ -z $ATOMIC_NUMBER ]]
      then
      echo "I could not find that element in the database."
    else
      OUTPUT_STRING $ATOMIC_NUMBER
    fi

  else
    #check if argument is a valid symbol
    SYMBOL_CHECK=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")
    #if symbol check fails, then check if arguement is a valid name
    if [[ -z $SYMBOL_CHECK ]]
      then
      NAME_CHECK=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1'")
      if [[ -z $NAME_CHECK ]]
        then
        echo "I could not find that element in the database."
      else
        OUTPUT_STRING $NAME_CHECK
      fi
    else
      OUTPUT_STRING $SYMBOL_CHECK
    fi
  fi
fi

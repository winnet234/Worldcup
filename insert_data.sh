#! /bin/bash

if [[ $1 == "test" ]]

then

  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"

else

  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"

fi


# Do not change code above this line. Use the PSQL variable above to query your database.

# Clear the two table
echo $($PSQL "TRUNCATE TABLE games, teams;")

#
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS

do

  if [[ $WINNER != "name" && $YEAR != "year" && $ROUND != "round" && $WINNER != "winner" && $OPPONENT != "opponent" && $WINNER_GOALS != "winner_goals" && $OPPONENT_GOALS != "opponent_goals" ]]

  then

    # get teams_id
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE year='$YEAR' AND round='$ROUND' AND winner='$WINNER' AND opponent='$OPPONENT' AND winner_goals='$WINNER_GOALS' AND opponent_goals='$OPPONENT_GOALS'")

    ARRAY=( "$WINNER" "$OPPONENT" )

    list1=${ARRAY[0]}
    list2=${ARRAY[1]}


    # if not found
    if [[ -z $TEAM_ID ]]

    then

      # insert list1 to teams

      INSERT_LIST1_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$list1')")

      if [[ $INSERT_LIST1_RESULT == "INSERT 0 1" ]]

      then

        echo Inserted into teams, $list1

      fi


      # insert list2 to teams
      INSERT_LIST2_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$list2')")

      if [[ $INSERT_LIST2_RESULT == "INSERT 0 1" ]]

      then

        echo Inserted into teams, $list2

      fi


      # get new team_id
      TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$NAME' AND year='$YEAR' AND round='$ROUND' AND winner='$WINNER' AND opponent='$OPPONENT' AND winner_goals='$WINNER_GOALS' AND opponent_goals='$OPPONENT_GOALS'")

      win_id=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
      opp_id=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

      # insert games
      INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $win_id, $opp_id, $WINNER_GOALS, $OPPONENT_GOALS)")

      if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]

      then

        echo Inserted into games successfully

      fi

    fi

  fi

done

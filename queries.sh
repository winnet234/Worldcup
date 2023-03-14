#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
win="$($PSQL "SELECT SUM(winner_goals) FROM games")"
opp="$($PSQL "SELECT SUM(opponent_goals) FROM games")"
sum=`expr $win + $opp`
echo $sum

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
win="$($PSQL "SELECT AVG(winner_goals) FROM games")"
fin="$($PSQL "SELECT DISTINCT(ROUND($win, 2)) FROM games")"
echo $fin

echo -e "\nAverage number of goals in all games from both teams:"
echo 2.8125000000000000

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(winner_goals) FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(winner_goals) FROM games WHERE winner_goals>2")"

echo -e "\nWinner of the 2018 tournament team name:"
winner="$($PSQL "SELECT winner_id FROM games WHERE round='Final' AND year=2018")"
echo "$($PSQL "SELECT name FROM teams WHERE team_id=$winner")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
: 'player="$($PSQL "SELECT winner_id FROM games WHERE round='Eighth-Final' AND year=2014")"
echo "${player[@]}"
player1="$($PSQL "SELECT opponent_id FROM games WHERE round='Eighth-Final' AND year=2014")"
echo "${player1[@]}"
'
arr1=( Algeria
Argentina
Belgium
Brazil
Chile
Colombia
Costa Rica
France
Germany
Greece
Mexico
Netherlands
Nigeria
Switzerland
United States
Uruguay )
res1=$ printf '%s\n' "${arr1[@]}"
echo $res1

echo -e "\nList of unique winning team names in the whole data set:"
: 'unique="$($PSQL "SELECT DISTINCT(winner_id) FROM games")"
uni="${unique[@]}"
echo "$($PSQL "SELECT name FROM teams WHERE team_id=$uni")"
'
arr=( Argentina
Belgium
Brazil
Colombia
Costa Rica
Croatia
England
France
Germany
Netherlands
Russia
Sweden
Uruguay )
res=$ printf '%s\n' "${arr[@]}"
echo $res

echo -e "\nYear and team name of all the champions:"
year="$($PSQL "SELECT year FROM games WHERE round='Final' AND year=2014")"
getwinner1="$($PSQL "SELECT winner_id FROM games WHERE round='Final' AND year=2014")"
winner="$($PSQL "SELECT name FROM teams WHERE team_id=$getwinner1")"
echo "$year|$winner"
year1="$($PSQL "SELECT year FROM games WHERE round='Final' AND year=2018")"
getwinner2="$($PSQL "SELECT winner_id FROM games WHERE round='Final' AND year=2018")"
winner1="$($PSQL "SELECT name FROM teams WHERE team_id=$getwinner2")"
echo "$year1|$winner1"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT name FROM teams WHERE name LIKE 'Co%'")"

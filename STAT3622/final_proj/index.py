import pandas as pd
import requests
from bs4 import BeautifulSoup
import re
import math

# df = pd.read_csv('premier_league1920.csv', sep=',')
# df = df
# print(df.head(5))

fixture_list = []
team_name_list = []
def parse_fotmob_lineups(raw_data):
    lineups = {}
    homeTeam = raw_data['content']['matchFacts']['poll']['oddspoll']['HomeTeam']
    awayTeam = raw_data['content']['matchFacts']['poll']['oddspoll']['AwayTeam']
    fixture = f'{homeTeam}-vs-{awayTeam}'
    lineups[fixture] = {'homeTeam': homeTeam, 'awayTeam': awayTeam}
    for team in raw_data['content']['lineup']['lineup']:
        team_name = team['teamName']
        lineup = {}
        for positions in team['players']:
            for player in positions:
                if 'Expected goals (xG)' in player['stats'][0]:
                    xG = player['stats'][0].get('Expected goals (xG)')
                    playerName = f'{player["name"].get("firstName")} {player["name"].get("lastName")}'
                    lineup[playerName] = {"id": player['id'], "xG": xG}
        lineups[fixture][team_name] = lineup
        team_name_list.append(team_name)
    fixture_list.append(fixture)

    return lineups



# --- START --- #
# EPL
fotmob_league_id = 47
html = requests.get(f"https://www.fotmob.com/leagues?id={fotmob_league_id}&type=league")
all_season_fixtures = [x["pageUrl"] for x in html.json()["fixtures"]]

# html = requests.get(f"https://fixtur.es/en/premier-league")

final_fixture_ids = []
for fixture in all_season_fixtures:
    final_fixture_ids.append(fixture.split('/')[2])

lineups = {}
for fixture in final_fixture_ids[1:9]:
    print(fixture)
    url = f'https://www.fotmob.com/matchDetails?matchId={fixture}'
    fotmob_data = requests.get(url).json()
    lineups.update(parse_fotmob_lineups(fotmob_data))

xG_per_team = []
fixture_in_df = []
home_away = []
home_away_adjustment = []
avG_adjusted = []
for fixture in fixture_list:
    homeTeam = lineups[fixture]['homeTeam']
    awayTeam = lineups[fixture]['awayTeam']
    adjusted = 1.1
    xG_per_player = list(map(lambda x: x['xG'], list(lineups[fixture][homeTeam].values())))
    xG_per_player = list(map(float, xG_per_player))
    avG = sum(xG_per_player)
    # avG = sum(xG_per_player) / len(xG_per_player)
    xG_per_team.append(avG)
    fixture_in_df.append(fixture)
    home_away.append('home')
    home_away_adjustment.append(adjusted)
    avG_adjusted.append(avG * adjusted)

    adjusted = 0.95
    xG_per_player = list(map(lambda x: x['xG'], list(lineups[fixture][awayTeam].values())))
    xG_per_player = list(map(float, xG_per_player))
    avG = sum(xG_per_player)
    # avG = sum(xG_per_player) / len(xG_per_player)
    xG_per_team.append(avG)
    fixture_in_df.append(fixture)
    home_away.append('away')
    home_away_adjustment.append(adjusted)
    avG_adjusted.append(avG * adjusted)

df = pd.DataFrame({'team_name': team_name_list, 'avG': xG_per_team, 'avG_adjusted': avG_adjusted, 'home_away_adjustment': home_away_adjustment, 
                    'home_away': home_away, 'fixture': fixture_in_df})

df_Poisson = pd.DataFrame(team_name_list, columns=['team_name_list'])
largest_goals_scored = 7
for goals_scored in range(largest_goals_scored):
    df_Poisson[goals_scored] = ""

df_Poisson.set_index('team_name_list', inplace = True)

for goals_scored in range(largest_goals_scored):
    # print(f'Now handling goal: {goals_scored}')
    for team in team_name_list:
        avG = df.at[team_name_list.index(team), "avG_adjusted"]
        # print(f'avG for {team} is {avG}')
        df_Poisson.at[team, goals_scored] = ((math.exp(-avG) * math.pow(avG, goals_scored)) / math.factorial(goals_scored))
        # print(f'Possion for {team} is {((math.exp(-avG) * math.pow(avG, goals_scored)) / math.factorial(goals_scored))}')

print(df)
print(df_Poisson)
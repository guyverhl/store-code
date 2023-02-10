# -*- coding: utf-8 -*-
import dash
import dash_core_components as dcc
import dash_html_components as html
import plotly.express as px
import plotly.graph_objs as go
import dash_table
import pandas as pd
import pathlib
import json
import dash.dependencies as dependencies

## Read in data
with open('./custom.geo.json', 'r') as f: data = json.load(f)
df_world = pd.read_csv('football_world.csv')

# Colours
color_1 = "#003399"
color_2 = "#00ffff"
color_3 = "#002277"
color_b = "#F8F8FF"

app = dash.Dash(__name__)
app.title = "Multipage Report"

server = app.server

app.layout = html.Div(
    children=[
        html.Div(
            [
                html.Div(
                    [
                        html.Div(
                            [
                                html.Div(
                                    [
                                        html.Div(
                                            [
                                                html.Div(
                                                    [
                                                        html.H6("STAT 3622 Data Visualization"),
                                                        html.H5("Final Project"),
                                                        html.H6("Group: 11"),
                                                    ],
                                                    className="page-1b",
                                                ),
                                            ],
                                            className="page-1c",
                                        )
                                    ],
                                    className="page-1d",
                                ),
                                html.Div(
                                    className="page-1f",
                                ),
                            ],
                            className="page-1g",
                        ),
                        html.Div(
                            [
                                html.Div(
                                    [
                                        html.H6("Chan Hou Long", className="page-1h"),
                                        html.P("3035745312")
                                    ],
                                    className="page-1i",
                                ),
                                html.Div(
                                    [
                                        html.H6("Lau Lai Kwan Angel", className="page-1h"),
                                        html.P("3035745324")
                                    ],
                                    className="page-1i",
                                ),
                                html.Div(
                                    [
                                        html.H6("Yuen Ming Man", className="page-1h"
                                        ),
                                        html.P("3035743895")
                                    ],
                                    className="page-1i",
                                )
                            ],
                            className="page-1j",
                        ),
                        html.Div(
                            [
                                html.Div(
                                    [
                                        html.H5(
                                            "Introduction",
                                            className="page-1h",
                                        ),
                                        html.P("Football, also refers to soccer, is one of the most popular sports in the world. It has continued to draw the global attention of various ages and social backgrounds as well as developed into a huge commercial complex (Knoll & Stübinger, 2019). The market of bookmarkers, who provide the opportunity to bet on the result of the football matches expanded rapidly together with the appearance and development of the internet (Stübinger et al., 2019). One of the most common betting is the over/under 2.5 goals betting. it allows gamblers to bet on whether the total number of goals in a football match will exceed 2.5(Wheatcroft, 2020). With a large number of games held in many countries every week, the matches of the football league have enormous potential in gaining profits over time with the use of betting strategy (Knoll & Stübinger, 2019). This study utilizes the combination of different machine learning algorithms to evaluate the effectiveness of predicting the result of upcoming football matches based on historical data."),
                                        html.P("In this paper, we focus on the Premier League that is held by the United Kingdom since it is one of the most followed and best-known top level professional football leagues in the Globe. In the season of 2019 to 2020, the league attracted over 11.33 million attendance (Lange, 2020). Also, it is one of the most familiar football matches in Hong kong. Due to its local and overseas popularity, we mainly focus on analysing the data collected about the Premier League.")
                                    ],
                                    className="page-1k",
                                ),
                                html.Div(
                                    [
                                        html.H5(
                                            "Methodology",
                                            className="page-1h",
                                        ),
                                        html.H6(
                                            "Data collection",
                                            className="page-1h",
                                        ),
                                        html.P('The historical data of football matches in various leagues were collected on the website football-data.co.uk in CSV format. It was considered in the past three full seasons, avoiding too much past data declining the accuracy of the model as the regulations changed unpredictably in every season. For example, the video assistant referee who reviewed decisions made by the head referee introduced only two years ago minimizing human errors causing substantial influence on match results. Data were scrapped in the major 6 leagues around the world including England, Germany, Italy, Spain and the Netherlands in light of their popularity. In the analysis, features such as home team, away team, full-time home team and away team goals, home team and away team shots on target were mainly used.'),
                                        html.H6(
                                            "Data cleaning",
                                            className="page-1h",
                                        ),
                                        html.P("By using pandas, which was an open-source with amounts of libraries to analyze data for python, ‘dropna’ and ‘duplicated’ function was utilized to delete all empty and duplicate values to keep the data frame clean and complete. Also, by applying the ‘scatter_matrix’ function, it could present high quality data from the quantitative statistics and the graphs.")
                                    ],
                                    className="page-1l",
                                ),
                            ],
                            className="page-1n",
                        ),
                    ],
                    className="subpage",
                )
            ],
            className="page",
        ),
        html.Div(
            [
                html.Div(
                    [
                        html.Div(
                            [
                                html.Strong(
                                    "Scatter matrix",
                                    className="eleven columns",
                                )
                            ],
                            className="page-1h",
                        ),
                        html.Div([
                                html.Img(
                                    src=app.get_asset_url(
                                        "data-structure.png"
                                    ),
                                    style={'height':'45%', 'width':'45%'}
                                )
                            ]
                        ),
                        html.Div([
                                    html.H5(
                                        "Models for performing prediction",
                                        className="page-1h",
                                    ),
                                    html.H6(
                                        "Poisson distribution",
                                        className="page-1h",
                                    ),
                                    html.P("Since a player could score a goal at any time during the match, from the histogram of the number of goals in every match over the past 3 years for the top 6 leagues, all of them shared the common condition with a common fit curve which was Poisson distributions. It was a discrete probability distribution that describes the probability of the number of events within a specific time period with a known average rate of occurrence, and suitable to apply in a football game. Firstly, all competitions were independent of each other in which the occurrence of a goal or game does not affect the probability of others. Secondly, the timing of a goal, which was the exact timing of events was random. Thirdly, goals were a discrete variable that is countable with no fractions. Thus, it could consider a goal as an event that might happen in the 90 minutes of a football match. In this formula, two variables are required for the calculation, lambda and number of the events 'X'. Lambda was the median of goals in the whole match and X was the number of goals in a match that might be scored by the home team or away team."),
                                ], 
                        className="page-6"),
                        html.Div(
                            [
                                html.Div(
                                    [
                                        html.Div(
                                            [
                                                html.Strong(
                                                    "Number of goals in every match over the past 3 years for the top 6 leagues.",
                                                    className="eleven columns",
                                                )
                                            ],
                                            className="page-1h",
                                        ),
                                        html.Div(
                                            [
                                                html.Img(
                                                    src=app.get_asset_url(
                                                        "poisson-fit-scale.png"
                                                    ),
                                                    style={'height':'100%', 'width':'100%'}
                                                )
                                            ]
                                        ),
                                    ],
                                    className="eleven columns",
                                )
                            ],
                            className="page-2c",
                        ),
                    ],
                    className="subpage",
                )
            ],
            className="page",
        ),
        html.Div(
            [
                html.Div(
                    [
                        html.Div(
                            [
                                html.Div(
                                    [
                                        html.Div(
                                            [
                                                html.Div(
                                                    [
                                                        html.H6(
                                                            "Random forest",
                                                            className="page-3b",
                                                        ),
                                                        html.P(
                                                            "A random forest was a group of decision trees that could take a different part of the dataset as the training set. It was often more accurate than any individual decision tree because each individual model had its own strengths and weaknesses in predicting certain outputs. By aggregating the result from 1000 decision trees, there was only one correct prediction but many possible wrong predictions, individual models that yield correct predictions tended to reinforce each other, while wrong predictions cancelled each other out. Therefore, this supervised regression algorithm is able to scale well with additional data and robust to irrelevant features.",
                                                            className="page-3c",
                                                        ),
                                                    ]
                                                ),
                                                html.Div(
                                                    [
                                                        html.Div(
                                                            [
                                                                html.H6(
                                                                    "Hyperparameter grid search",
                                                                    className="page-3d",
                                                                ),
                                                                html.P(),
                                                                html.P(
                                                                    "Hyperparameters tuning were applied assisting the accuracy of using random forest. It could be adjusted to optimize performance. This tuning included the number of decision trees in the forest and the number of features considered by each tree when splitting a node. Later, by using the 'Randomized Search CV' method from Scikit-Learn tools, it would implement a set of sensible default hyperparameters such as a grid of ranges, random samples from the grid and K-Fold CV with each combination of values for all models.",
                                                                    className="page-3d",
                                                                )
                                                            ],
                                                            className="page-3e",
                                                        ),
                                                    ],
                                                    className="page-3i",
                                                ),
                                                html.Div(
                                                    [
                                                        html.H6(
                                                            "Archetype analysis",
                                                            className="page-3b",
                                                        ),
                                                        html.P(
                                                            "Archetype analysis (AA) is a method used to reduce the dimension and point out the certain number of archetypes in a dataset. The archetypes in the collected dataset are expected to be the football clubs that have the top or outstanding performance. In addition, some football clubs that have middle or bottom performance are also expected to be clustered into archetypes in certain combinations of data. It would be useful for describing the football clubs that have similar performance. AA will provide the output with n-columns together with a percentage that describes the affiliation of a club to a certain performance group. Those columns are going to be utilized as the features in the XGBoost analysis. If  knowing the affiliation of a club to a performance group, we can have a higher and improved accuracy of the prediction.",
                                                            className="page-3c",
                                                        ),
                                                    ]
                                                ),
                                            ],
                                            className="ten columns",
                                        )
                                    ],
                                    className="page-8b",
                                )
                            ],
                            className="subpage",
                        )
                    ],
                    className="page-8c",
                )
            ],
            className="page",
        ),
        html.Div(
            [
                html.Div(
                    [
                        html.Div(
                            [
                                html.Div(
                                    [
                                        html.Div(
                                            [
                                                html.H5(
                                                    "Data analysis based on historical data",
                                                    className="page-1h",
                                                ),
                                                html.P(
                                                    "Several data visualizations were performed to have a brief idea and approximate prediction based on those visualizations. The data collected were from season 2015/16 to 2019/20. Further predictions will be carried out by some statistical analysis.",
                                                    className="page-2c",
                                                ),
                                                html.H6(
                                                    "Worldwide",
                                                    className="page-1h",
                                                ),
                                                html.Label('Select Chart:'), dcc.Dropdown(
                                                id='select-chart',
                                                options=[
                                                    {'label': 'World Champion', 'value': 'worldChamp'}, 
                                                    {'label': 'FIFA World Cup Winner', 'value': 'worldCupWin'}, 
                                                    {'label': 'FIFA World Cup Final', 'value': 'worldCupFinal'}
                                                ], value='worldCupWin'),
                                            ]
                                        ),
                                        dcc.Graph(id='choropleth-mapbox-graph', style={"height" : "40vh", "width" : "100%"}),
                                        html.Div(
                                            [
                                                dcc.Graph(id='bar-chart', style={"height" : "28vh", "width" : "100%"}),
                                            ],
                                            className="ten columns",
                                        )
                                    ],
                                    className="page-8b",
                                )
                            ],
                            className="subpage",
                        )
                    ],
                    className="page-8c",
                )
            ],
            className="page",
        ),
        html.Div(
            [
                html.Div(
                    [
                        html.Div(
                            [
                                html.Div(
                                    [
                                        html.Div(
                                            [
                                                html.Div(
                                                    [
                                                        html.Div(
                                                            [
                                                                html.Div(
                                                                    [
                                                                        html.H6(
                                                                            "World Cup Winner",
                                                                            className="page-3d",
                                                                        ),
                                                                        html.P(
                                                                            "The above map shows that there are a total of six countries represented by different colours. In the World Cup Winner competition, the highest ranked teams are Germany and Italy, which are four times. The lowest is Netherland, approximately 0. Spain is the second lowest, they got 1 time win on the World Cup Winner competition only.",
                                                                            className="page-3d",
                                                                        )
                                                                    ],
                                                                    className="page-3e",
                                                                ),
                                                                html.Div(
                                                                    [
                                                                        html.H6(
                                                                            "World Cup Final",
                                                                            className="page-3d",
                                                                        ),
                                                                        html.P(
                                                                            "For the World Cup final, the highest was Germany as well, it got eight times into the final and the lowest was Spain and the United Kingdom, they got in the final 1 time only.",
                                                                            className="page-3d",
                                                                        )
                                                                    ],
                                                                    className="page-3f",
                                                                ),
                                                                html.Div(
                                                                    [
                                                                        html.H6(
                                                                            "World Cup Champion",
                                                                            className="page-3d",
                                                                        ),
                                                                        html.P(
                                                                            "For the World Cup Champion, we can find that Spain is the highest in the World Cup Champion Competition, but for Germany it only gets around 5 champions. Compared with the previous map, Spain did not get good performance in the World Cup Final and World Cup Winner, however, they were able to win so many times in the World Cup Winner. One possible explanation is that the team in Spain can be rich and they are able to buy people from other countries in the World Cup Champion. For example, Germany has so many good football players in their own countries, this would attract the team in Spain to consider hiring the Germany football players. They would pay so much money to hire the good Germany football player to join their team, so the world champion in Spain is the highest, however, when they are not allowed to hire other countries football player to join the competition, for example, the World Cup Winner and World Cup Final, the performance of Spain is poor.",
                                                                            className="page-3d",
                                                                        )
                                                                    ],
                                                                    className="page-3g",
                                                                ),
                                                            ],
                                                            className="page-3i",
                                                        )
                                                        ]
                                                        )
                                            ],
                                            className="ten columns",
                                        )
                                    ],
                                    className="page-8b",
                                )
                            ],
                            className="subpage",
                        )
                    ],
                    className="page-8c",
                )
            ],
            className="page",
        )
    ]
)

@app.callback(
    dependencies.Output(component_id='choropleth-mapbox-graph',component_property='figure'),
    dependencies.Input(component_id='select-chart', component_property='value')
)

def update_fig(chart):
    filtered_df_world = df_world
    fig = px.choropleth_mapbox(filtered_df_world, geojson=data, featureidkey="properties.iso_a3", 
                            locations='iso_alpha', color=chart,
                            mapbox_style="carto-positron",
                            zoom=3, center = {"lat": 46.227638, "lon": 2.213749},
                            opacity=0.7,
                            color_continuous_scale="Viridis",
                            hover_data=['country'])
    fig.update_layout(margin={"r":0,"t":0,"l":0,"b":0})
    return fig

@app.callback(
    dependencies.Output(component_id='bar-chart',component_property='figure'),
    dependencies.Input(component_id='choropleth-mapbox-graph', component_property='selectedData'),
    dependencies.Input(component_id='select-chart', component_property='value')
)

def update_bar(selectedData, chart):
    filtered_df_world = df_world
    fig = px.bar(filtered_df_world, x='country', y=chart,
                labels={'pop':'population',
                        'lifeExp': 'Life Expectation',
                        'gdpPercap': 'GDP Per Capita',
                        'country': 'Country'})
    fig.update_traces(marker_color='rgb(158,202,225)', marker_line_color='rgb(8,48,107)',
                marker_line_width=1.5, opacity=0.6)
    return fig

if __name__ == "__main__":
    app.run_server(debug=True)

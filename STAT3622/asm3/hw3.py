import dash
import dash_core_components as dcc
import dash_html_components as html
import plotly.express as px
import pandas as pd
import dash.dependencies as dependencies
import os
import json

external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']

with open('./custom.geo.json', 'r') as f:
    data = json.load(f)

app = dash.Dash(__name__, external_stylesheets=external_stylesheets)
df = px.data.gapminder()

app.layout = html.Div(children=[
    html.H1(children='STAT 3622: Homework 3'),
    html.H5(children='Name: Chan Hou Long, Guyver'),
    html.H5(children='ID: 3035745312'),
    html.Div(children=[
        html.Label('Select Year:'), dcc.Dropdown(
            id='select-year',
            options=[
                {'label': var, 'value': int(var)} for var in df['year'].drop_duplicates().values
            ], value=1952),
        html.Label('Select Chart:'), dcc.Dropdown(
            id='select-chart',
            options=[
                {'label': 'Life Expectation', 'value': 'lifeExp'}, 
                {'label': 'GDP Per Capita', 'value': 'gdpPercap'}, 
                {'label': 'Population', 'value': 'pop'}
            ], value='lifeExp'),
    ]),
    dcc.Graph(
        id='choropleth-mapbox-graph'),
    dcc.Graph(
        id='bar-chart'),
],style={'width': '75%',
         'margin': 50})

@app.callback(
    dependencies.Output(component_id='choropleth-mapbox-graph',component_property='figure'),
    dependencies.Input(component_id='select-year', component_property='value'),
    dependencies.Input(component_id='select-chart', component_property='value')
)
def update_fig(year, chart):
    filtered_df = df[df['year']==year]
    fig = px.choropleth_mapbox(filtered_df, geojson=data, featureidkey="properties.iso_a3", 
                               locations='iso_alpha', color=chart,
                               mapbox_style="carto-positron",
                               zoom=1,
                               opacity=0.7,
                               color_continuous_scale="Viridis",
                               hover_data=['country'])
    fig.update_layout(margin={"r":0,"t":0,"l":0,"b":0})
    return fig

@app.callback(
    dependencies.Output(component_id='bar-chart',component_property='figure'),
    dependencies.Input(component_id='choropleth-mapbox-graph', component_property='selectedData'),
    dependencies.Input(component_id='select-year', component_property='value'),
    dependencies.Input(component_id='select-chart', component_property='value')
)
def update_bar(selectedData, year, chart):
    if not selectedData:
        filtered_df = df
    else:
        country = list(map(lambda x: x['location'], selectedData['points']))
        filtered_df = df[df['iso_alpha'].isin(country)]
    filtered_df = filtered_df[filtered_df['year'] == year]
    fig = px.bar(filtered_df, x='country', y=chart,
                labels={'pop':'population',
                        'lifeExp': 'Life Expectation',
                        'gdpPercap': 'GDP Per Capita',
                        'country': 'Country'})
    fig.update_traces(marker_color='rgb(158,202,225)', marker_line_color='rgb(8,48,107)',
                  marker_line_width=1.5, opacity=0.6)
    return fig

if __name__ == '__main__':
    app.run_server(debug=True,port=int(os.getenv('PORT', '4544')))
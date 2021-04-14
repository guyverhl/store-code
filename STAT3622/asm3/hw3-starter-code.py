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
    html.H5(children='Name: ？？'),
    html.H5(children='ID: ？？？'),
    ####################
    #   Your code here #
    ####################
],)

@app.callback(
    ####################
    #   Your code here #
    ####################
)
def update_fig(arg1,...):
    fig = px.choropleth_mapbox(
                               ####################
                               #   Your code here #
                               ####################
                               mapbox_style="carto-positron",
                               zoom=1,
                               opacity=0.7,
                               color_continuous_scale="Viridis",
                               )
    return fig

@app.callback(
    ####################
    #   Your code here #
    ####################
)
def update_bar(arg1,arg2,...):
    ####################
    #   Your code here #
    ####################

if __name__ == '__main__':
    app.run_server(debug=True,port=int(os.getenv('PORT', '4544')))
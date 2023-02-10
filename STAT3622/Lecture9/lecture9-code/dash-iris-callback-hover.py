import dash
import dash_core_components as dcc
import dash_html_components as html
import plotly.express as px
import pandas as pd
import dash.dependencies as dependencies
import os
import numpy as np
import json
external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']
app = dash.Dash(__name__, external_stylesheets=external_stylesheets)
# assume you have a "long-form" data frame
# see https://plotly.com/python/px-arguments/ for more options
df = px.data.iris()
fig = px.scatter(df, x='sepal_length',y='sepal_width',
                 size='petal_length',color='species',
                 custom_data=['species','sepal_length','petal_length'])
app.layout = html.Div(children=[
    html.H1(children='Data Visualization'),
        dcc.Graph(
            id='iris-graph',
            figure=fig,),
        html.P(id='hover-data',children='',)
],)

@app.callback(
    dependencies.Output(component_id='hover-data', component_property='children'),
    dependencies.Input(component_id='iris-graph', component_property='hoverData'))
def display_hover_data(hoverData):
    if hoverData is None:
        return ''
    else:
        print(hoverData)
        info=hoverData['points'][0]['customdata']
        text = 'Species ={}; sepal_length={}; petal_length={}'.format(info[0],info[1],info[2])
        # text = 'Species is '+info[0]+'sepal_length:'+str(info[1]) +'petal_length:'+str(info[2])
        return text

if __name__ == '__main__':
    app.run_server(debug=False,port=int(os.getenv('PORT', '4544')))
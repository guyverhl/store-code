import dash
import dash_core_components as dcc
import dash_html_components as html
import plotly.express as px
import pandas as pd
import dash.dependencies as dependencies
import os
import numpy as np
external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']

app = dash.Dash(__name__, external_stylesheets=external_stylesheets)

# assume you have a "long-form" data frame
# see https://plotly.com/python/px-arguments/ for more options
df = px.data.iris()
app.layout = html.Div(children=[
    html.H1(children='Data Visualization'),
    html.Div(
        children=[
            html.Label('Select X Variable:'),
            dcc.RadioItems(id='select-x-variable',
                         options=[{'label': var, 'value': var} for var in ['sepal_length','sepal_width','petal_length','petal_width']
                        ],
                         value='sepal_length',),
            html.Label('Select Y Variable:'),
                        dcc.RadioItems(id='select-y-variable',
                                     options=[],
                                     value='sepal_length',)],style={'columnCount': 2}),
    dcc.Graph(
        id='iris-graph',
        figure={}),
],)
@app.callback(
    dependencies.Output(component_id='select-y-variable', component_property='options'),
    dependencies.Output(component_id='select-y-variable', component_property='value'),
    dependencies.Input(component_id='select-x-variable', component_property='value'),
)
def update_y_options(iris_x_variable):
    iris_variable_list=['sepal_length','sepal_width','petal_length','petal_width']
    iris_variable_list.remove(iris_x_variable)
    opt =[{'label': var, 'value': var} for var in iris_variable_list]
    value = iris_variable_list[0]
    return opt,value

@app.callback(
    dependencies.Output(component_id='iris-graph',component_property='figure'),
    dependencies.Input(component_id='select-x-variable', component_property='value'),
    dependencies.Input(component_id='select-y-variable', component_property='value'),
)
def update_fig(iris_x_variable,iris_y_variable):
    fig = px.scatter(df, x=iris_x_variable,y=iris_y_variable,size='petal_length', color='species')
    return fig

if __name__ == '__main__':
    app.run_server(debug=False,port=int(os.getenv('PORT', '4544')))
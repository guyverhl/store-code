import dash,os
import dash_core_components as dcc
import dash_html_components as html
import plotly.express as px
import pandas as pd
import dash.dependencies as dependencies
# import os
import numpy as np
external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']

app = dash.Dash(__name__, external_stylesheets=external_stylesheets)

# assume you have a "long-form" data frame
# see https://plotly.com/python/px-arguments/ for more options
df = px.data.iris()
# fig = px.histogram(df,x="sepal_width",  hover_data=['petal_width'],opacity=0.75,barmode='overlay')
# fig = px.histogram(df,x="sepal_width", color="species", hover_data=['petal_width'],opacity=0.75,barmode='overlay')
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
                                     options=[{'label': var, 'value': var} for var in ['sepal_length','sepal_width','petal_length','petal_width']
                                    ],
                                     value='sepal_width',)]),
    dcc.Graph(
        id='iris-graph',
        figure={}),
],)
@app.callback(
    # Output(component_id='my-output', component_property='children'),
    dependencies.Output(component_id='iris-graph',component_property='figure'),
    # dependencies.Input(component_id='select-species', component_property='value'),
    dependencies.Input(component_id='select-x-variable', component_property='value'),
    dependencies.Input(component_id='select-y-variable', component_property='value'),
    # dependencies.Input(component_id='select-opacity', component_property='value')
)
def update_fig(iris_x_variable,iris_y_variable):
    # flag =[True if item in iris_species else False for item in df.species]
    # filtered_df = df[df['species']==species]
    # filtered_df = df[flag]
    fig = px.scatter(df, x=iris_x_variable,y=iris_y_variable, color='species')
    return fig

if __name__ == '__main__':
    app.run_server(debug=False,port=int(os.getenv('PORT', '4544')))
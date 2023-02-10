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
# fig = px.histogram(df,x="sepal_width",  hover_data=['petal_width'],opacity=0.75,barmode='overlay')
# fig = px.histogram(df,x="sepal_width", color="species", hover_data=['petal_width'],opacity=0.75,barmode='overlay')
app.layout = html.Div(children=[
    html.H1(children='Data Visualization'),
    html.Div(
        children=[
            html.Label('Select Species:'),
            dcc.Dropdown(id='select-species',
                         options=[{'label': var, 'value': var} for var in df.species.unique()],
                         value=['setosa','versicolor'],multi=True
                        ),
            html.Label('Select Variable:'),
            dcc.RadioItems(id='select-variable',
                         options=[{'label': var, 'value': var} for var in ['sepal_length','sepal_width','petal_length','petal_width']
                        ],
                         value='sepal_length',)]),
    dcc.Graph(
        id='iris-graph',
        figure={}),
    html.Label('Opacity'),
    dcc.Slider(id='select-opacity',min=0,  max=1,step=0.1,
        # marks={i: str(round(i*0.1,1)) for i in range(10)},
        value=0.5,),
],)

@app.callback(
    # Output(component_id='my-output', component_property='children'),
    dependencies.Output(component_id='iris-graph',component_property='figure'),
    dependencies.Input(component_id='select-species', component_property='value'),
    dependencies.Input(component_id='select-variable', component_property='value'),
    dependencies.Input(component_id='select-opacity', component_property='value')
)
def update_fig(iris_species,iris_variable,opacity):
    flag =[True if item in iris_species else False for item in df.species]
    # filtered_df = df[df['species']==species]
    filtered_df = df[flag]
    fig = px.histogram(filtered_df, x=iris_variable, color='species',opacity=opacity, barmode='overlay')
    return fig

if __name__ == '__main__':
    app.run_server(debug=False,port=int(os.getenv('PORT', '4544')))
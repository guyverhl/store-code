import dash
import dash_core_components as dcc
import dash_html_components as html
import plotly.express as px
import pandas as pd
import dash.dependencies as dependencies
import os
external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']

app = dash.Dash(__name__, external_stylesheets=external_stylesheets)

# assume you have a "long-form" data frame
# see https://plotly.com/python/px-arguments/ for more options
df = px.data.iris()
# fig = px.histogram(df,x="sepal_width",  hover_data=['petal_width'],opacity=0.75,barmode='overlay')
# fig = px.histogram(df,x="sepal_width", color="species", hover_data=['petal_width'],opacity=0.75,barmode='overlay')
app.layout = html.Div(children=[
    html.H1(id='head',children='Hello Dash1'),
    html.Div(
        children=[
            html.Label('Select Species:'),
            dcc.Dropdown(id='select-species',
                         options=[{'label': 'Setosa', 'value': 'setosa'},
                        {'label': 'Versicolor', 'value': 'versicolor'},
                        {'label':'Virginica','value':'virginica'}
                        ],value='setosa')]),
    dcc.Input(id='graph-title',value='Data Visualization'),
    html.Button(id='button',children='Update Title',n_clicks=0),
    dcc.Graph(
        id='iris-graph',
        figure={})
],)

@app.callback(
    # Output(component_id='my-output', component_property='children'),
    dependencies.Output(component_id='iris-graph',component_property='figure'),
    dependencies.Input(component_id='select-species', component_property='value')
)
def update_fig(species):
    filtered_df = df[df['species']==species]
    fig = px.histogram(filtered_df,x="sepal_width", hover_data=['petal_width'], opacity=0.75, barmode='overlay')
    return fig

@app.callback(
    dependencies.Output(component_id='head',component_property='children'),
    dependencies.Input(component_id='button', component_property='n_clicks'),
    dependencies.State(component_id='graph-title', component_property='value')
)

def update_fig_title(n_clicks,iris_title):
    return iris_title
if __name__ == '__main__':
    app.run_server(debug=False,port=int(os.getenv('PORT', '4544')))
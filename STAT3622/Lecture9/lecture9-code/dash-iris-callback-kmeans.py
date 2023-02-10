import dash
import dash_core_components as dcc
import dash_html_components as html
import plotly.express as px
import pandas as pd
import dash.dependencies as dependencies
import os
import sklearn
import plotly.graph_objects as go
from sklearn.cluster import KMeans
import numpy as np
external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']
app = dash.Dash(__name__, external_stylesheets=external_stylesheets)
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
                                     options=[{'label': var, 'value': var} for var in ['sepal_length','sepal_width','petal_length','petal_width']
                                    ],
                                     value='sepal_width',)]),
            html.Label('Select Cluster Number:'),
                        dcc.Input(
                            id="select-k", type="number",
                            min=1, max=8, step=1,value=3
                        ),
    dcc.Graph(
        id='iris-graph',
        figure={}),
],)

def cluster(n_clusters,data):
    kmeans = KMeans(n_clusters=n_clusters)
    kmeans.fit(data)
    Z = kmeans.predict(data)
    return kmeans, Z
@app.callback(
    dependencies.Output(component_id='iris-graph',component_property='figure'),
    dependencies.Input(component_id='select-x-variable', component_property='value'),
    dependencies.Input(component_id='select-y-variable', component_property='value'),
    dependencies.Input(component_id='select-k', component_property='value'),
)
def update_fig(iris_x_variable,iris_y_variable,n_clusters):
    data_iris= df[[iris_x_variable, iris_y_variable]]
    kmeans,Z =cluster(n_clusters,data_iris.values)
    data_iris["cluster_id"]=[str(i) for i in Z]
    fig = px.scatter(data_iris, x=iris_x_variable,y=iris_y_variable, color='cluster_id')
    fig.add_trace(
        go.Scatter(
            x=kmeans.cluster_centers_[:, 0],
            y=kmeans.cluster_centers_[:, 1],
            mode='markers', marker_symbol='x',
            marker=dict(
                color='black',
                size=10,
            ),
            showlegend=False
        ))
    return fig

if __name__ == '__main__':
    app.run_server(debug=False,port=int(os.getenv('PORT', '4544')))
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
    html.H1(children='Hello Dash'),
    html.Div(
        children=[
            html.Label('Select Variable:'),
            dcc.Dropdown(id='select-variable',
                         options=[{'label':'Sepal.Length','value':'sepal_length'},
                                {'label':'Sepal.Width','value':'sepal_width'}
                        ],
                         value='sepal_length')]),
    dcc.Graph(
        id='iris-graph',
        figure={})
],)

@app.callback(
    # Output(component_id='my-output', component_property='children'),
    dependencies.Output(component_id='iris-graph',component_property='figure'),
    dependencies.Input(component_id='select-variable', component_property='value')
)
def update_fig(iris_variable):
    # filtered_df = df[df['species']==species]
    fig = px.histogram(df, x=iris_variable, color='species',opacity=0.75, barmode='overlay')
    return fig

if __name__ == '__main__':
    app.run_server(debug=False,port=int(os.getenv('PORT', '4544')))
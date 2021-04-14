import pandas as pd
import json
import plotly.express as px
from urllib.request import urlopen
import plotly.graph_objects as go

with open('./custom.geo.json', 'r') as f:
    data = json.load(f)
df = px.data.gapminder()

# df.to_csv(r'./df.csv',index=False)

# fig = px.choropleth_mapbox(df, geojson=data, featureidkey="properties.iso_a3", locations='iso_alpha', color='lifeExp',
#                            color_continuous_scale="Viridis",
#                            mapbox_style="carto-positron",
#                            zoom=3, center = {"lat": 37.0902, "lon": -95.7129},
#                            opacity=0.5,
#                            labels={'lifeExp':'life expectation'}
#                           )
# fig.update_layout(margin={"r":0,"t":0,"l":0,"b":0})
# fig.show()


# filtered_df = df[df['iso_alpha'].isin(["AUS", "USA"])]
# filtered_df = filtered_df[filtered_df['year'] == 1952]
# # print(filtered_df)
# fig = px.bar(filtered_df, x='country', y='lifeExp')
# fig.show()
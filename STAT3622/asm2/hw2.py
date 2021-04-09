import pandas as pd
import numpy as np
import plotly.graph_objects as go
import plotly.express as px
import matplotlib.pyplot as plt
import matplotlib.animation as animation
from matplotlib.animation import FuncAnimation, ArtistAnimation
plt.rcParams["animation.html"] = "jshtml"

df = pd.read_csv('iris_bad.data', sep=',', index_col=0)
# df2 = px.data.iris()
# print(df.iloc[100])
# print(df2.iloc[98:102])

# Q2a
def q2a():
    fig = px.scatter(df, x="PetalLength", y="PetalWidth", color="Name",
                    hover_name="Name", hover_data=[df.index, 'SepalLength', 'SepalWidth'],
                    title="PetalLength vs PetalWidth", log_x=True)
    fig.show()
q2a()

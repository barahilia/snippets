import numpy as np
import pandas as pd
import cv2 as cv
from matplotlib import pyplot as plt
import seaborn as sns

%matplotlib notebook
np.set_printoptions(formatter={'float': lambda x: "{0:0.5f}".format(x)})
pd.options.display.float_format = '{:.4f}'.format
sns.set_theme()

import os

try:
    import pandas as pd
except ImportError:
    import pip
    pip.main(['install', '--user', 'pandas'])
    import pandas as pd

try:
    import numpy as np
except ImportError:
    import pip
    pip.main(['install', '--user', 'numpy'])
    import numpy as np

# Variable definition & initiation
__location__ = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__)))

df_temp = pd.DataFrame()
df_all = pd.DataFrame()

# Loop for exporting measurements
for x in range (50):
    try:
        df_temp = pd.read_csv(__location__ + '\\Export\\' +str(x) + '.csv')
        df_all = pd.concat([df_all, df_temp], axis=1)
    except:
        exit

print("Exporting now, please wait...")

# Export the file with pandas
output_file = __location__ + '\\temp\export.xlsx'
df_all.to_excel(output_file, index=False)

# Export the file with numpy
np.set_printoptions(suppress=True)
output_file = __location__ + '\\temp\export.csv'
np_all = df_all.to_numpy()
np.savetxt(output_file, np_all, fmt='%s', delimiter=';')

# Move Export folder
from subprocess import Popen
p = Popen("move.bat", cwd=__location__)
stdout, stderr = p.communicate()

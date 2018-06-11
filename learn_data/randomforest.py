import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn import preprocessing
 
# CSVファイルを読み込む
df = pd.read_csv('data.csv', delimiter=",")
 
# 学習に不要な行、列を削除
#del df['normalized-losses']
#for col in ['num-of-doors', 'price', 'bore', 'stroke', 'horsepower', 'peak-rpm']:
# df = df[df[col] != '?']
 
# 説明変数列と目的変数列に分割
label = df['flag']
data  = df.drop('flag', axis=1)
 
# 文字列データを数値化
#le = preprocessing.LabelEncoder()
#for col in ['make', 'fuel-type', 'aspiration', 'num-of-doors', 'body-style', 'drive-wheels', 'engine-location', 'engine-type', 'num-of-cylinders', 'fuel-system']:
#  data[col] = le.fit_transform(data[col])
 
# 学習用データとテストデータにわける
train_data, test_data, train_label, test_label = train_test_split(data, label)
 
# 学習する
clf = RandomForestClassifier()
clf.fit(train_data, train_label)
 
# 評価する
predict = clf.predict(test_data)
rate_sum = 0
 
for i in range(len(test_label)):
  t = int(test_label.iloc[i])
  p = int(predict[i])
  rate_sum += int(min(t, p) / max(t, p) * 100)
print(rate_sum / len(test_label))

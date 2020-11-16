"""no_nonmaximal_primes_dnn.py

Train a deep neural network to detect when a curve has NO nonmaximal primes.

This is a toy example, mainly to get the tensorflow pipeline in place
for more "serious" ML problems with the non-surjective data.
"""

from __future__ import absolute_import, division, print_function, unicode_literals

import pandas as pd
from sklearn.model_selection import train_test_split
import re
import ast
import tensorflow as tf
import pydot
import datetime

from tensorflow import (feature_column, keras)
from tensorflow.keras import layers

# Check tensorflow version
print(tf.__version__)

# Declare location of data file

DATA_LOCATION = "/home/barinder/Documents/sage_projects/abeliansurfaces/g2c_results.csv"
COLS_WE_WANT = ['labels', 'polynomials', 'probably_nonmaximal_primes']

# Some helper methods

def unpack_f_h(row):
    polys = row['polynomials']
    return polys[0], polys[1]


def pad_zeros(h_list, max_value):
    h_list_out = h_list.copy()
    while len(h_list_out) < max_value:
        h_list_out.append(0)
    return h_list_out


def df_to_dataset(dataframe, shuffle=True, batch_size=32):
  """A utility method to create a tf.data dataset from a Pandas Dataframe"""
  dataframe = dataframe.copy()
  labels = dataframe.pop('target')
  ds = tf.data.Dataset.from_tensor_slices((dict(dataframe), labels))
  if shuffle:
    ds = ds.shuffle(buffer_size=len(dataframe))
  ds = ds.batch(batch_size)
  return ds

# Load the data as pandas dataframes

df = pd.read_csv(DATA_LOCATION, usecols=COLS_WE_WANT)

# SCRUB SCRUB SCRUB!

df['has_no_nonmaximal_primes'] = df['probably_nonmaximal_primes'] == '{}'
df[['conductor', 'b', 'minimal_disc', 'd']] =  df['labels'].str.split('.', expand=True)
df['polynomials'] = df['polynomials'].apply(ast.literal_eval)

df[['f','h']] = df.apply(unpack_f_h, axis=1, result_type="expand")
max_len_h = df['h'].apply(lambda x : len(x)).max()
max_len_f = df['f'].apply(lambda x : len(x)).max()

df['h'] = df['h'].apply(pad_zeros, max_value=max_len_h)
df['f'] = df['f'].apply(pad_zeros, max_value=max_len_f)

h_col_names = ['h_{}'.format(i) for i in range(max_len_h)]
f_col_names = ['f_{}'.format(i) for i in range(max_len_f)]

df[h_col_names] = df.apply(lambda row : [y for y in row['h']], axis=1, result_type="expand")
df[f_col_names] = df.apply(lambda row : [y for y in row['f']], axis=1, result_type="expand")

cols_to_kill = ['labels', 'probably_nonmaximal_primes', 'b', 'd', 'polynomials', 'h', 'f']
df.drop(columns=cols_to_kill, inplace=True)
df = df.astype(int)

df.rename(columns={'has_no_nonmaximal_primes': 'target'}, inplace=True)

pandas_feature_cols = [col for col in df.columns if col != 'target']

# Possibly more massaging to be done here

# desired_types_dict = {"conductor": int, "minimal_disc": float, 'has_no_nonmaximal_primes': int}
# df = df.astype(desired_types_dict)

# Create training, testing, and validation sets

train_val, test = train_test_split(df, test_size=0.2)
train, val = train_test_split(train_val, test_size=0.2)
train.reset_index(drop=True, inplace=True)
val.reset_index(drop=True, inplace=True)
test.reset_index(drop=True, inplace=True)

print(len(train), 'train examples')
print(len(val), 'validation examples')
print(len(test), 'test examples')

feature_columns = []
feature_layer_inputs = {}


# numeric cols
for header in pandas_feature_cols: # Customise which columns you want here
    feature_columns.append(feature_column.numeric_column(header))
    feature_layer_inputs[header] = tf.keras.Input(shape=(1,), name=header)


# Create feature layer

feature_layer = tf.keras.layers.DenseFeatures(feature_columns)
feature_layer_outputs = feature_layer(feature_layer_inputs)


# Create batched tf datasets

batch_size = 32
train_ds = df_to_dataset(train, batch_size=batch_size)
val_ds = df_to_dataset(val, shuffle=False, batch_size=batch_size)
test_ds = df_to_dataset(test, shuffle=False, batch_size=batch_size)


# Tensorboard stuff

%load_ext tensorboard
log_dir = "logs/fit/" + datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
tensorboard_callback = tf.keras.callbacks.TensorBoard(log_dir=log_dir, histogram_freq=1)


# Create, compile, and train the model. Creation is via Functional API.

x = layers.Dense(128, activation='relu')(feature_layer_outputs)
x = layers.Dense(128, activation='relu')(x)
my_output = layers.Dense(1, activation='sigmoid')(x)
model = keras.Model(inputs=[v for v in feature_layer_inputs.values()],
                    outputs=my_output)

model.compile(optimizer='adam',
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])

model.fit(train_ds,
          validation_data=val_ds,
          epochs=5,
          callbacks=[tensorboard_callback])


# Evaluate the model

loss, accuracy = model.evaluate(test_ds)
print("Accuracy", accuracy)


# Output some plots, and get Tensorboard ready

tf.keras.utils.plot_model(
    model, to_file='model.png', show_shapes=False, show_layer_names=True,
    expand_nested=False, rankdir='TB')

%tensorboard --logdir logs/fit --host localhost --port=8008
print("Done - go to 'http://localhost:8080' in your browser")
import pandas as pd
import os

from argparse import ArgumentParser

parser = ArgumentParser()
parser.add_argument('--output', type=str, help='Path to clean output of ProphetNet.')
parser.add_argument('--index', type=str, help='Path to index of opinions, original data')
parser.add_argument('--parquet', type=str, help='Path to PARQUET folder')
args = parser.parse_args()

df = pd.DataFrame(zip(open(args.index), open(args.output)), columns=['opinion_id', 'summary'])
df['opinion_id'] = df['opinion_id'].apply(lambda x: int(x.strip()))
print(f'Number of summaries: {df.shape[0]}')
df.to_parquet(os.path.join(args.parquet, 'prophetnet.parq'))

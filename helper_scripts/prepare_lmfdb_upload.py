import pandas as pd
import logging
import ast
import csv

for handler in logging.root.handlers[:]:
    logging.root.removeHandler(handler)
logging.basicConfig(
    format="%(asctime)s %(levelname)s: %(message)s",
    datefmt="%H:%M:%S",
    filename="lmfdb_upload.log",
    level=logging.DEBUG,
)

logger = logging.getLogger(__name__)

RESULTS_PATH = "combined.csv"

OUTPUT_FILE = "g2c_nonmaximal_dec_2022.txt"
FILE_HEADER = "label|nonmax_primes|torsion_primes\n" "text|integer[]|integer[]\n\n"
COLS_FROM_DF = [
    "labels",
    "probably_nonmaximal_primes",
    "torsion_primes",
]

logger.info("Starting...")

with open(OUTPUT_FILE, "w") as output_file:
    output_file.write(FILE_HEADER)

df = pd.read_csv(RESULTS_PATH, usecols=COLS_FROM_DF)

# As a test
# df = df.head(10).copy()

df.rename(
    columns={"probably_nonmaximal_primes": "nonmax_primes"},
    inplace=True,
)

df["nonmax_primes"] = df["nonmax_primes"].apply(ast.literal_eval)
df["nonmax_primes"] = (
    "{" + df["nonmax_primes"].apply(lambda x: ",".join([str(t) for t in x])) + "}"
)


df["torsion_primes"] = df["torsion_primes"].apply(ast.literal_eval)
df["torsion_primes"] = (
    "{" + df["torsion_primes"].apply(lambda x: ",".join([str(t) for t in x])) + "}"
)

df.to_csv(
    OUTPUT_FILE, mode="a", header=False, sep="|", index=False, quoting=csv.QUOTE_NONE
)
print("Done")

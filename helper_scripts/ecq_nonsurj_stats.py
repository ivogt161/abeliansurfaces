"""ecq_nonsurj_stats.py

This script generates the analogous summary tables for elliptic curves over Q.

It arose from one of the referees asking "How do your results compare with ecQ?"

Running this script requires access to the LMFDB backend.

"""

from lmfdb import db
import pandas as pd
from collections import Counter
from itertools import chain

ecq = db.ec_curvedata
info = {}
test =ecq.search({'cm':int(0)}, projection=['lmfdb_label','modell_images', 'torsion_primes'], info=info)

output = list(test)
df = pd.DataFrame(output)

def foo(my_list):
    output = []

    for info in my_list:
        first_part = info.split('.')[0]
        first_letter_pos = first_part.find(next(filter(str.isalpha, first_part)))
        the_nonsurj_prime = int(first_part[:first_letter_pos])
        output.append(the_nonsurj_prime)

    return output

df['nonsurj_primes'] = df['modell_images'].apply(foo)
df["nonsurj_primes"] = df.nonsurj_primes.apply(set)

df["nontorsion_nonmaximal_primes"] = df["nonsurj_primes"] - df[
        "torsion_primes"
    ].apply(set)

torsion_prime_dist = (
    pd.Series(Counter(chain(*df.torsion_primes)))
    .sort_index()
    .rename_axis("prime")
    .reset_index(name="f")
)
nontorsion_nonmaximal_prime_dist = (
    pd.Series(Counter(chain(*df.nontorsion_nonmaximal_primes)))
    .sort_index()
    .rename_axis("prime")
    .reset_index(name="f")
)

df["number_of_nonmaximal_primes"] = df.nonsurj_primes.apply(len)
nonmaximal_prime_dist = (
    pd.Series(Counter(chain(*df.nonsurj_primes)))
    .sort_index()
    .rename_axis("prime")
    .reset_index(name="f")
)

print(f"nonsurj_primes_dist = {nonmaximal_prime_dist}\ntorsion_prime_dist = {torsion_prime_dist}\nnontorsion_nonmaximal_prime_dist = {nontorsion_nonmaximal_prime_dist}")
print(df["number_of_nonmaximal_primes"].value_counts())
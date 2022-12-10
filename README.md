# Computing nonsurjective primes in genus 2

This repository contains code for computing the list of nonsurjective primes associated to genus 2 curves, as described in the paper ``Computing nonsurjective primes in genus 2'' by Barinder S. Banwait, Armand Brumer, Hyun Jong Kim, Zev Klagsbrun, Jacob Mayle, Padmavathi Srinivasan, and Isabel Vogt.

## WARNING

The code in this repository assumes that the curve given is typical (i.e. jacobian has trivial geometric endomorphism ring). The code does not check for this! It is the users responsibility to check this for themselves.

If your curve is given in Weierstrass form, then one can use the following sage code to do this (change as appropriate):

```
R.<x> = QQ[]
f = x^5 + 17
C = HyperellipticCurve(f)
J = C.jacobian()
J.geometric_endomorphism_ring_is_ZZ()  # False
```

If your curve is not given in Weierstrass form, then the above will fail; users can e.g. use Magma to obtain a `SimplifiedModel`. 

## Executing the code on a single curve

Clone this repo to your computer. It is assumed you have [sage](https://sagemath.org/) installed. It is also assumed that you have [pandas](https://pandas.pydata.org/) installed in sage (which can be done with `pip install pandas` from the sage shell).

Users wishing to run the code on a single typical genus 2 curve of their choice should do the following:

1. Start `sage` and run `load("nonmaximal.sage")`.
2. Construct the defining polynomials of the genus 2 curve, either explicitly as polynomials:

```
R.<x> = QQ[]
f = x^5 + 23*x^4 - 48*x^3 + 85*x^2 - 69 * x + 45
h = x + 1
```

or as lists of coefficients; so the following is equivalent to the above:

```
f = [45, -69, 85, -48, 23, 1]
h = [1, 1]
```
3. (Optional) If you know the conductor of the curve, define that as a variable as well:

```
conductor_of_C = 47089
```

This helps the code run faster.

4. Run either `run_one_example(f,h,conductor_of_C)` or `run_one_example(f,h)` depending on whether or not `conductor_of_C` was defined in Step 3.

```
Possibly nonmaximal primes: {31: 'nss.2p2', 7: 'nss', 3: '1p3.2p2.cusp', 5: '1p3.2p2.cusp', 11: '1p3.2p2', 2: '?'}
Probably nonmaximal primes: [31, 2]
```

## Executing the code on lots of curves

To run this code on lots of curves, those curves first need to be collected into a file, which is expected to be in one of two formats:

1. **LMFDB format** - an example file can be found in `data/curve_data/lmfdb_input_example.csv`

2. **New format** - an example file can be found in `data/curve_data/new_input_example.csv`

You would then run, at the top level of the directory, e.g.

```
sage nonmaximal.py ./data/curve_data/lmfdb_input_example.csv  --scheme lmfdb --logfile lmfdb_2022_12_01.log
```

or 

```
sage nonmaximal.py ./data/curve_data/new_input_example.csv  --scheme new --logfile new_2022_12_01.log
```

depending on the format of the input data.

(Replace the path to the example data files with the path to your data file.)

An output file with the results will end up in the `output` directory.

### I need help getting my curves into one of these formats

#### LMFDB data

Let's suppose you query the LMFDB and download data directly from there. The data you download will look like what is in `data/curve_data/g2c_curves_list.sage`. To get this into the required format:

1. Run `sage ./data/curve_data/g2c_curves_list.sage` from the top level. this creates a python file with the labels and polys.
2. `mv ./data/curve_data/g2c_curves_list.sage.py ./data/curve_data/g2c_curves_list.py`. This just does a convenient rename.
3. Run `sage -python -m helper_scripts.split_data`. This should produce several files in `data/curve_data`, each containing `B` curves from the initial datafile. (This is useful for parallelisation. Currently `B` is 200.) Feel free to edit `split_data.py` to your purposes. 

#### `New' data

Let's suppose you have access to a huge datafile that doesn't have LMFDB labels in it (e.g. this one: https://math.mit.edu/~drew/st2e20.txt)

1. Save this file in `data/curve_data`.
2. From the top level, run `python3 helper_scripts/split_data_new.py`. This should produce LOADS OF files in `data/curve_data`, each containing `B` curves from the initial datafile. (This is useful for parallelisation. Currently `B` is 200.) Feel free to edit `split_data_new.py` to your purposes.

### I want to run in parallel

Get your datafiles into a folder (`data/curve_data` below), and then run

```
find ./data/curve_data -type f | parallel "sage nonmaximal.py {} --scheme new --logfile new_2022_12_04.log"
```

## Project layout
The directory layout is as follows

    .
    ├── data                # directory containing necessary data files
    │   └── curve_data      # directory containing necessary data files of curves
    ├── helper_scripts      # scripts helping with various things
    ├── output              # contains the csv file of the LMFDB run
    ├── results             # contains graphs resulting from data analysis
    ├── sage_submission     # copy of algorithm submitted to SageMath
    ├── skunkworks          # some fun experimental stuff :)
    └── tests               # modest testing directory
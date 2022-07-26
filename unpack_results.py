# importing csv module
import csv

# Poly ring
R = PolynomialRing(QQ, "x")
x = R.gen()

# csv file name
filename = "g2c_results.csv"

# initializing the titles and rows list
fields = []
rows = []

# reading csv file
with open(filename, "r") as csvfile:
    # creating a csv reader object
    csvreader = csv.reader(csvfile)

    # extracting field names through first row
    fields = next(csvreader)

    # extracting each data row one by one
    for row in csvreader:
        rows.append(row)

    # get total number of rows
    print("Total no. of rows: %d" % (csvreader.line_num))

# printing the field names
print("Field names are:" + ", ".join(field for field in fields))

# printing first 5 rows
print("\nFirst 5 rows are:\n")
for row in rows[:5]:
    # parsing each column of a row
    for col in row:
        print("%10s" % col, end=" "),
    print("\n")


def curve_from_record(rec):

    poly_str = rec[1]
    f, h = eval(poly_str)

    return HyperellipticCurve(R(f), R(h))


def curves_non_surj_at(p):
    """Get curves which are not surjective at given prime p"""

    assert p.is_prime(), "the input must be prime"
    output = []

    for rec in rows:
        prob_not_surj = eval(rec[3])  # list of primes
        if p in prob_not_surj:
            output.append(curve_from_record(rec))

    return output


# To get all curves not surj at 13, run the following

# not_surj_13 = curves_non_surj_at(13)

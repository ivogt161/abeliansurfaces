from tabulate import tabulate

def sub_list(l):
    if not l in [2,3,5,7]: raise Exception("l must be 2,3,5 or 7")
    S.<x> = PolynomialRing(Zmod(l))
    if l == 2:
        #CHAR2 is a list of characteristic polynomials of each maximal subgroup of GSp(4,2), except for the maximal subgroup that is isomorphic to A_6 (since that subgroup has all characteristic polynomials so must be dealt with differently)
        CHAR2 = [
            {
                x^4 + x^2 + 1,
                x^4 + 1
            },
            {
                x^4 + 1,
                x^4 + x^3 + x + 1
            },
            {
                x^4 + x^2 + 1,
                x^4 + 1,
                x^4 + x^3 + x + 1
            },
            {
                x^4 + 1,
                x^4 + x^3 + x^2 + x + 1,
                x^4 + x^3 + x + 1
            },
            {
                x^4 + x^2 + 1,
                x^4 + 1,
                x^4 + x^3 + x^2 + x + 1
            }
        ]
        return CHAR2
    if l == 3:
        #CHAR3 is a list of characteristic polynomials of each maximal subgroup of GSp(4,3)
        CHAR3 = [
            {
                x^4 + x^2 + 1,
                x^4 + 1,
                x^4 + x^3 + x + 1,
                x^4 + x^3 + 2*x^2 + 2*x + 1,
                x^4 + 2*x^3 + 2*x + 1,
                x^4 + 2*x^2 + 1,
                x^4 + 2*x^3 + 2*x^2 + x + 1
            },
            {
                x^4 + x^2 + 1,
                x^4 + 2*x^3 + x^2 + x + 1,
                x^4 + x^3 + 2*x^2 + x + 1,
                x^4 + 2*x^3 + 2*x^2 + 2*x + 1,
                x^4 + x^3 + x + 1,
                x^4 + 2*x^3 + 2*x + 1,
                x^4 + x^3 + x^2 + 2*x + 1
            },
            {
                x^4 + 2*x^3 + x^2 + 2*x + 1,
                x^4 + 1,
                x^4 + 2*x^3 + x + 1,
                x^4 + 2*x^3 + 2*x + 1,
                x^4 + x^3 + 2*x^2 + 2*x + 1,
                x^4 + x^3 + x^2 + x + 1,
                x^4 + 2*x^2 + 1,
                x^4 + 2*x^3 + 2*x^2 + x + 1,
                x^4 + x^3 + x + 1,
                x^4 + x^3 + 2*x + 1,
                x^4 + x^2 + 1
            },
            {
                x^4 + 1,
                x^4 + x^3 + 2*x^2 + x + 1,
                x^4 + 2*x^3 + 2*x + 1,
                x^4 + x^3 + 2*x^2 + 2*x + 1,
                x^4 + x^3 + x^2 + 2*x + 1,
                x^4 + 2*x^2 + 1,
                x^4 + x^3 + x + 1,
                x^4 + 2*x^3 + 2*x^2 + x + 1,
                x^4 + 2*x^3 + 2*x^2 + 2*x + 1,
                x^4 + x^2 + 1,
                x^4 + 2*x^3 + x^2 + x + 1
            },
            {
                x^4 + 2*x^3 + x^2 + 2*x + 1,
                x^4 + 1,
                x^4 + x^3 + 2*x^2 + x + 1,
                x^4 + 2*x^3 + 2*x + 1,
                x^4 + x^3 + 2*x^2 + 2*x + 1,
                x^4 + x^3 + x^2 + x + 1,
                x^4 + x^3 + x^2 + 2*x + 1,
                x^4 + 2*x^2 + 1,
                x^4 + x^3 + x + 1,
                x^4 + 2*x^3 + 2*x^2 + x + 1,
                x^4 + 2*x^3 + 2*x^2 + 2*x + 1,
                x^4 + x^2 + 1,
                x^4 + 2*x^3 + x^2 + x + 1
            },
            {
                x^4 + x^2 + 1,
                x^4 + x^3 + 2*x^2 + x + 1,
                x^4 + 1,
                x^4 + x^3 + x^2 + x + 1,
                x^4 + 2*x^3 + 2*x^2 + 2*x + 1,
                x^4 + x^3 + x + 1,
                x^4 + 2*x^3 + x^2 + 2*x + 1,
                x^4 + 2*x^3 + 2*x + 1,
                x^4 + 2*x^2 + 1
            }
        ]
        return CHAR3
    if l == 5:
        #CHAR5 is a list of characteristic polynomials of each maximal subgroup of GSp(4,3)
        CHAR5 = [
            {
                x^4 + 1,
                x^4 + 2*x^3 + 4*x^2 + 3*x + 1,
                x^4 + 2*x^3 + 3*x + 1,
                x^4 + x^3 + x + 1,
                x^4 + 4*x^3 + 4*x^2 + 3*x + 4,
                x^4 + 3*x^2 + 4,
                x^4 + x^2 + 4,
                x^4 + 3*x^3 + 4*x^2 + 2*x + 1,
                x^4 + 4*x^3 + 4*x + 1,
                x^4 + 3*x^3 + 2*x + 1,
                x^4 + 3*x^3 + x^2 + 4*x + 4,
                x^4 + 3*x^2 + 1,
                x^4 + 2*x^3 + x^2 + x + 4,
                x^4 + x^3 + x^2 + x + 1,
                x^4 + 4*x^3 + 2*x^2 + x + 1,
                x^4 + 2*x^3 + 3*x^2 + 2*x + 1,
                x^4 + 4*x^2 + 4,
                x^4 + x^3 + 4*x^2 + 2*x + 4,
                x^4 + 3*x^3 + 3*x^2 + 3*x + 1,
                x^4 + 2*x^2 + 4,
                x^4 + 4,
                x^4 + x^3 + 2*x^2 + 4*x + 1,
                x^4 + 4*x^3 + x^2 + 4*x + 1,
                x^4 + 2*x^2 + 1
            },
            {
                x^4 + 1,
                x^4 + 2*x^3 + 2*x^2 + x + 4,
                x^4 + 2*x^3 + 4*x^2 + 3*x + 1,
                x^4 + 2*x^3 + 2*x^2 + 3*x + 1,
                x^4 + 4*x^3 + 3*x^2 + x + 1,
                x^4 + x^3 + 3*x^2 + 3*x + 4,
                x^4 + 2*x^3 + 2*x^2 + 2*x + 1,
                x^4 + 3*x^3 + 2*x^2 + x + 4,
                x^4 + 3*x^2 + 4,
                x^4 + x^3 + 3*x^2 + 2*x + 4,
                x^4 + 3*x^3 + x + 4,
                x^4 + 3*x^3 + 2*x^2 + 3*x + 1,
                x^4 + x^2 + 4,
                x^4 + x^3 + 3*x^2 + 4*x + 1,
                x^4 + 3*x^3 + 4*x^2 + 2*x + 1,
                x^4 + 4*x^3 + 2*x + 4,
                x^4 + 3*x^3 + 2*x^2 + 2*x + 1,
                x^4 + 3*x^2 + 1,
                x^4 + x^2 + 1,
                x^4 + x^3 + 3*x^2 + x + 1,
                x^4 + x^3 + x^2 + x + 1,
                x^4 + 4*x^3 + 2*x^2 + x + 1,
                x^4 + 2*x^3 + 3*x^2 + 2*x + 1,
                x^4 + x^3 + 3*x + 4,
                x^4 + 4*x^3 + 3*x^2 + 3*x + 4,
                x^4 + 4*x^2 + 4,
                x^4 + 3*x^3 + 3*x^2 + 3*x + 1,
                x^4 + 2*x^2 + 4,
                x^4 + 2*x^3 + 2*x^2 + 4*x + 4,
                x^4 + 4,
                x^4 + 2*x^3 + 4*x + 4,
                x^4 + x^3 + 2*x^2 + 4*x + 1,
                x^4 + 4*x^3 + 3*x^2 + 2*x + 4,
                x^4 + 4*x^3 + 3*x^2 + 4*x + 1,
                x^4 + 4*x^3 + x^2 + 4*x + 1,
                x^4 + 3*x^3 + 2*x^2 + 4*x + 4,
                x^4 + 4*x^2 + 1,
                x^4 + 2*x^2 + 1
            },
            {
                x^4 + x^3 + 3*x^2 + 2*x + 4,
                x^4 + 4*x^3 + 3*x^2 + 3*x + 4,
                x^4 + x^3 + x^2 + x + 1,
                x^4 + x^3 + x + 1,
                x^4 + 4*x^2 + 1,
                x^4 + 3*x^2 + 1,
                x^4 + 4*x^3 + 3*x^2 + 4*x + 1,
                x^4 + 2*x^2 + 1,
                x^4 + x^2 + 1,
                x^4 + 2*x^3 + 4*x^2 + 3*x + 1,
                x^4 + 1,
                x^4 + 4*x^3 + x^2 + 4*x + 1,
                x^4 + 4*x^3 + 2*x^2 + x + 1,
                x^4 + 4*x^3 + 3*x^2 + 2*x + 4,
                x^4 + 4*x^3 + 4*x + 1,
                x^4 + 2*x^3 + 2*x^2 + 3*x + 1,
                x^4 + 4*x^3 + x^2 + x + 1,
                x^4 + 3*x^3 + 4*x^2 + 3*x + 1,
                x^4 + 2*x^3 + 2*x^2 + 4*x + 4,
                x^4 + 3*x^3 + 3*x^2 + 3*x + 1,
                x^4 + 4*x^3 + 2*x + 4,
                x^4 + 2*x^3 + 3*x + 1,
                x^4 + 2*x^3 + 2*x^2 + x + 4,
                x^4 + 2*x^3 + 4*x + 4,
                x^4 + 4*x^2 + 4,
                x^4 + 2*x^3 + x^2 + x + 4,
                x^4 + 3*x^3 + 2*x^2 + 4*x + 4,
                x^4 + 3*x^2 + 4,
                x^4 + 3*x^3 + x^2 + 4*x + 4,
                x^4 + x^3 + 3*x^2 + 3*x + 4,
                x^4 + 2*x^2 + 4,
                x^4 + 3*x^3 + 2*x^2 + x + 4,
                x^4 + 2*x^3 + 4*x^2 + 2*x + 1,
                x^4 + x^2 + 4,
                x^4 + 2*x^3 + 3*x^2 + 2*x + 1,
                x^4 + 4,
                x^4 + 3*x^3 + x + 4,
                x^4 + x^3 + 3*x + 4,
                x^4 + 3*x^3 + 4*x^2 + 2*x + 1,
                x^4 + 3*x^3 + 2*x^2 + 2*x + 1,
                x^4 + x^3 + 2*x^2 + 4*x + 1,
                x^4 + 4*x^3 + 4*x^2 + 3*x + 4,
                x^4 + x^3 + 4*x^2 + 2*x + 4,
                x^4 + x^3 + 3*x^2 + x + 1,
                x^4 + x^3 + x^2 + 4*x + 1,
                x^4 + 3*x^3 + 2*x + 1
            },
            {
                x^4 + 1,
                x^4 + 2*x^3 + 2*x^2 + x + 4,
                x^4 + 2*x^3 + 4*x^2 + 3*x + 1,
                x^4 + 4*x^3 + 3*x^2 + x + 1,
                x^4 + x^3 + 3*x^2 + 3*x + 4,
                x^4 + 2*x^3 + 2*x^2 + 2*x + 1,
                x^4 + x^3 + x^2 + 3*x + 4,
                x^4 + 3*x^3 + 4*x^2 + x + 4,
                x^4 + 3*x^3 + 2*x^2 + x + 4,
                x^4 + 3*x^2 + 4,
                x^4 + x^3 + 3*x^2 + 2*x + 4,
                x^4 + 3*x^3 + 2*x^2 + 3*x + 1,
                x^4 + x^2 + 4,
                x^4 + x^3 + 3*x^2 + 4*x + 1,
                x^4 + 3*x^3 + 4*x^2 + 2*x + 1,
                x^4 + 3*x^2 + 1,
                x^4 + x^2 + 1,
                x^4 + x^3 + x^2 + x + 1,
                x^4 + 4*x^3 + 2*x^2 + x + 1,
                x^4 + 2*x^3 + 3*x^2 + 2*x + 1,
                x^4 + 4*x^3 + 3*x^2 + 3*x + 4,
                x^4 + 4*x^2 + 4,
                x^4 + 2*x^3 + 4*x^2 + 4*x + 4,
                x^4 + 2*x^3 + 2*x^2 + 4*x + 4,
                x^4 + 2*x^2 + 4,
                x^4 + 3*x^3 + 3*x^2 + 3*x + 1,
                x^4 + 4,
                x^4 + x^3 + 2*x^2 + 4*x + 1,
                x^4 + 4*x^3 + 3*x^2 + 2*x + 4,
                x^4 + 4*x^3 + x^2 + 2*x + 4,
                x^4 + 4*x^3 + x^2 + 4*x + 1,
                x^4 + 3*x^3 + 2*x^2 + 4*x + 4,
                x^4 + 4*x^2 + 1,
                x^4 + 2*x^2 + 1
            },
            {
                x^4 + x^3 + 2*x + 4,
                x^4 + 4*x^3 + x^2 + 4*x + 1,
                x^4 + 4*x^3 + 3*x^2 + 4*x + 1,
                x^4 + 2*x^3 + x + 4,
                x^4 + x^3 + 3*x + 4,
                x^4 + x^3 + 2*x^2 + 3*x + 4,
                x^4 + 2*x^3 + 2*x^2 + x + 4,
                x^4 + 2*x^3 + 4*x^2 + x + 4,
                x^4 + 3*x^3 + x + 4,
                x^4 + 3*x^3 + 2*x^2 + x + 4,
                x^4 + 1,
                x^4 + 2*x^2 + 1,
                x^4 + 2*x^3 + 4*x + 4,
                x^4 + 4*x^2 + 1,
                x^4 + 2*x^3 + 2*x^2 + 4*x + 4,
                x^4 + 4*x^3 + 2*x + 4,
                x^4 + 3*x^3 + 4*x + 4,
                x^4 + 4*x^3 + 2*x^2 + 2*x + 4,
                x^4 + 3*x^3 + 2*x^2 + 4*x + 4,
                x^4 + 3*x^3 + 4*x^2 + 4*x + 4,
                x^4 + 4*x^3 + 3*x + 4,
                x^4 + x^3 + 4*x^2 + x + 1,
                x^4 + x^3 + 4*x + 1,
                x^4 + 2*x^3 + 2*x + 1,
                x^4 + x^3 + 2*x^2 + 4*x + 1,
                x^4 + x^3 + 4*x^2 + 4*x + 1,
                x^4 + 2*x^3 + 2*x^2 + 3*x + 1,
                x^4 + 2*x^3 + 4*x^2 + 3*x + 1,
                x^4 + x^2 + 4,
                x^4 + 3*x^3 + 2*x^2 + 2*x + 1,
                x^4 + 3*x^2 + 4,
                x^4 + 3*x^3 + 4*x^2 + 2*x + 1,
                x^4 + 4*x^3 + x + 1,
                x^4 + 3*x^3 + 3*x + 1,
                x^4 + 4*x^3 + 2*x^2 + x + 1,
                x^4 + 4*x^3 + 4*x^2 + x + 1,
                x^4 + x^3 + x^2 + 2*x + 4,
                x^4 + 4*x^3 + 4*x^2 + 4*x + 1,
                x^4 + x^3 + 3*x^2 + 2*x + 4,
                x^4 + x^3 + 3*x^2 + 3*x + 4,
                x^4 + 3*x^3 + 3*x^2 + x + 4,
                x^4 + x^2 + 1,
                x^4 + 3*x^2 + 1,
                x^4 + 2*x^3 + 3*x^2 + 4*x + 4,
                x^4 + 4*x^3 + 3*x^2 + 2*x + 4,
                x^4 + x^3 + x^2 + x + 1,
                x^4 + 4*x^3 + x^2 + 3*x + 4,
                x^4 + x^3 + 3*x^2 + x + 1,
                x^4 + 4*x^3 + 3*x^2 + 3*x + 4,
                x^4 + 2*x^3 + x^2 + 2*x + 1,
                x^4 + 2*x^3 + 3*x^2 + 2*x + 1,
                x^4 + 2*x^3 + x^2 + 3*x + 1,
                x^4 + 4,
                x^4 + 3*x^3 + x^2 + 2*x + 1,
                x^4 + 2*x^2 + 4,
                x^4 + 4*x^2 + 4,
                x^4 + 3*x^3 + x^2 + 3*x + 1,
                x^4 + 3*x^3 + 3*x^2 + 3*x + 1
            },
            {
                x^4 + 2*x^3 + 2*x^2 + x + 4,
                x^4 + 2*x^3 + 4*x^2 + 3*x + 1,
                x^4 + x^3 + 2*x^2 + x + 1,
                x^4 + 2*x^3 + 3*x + 1,
                x^4 + x^3 + x + 1,
                x^4 + 4*x^3 + 3*x^2 + x + 1,
                x^4 + 2*x^3 + 4*x^2 + 2*x + 1,
                x^4 + 4*x^3 + x^2 + x + 1,
                x^4 + 2*x^3 + 2*x^2 + 2*x + 1,
                x^4 + x^3 + x^2 + 3*x + 4,
                x^4 + 3*x^3 + 4*x^2 + x + 4,
                x^4 + 4*x^3 + 2*x^2 + 3*x + 4,
                x^4 + x^3 + 3*x^2 + 2*x + 4,
                x^4 + 3*x^3 + 4*x^2 + 3*x + 1,
                x^4 + 3*x^3 + 2*x^2 + 3*x + 1,
                x^4 + 2*x^3 + x^2 + 4*x + 4,
                x^4 + x^3 + 3*x^2 + 4*x + 1,
                x^4 + 4*x^3 + 4*x^2 + 2*x + 4,
                x^4 + x^3 + x^2 + 4*x + 1,
                x^4 + 3*x^3 + 4*x^2 + 2*x + 1,
                x^4 + 4*x^3 + 2*x^2 + 4*x + 1,
                x^4 + 3*x^3 + 2*x + 1,
                x^4 + 4*x^3 + 4*x + 1,
                x^4 + 3*x^3 + 3*x^2 + 4*x + 4,
                x^4 + 3*x^2 + 1,
                x^4 + 2*x^3 + 3*x^2 + x + 4,
                x^4 + 2*x^3 + 3*x^2 + 3*x + 1,
                x^4 + x^3 + x^2 + x + 1,
                x^4 + x^3 + 4*x^2 + 3*x + 4,
                x^4 + 4*x^3 + 3*x^2 + 3*x + 4,
                x^4 + 2*x^3 + 4*x^2 + 4*x + 4,
                x^4 + 3*x^3 + x^2 + x + 4,
                x^4 + x^3 + 2*x^2 + 2*x + 4,
                x^4 + 4,
                x^4 + 4*x^3 + x^2 + 2*x + 4,
                x^4 + 3*x^3 + 3*x^2 + 2*x + 1,
                x^4 + 4*x^3 + x^2 + 4*x + 1,
                x^4 + 3*x^3 + 2*x^2 + 4*x + 4,
                x^4 + 2*x^2 + 1
            },
            {
                x^4 + 1,
                x^4 + 2*x^3 + 2*x^2 + x + 4,
                x^4 + 2*x^3 + 4*x^2 + 3*x + 1,
                x^4 + 2*x^3 + 2*x^2 + 3*x + 1,
                x^4 + 4*x^3 + 3*x^2 + x + 1,
                x^4 + x^3 + 3*x^2 + 3*x + 4,
                x^4 + 2*x^3 + 2*x^2 + 2*x + 1,
                x^4 + 3*x^3 + 2*x^2 + x + 4,
                x^4 + 3*x^2 + 4,
                x^4 + x^3 + 3*x^2 + 2*x + 4,
                x^4 + 3*x^3 + x + 4,
                x^4 + 3*x^3 + 2*x^2 + 3*x + 1,
                x^4 + x^2 + 4,
                x^4 + x^3 + 3*x^2 + 4*x + 1,
                x^4 + 3*x^3 + 4*x^2 + 2*x + 1,
                x^4 + 4*x^3 + 2*x + 4,
                x^4 + 3*x^3 + 2*x^2 + 2*x + 1,
                x^4 + 3*x^2 + 1,
                x^4 + x^2 + 1,
                x^4 + x^3 + 3*x^2 + x + 1,
                x^4 + x^3 + x^2 + x + 1,
                x^4 + 4*x^3 + 2*x^2 + x + 1,
                x^4 + 2*x^3 + 3*x^2 + 2*x + 1,
                x^4 + x^3 + 3*x + 4,
                x^4 + 4*x^3 + 3*x^2 + 3*x + 4,
                x^4 + 4*x^2 + 4,
                x^4 + 3*x^3 + 3*x^2 + 3*x + 1,
                x^4 + 2*x^2 + 4,
                x^4 + 2*x^3 + 2*x^2 + 4*x + 4,
                x^4 + 4,
                x^4 + 2*x^3 + 4*x + 4,
                x^4 + x^3 + 2*x^2 + 4*x + 1,
                x^4 + 4*x^3 + 3*x^2 + 2*x + 4,
                x^4 + 4*x^3 + 3*x^2 + 4*x + 1,
                x^4 + 4*x^3 + x^2 + 4*x + 1,
                x^4 + 3*x^3 + 2*x^2 + 4*x + 4,
                x^4 + 4*x^2 + 1,
                x^4 + 2*x^2 + 1
            },
            {
                x^4 + 4*x^3 + x^2 + 4*x + 1,
                x^4 + x^3 + 2*x^2 + 2*x + 4,
                x^4 + x^3 + 4*x^2 + 2*x + 4,
                x^4 + x^3 + 3*x + 4,
                x^4 + 2*x^3 + 2*x^2 + x + 4,
                x^4 + x^3 + 4*x^2 + 3*x + 4,
                x^4 + 3*x^3 + x + 4,
                x^4 + 3*x^3 + 4*x^2 + x + 4,
                x^4 + 1,
                x^4 + 2*x^2 + 1,
                x^4 + 2*x^3 + 4*x + 4,
                x^4 + 4*x^2 + 1,
                x^4 + 2*x^3 + 4*x^2 + 4*x + 4,
                x^4 + 4*x^3 + 2*x + 4,
                x^4 + 3*x^3 + 2*x^2 + 4*x + 4,
                x^4 + 4*x^3 + 4*x^2 + 2*x + 4,
                x^4 + x^3 + x + 1,
                x^4 + x^3 + 2*x^2 + x + 1,
                x^4 + 4*x^3 + 2*x^2 + 3*x + 4,
                x^4 + 4*x^3 + 4*x^2 + 3*x + 4,
                x^4 + 2*x^3 + 2*x^2 + 2*x + 1,
                x^4 + x^3 + 2*x^2 + 4*x + 1,
                x^4 + 2*x^3 + 4*x^2 + 2*x + 1,
                x^4 + 2*x^3 + 3*x + 1,
                x^4 + 2*x^3 + 4*x^2 + 3*x + 1,
                x^4 + 3*x^3 + 2*x + 1,
                x^4 + x^2 + 4,
                x^4 + 3*x^2 + 4,
                x^4 + 3*x^3 + 4*x^2 + 2*x + 1,
                x^4 + 4*x^3 + 2*x^2 + x + 1,
                x^4 + 3*x^3 + 2*x^2 + 3*x + 1,
                x^4 + 3*x^3 + 4*x^2 + 3*x + 1,
                x^4 + 4*x^3 + 4*x + 1,
                x^4 + 4*x^3 + 2*x^2 + 4*x + 1,
                x^4 + x^3 + 3*x^2 + 2*x + 4,
                x^4 + 2*x^3 + x^2 + x + 4,
                x^4 + x^3 + x^2 + 3*x + 4,
                x^4 + 2*x^3 + 3*x^2 + x + 4,
                x^4 + 3*x^3 + x^2 + x + 4,
                x^4 + x^2 + 1,
                x^4 + 3*x^2 + 1,
                x^4 + 2*x^3 + x^2 + 4*x + 4,
                x^4 + 4*x^3 + x^2 + 2*x + 4,
                x^4 + 3*x^3 + x^2 + 4*x + 4,
                x^4 + 3*x^3 + 3*x^2 + 4*x + 4,
                x^4 + x^3 + x^2 + x + 1,
                x^4 + 4*x^3 + 3*x^2 + 3*x + 4,
                x^4 + x^3 + x^2 + 4*x + 1,
                x^4 + 2*x^3 + 3*x^2 + 2*x + 1,
                x^4 + x^3 + 3*x^2 + 4*x + 1,
                x^4 + 2*x^3 + 3*x^2 + 3*x + 1,
                x^4 + 4,
                x^4 + 2*x^2 + 4,
                x^4 + 3*x^3 + 3*x^2 + 2*x + 1,
                x^4 + 4*x^2 + 4,
                x^4 + 4*x^3 + x^2 + x + 1,
                x^4 + 4*x^3 + 3*x^2 + x + 1,
                x^4 + 3*x^3 + 3*x^2 + 3*x + 1
            },
            {
                x^4 + x^3 + 2*x^2 + x + 1,
                x^4 + x^3 + 4*x + 1,
                x^4 + x^3 + x^2 + x + 1,
                x^4 + x^3 + x + 1,
                x^4 + 4*x^2 + 1,
                x^4 + 4*x^3 + 4*x^2 + 4*x + 1,
                x^4 + 3*x^2 + 1,
                x^4 + 4*x^3 + 3*x^2 + 4*x + 1,
                x^4 + 2*x^2 + 1,
                x^4 + 4*x^3 + 4*x^2 + x + 1,
                x^4 + 4*x^3 + 2*x^2 + 4*x + 1,
                x^4 + x^2 + 1,
                x^4 + 2*x^3 + 4*x^2 + 3*x + 1,
                x^4 + 4*x^3 + 3*x^2 + x + 1,
                x^4 + 1,
                x^4 + 4*x^3 + x^2 + 4*x + 1,
                x^4 + 2*x^3 + 3*x^2 + 3*x + 1,
                x^4 + 4*x^3 + 2*x^2 + x + 1,
                x^4 + 4*x^3 + 4*x + 1,
                x^4 + 2*x^3 + 2*x^2 + 3*x + 1,
                x^4 + 4*x^3 + x^2 + x + 1,
                x^4 + 3*x^3 + 4*x^2 + 3*x + 1,
                x^4 + 2*x^3 + x^2 + 3*x + 1,
                x^4 + 4*x^3 + x + 1,
                x^4 + 3*x^3 + 3*x^2 + 3*x + 1,
                x^4 + 2*x^3 + 3*x + 1,
                x^4 + 3*x^3 + 2*x^2 + 3*x + 1,
                x^4 + 3*x^3 + x^2 + 3*x + 1,
                x^4 + 3*x^3 + 3*x + 1,
                x^4 + 2*x^3 + 4*x^2 + 2*x + 1,
                x^4 + 2*x^3 + 3*x^2 + 2*x + 1,
                x^4 + 2*x^3 + 2*x^2 + 2*x + 1,
                x^4 + 3*x^3 + 4*x^2 + 2*x + 1,
                x^4 + 2*x^3 + x^2 + 2*x + 1,
                x^4 + x^3 + 4*x^2 + 4*x + 1,
                x^4 + 3*x^3 + 3*x^2 + 2*x + 1,
                x^4 + 2*x^3 + 2*x + 1,
                x^4 + x^3 + 3*x^2 + 4*x + 1,
                x^4 + 3*x^3 + 2*x^2 + 2*x + 1,
                x^4 + x^3 + 4*x^2 + x + 1,
                x^4 + 3*x^3 + x^2 + 2*x + 1,
                x^4 + x^3 + 2*x^2 + 4*x + 1,
                x^4 + x^3 + 3*x^2 + x + 1,
                x^4 + x^3 + x^2 + 4*x + 1,
                x^4 + 3*x^3 + 2*x + 1
            }
        ]
        return CHAR5
    if l==7:
        #CHAR7 contains the characteristic polynomials for the only exeptional maximal subgroup of GSp(4,7)
        CHAR7 = [
        {
            x^4 + 2*x^3 + 5*x^2 + 5*x + 1,
            x^4 + 5*x^3 + 5*x^2 + 2*x + 1,
            x^4 + x^3 + 6*x^2 + 2*x + 4,
            x^4 + x^3 + 3*x^2 + 4*x + 2,
            x^4 + 5*x^3 + 3*x^2 + 5*x + 1,
            x^4 + 1,
            x^4 + 2*x^2 + 1,
            x^4 + 6*x^2 + 1,
            x^4 + 4*x^3 + x + 4,
            x^4 + 4*x^3 + 2*x^2 + x + 4,
            x^4 + 6*x^3 + x^2 + 6*x + 1,
            x^4 + 4*x^3 + 5*x^2 + 2*x + 2,
            x^4 + x^3 + x + 1,
            x^4 + 3*x^3 + 5*x^2 + 5*x + 2,
            x^4 + 3*x^3 + 6*x + 4,
            x^4 + 3*x^3 + 2*x^2 + 6*x + 4,
            x^4 + 6*x^3 + 3*x^2 + 3*x + 2,
            x^4 + 2,
            x^4 + x^3 + 4*x^2 + 6*x + 1,
            x^4 + 3*x^2 + 4,
            x^4 + 6*x^2 + 2,
            x^4 + 5*x^2 + 4,
            x^4 + 3*x^3 + 6*x^2 + 3*x + 1,
            x^4 + 6*x^3 + 6*x^2 + 5*x + 4,
            x^4 + 3*x^3 + 4*x^2 + 4*x + 1,
            x^4 + 4*x^3 + 4*x^2 + 3*x + 1,
            x^4 + 4*x^3 + 6*x^2 + 4*x + 1,
            x^4 + 2*x^3 + x + 2,
            x^4 + x^3 + 2*x^2 + 3*x + 2,
            x^4 + 2*x^3 + 4*x^2 + x + 2,
            x^4 + 6*x^3 + 4*x^2 + x + 1,
            x^4 + 3*x^3 + x^2 + x + 4,
            x^4 + 2*x^3 + x^2 + 3*x + 4,
            x^4 + x^3 + 3*x^2 + 5*x + 4,
            x^4 + 5*x^2 + 1,
            x^4 + 2*x^3 + 5*x^2 + 4*x + 4,
            x^4 + 3*x^3 + 6*x^2 + 2*x + 2,
            x^4 + 6*x^3 + 6*x + 1,
            x^4 + 2*x^3 + 2*x^2 + 6*x + 2,
            x^4 + x^3 + x^2 + x + 1,
            x^4 + 5*x^3 + 2*x^2 + x + 2,
            x^4 + 5*x^3 + 5*x^2 + 3*x + 4,
            x^4 + 4*x^3 + 6*x^2 + 5*x + 2,
            x^4 + 4*x^3 + x^2 + 6*x + 4,
            x^4 + 5*x^3 + x^2 + 4*x + 4,
            x^4 + 2*x^3 + 3*x^2 + 2*x + 1,
            x^4 + 6*x^3 + 3*x^2 + 2*x + 4,
            x^4 + x^2 + 2,
            x^4 + 4,
            x^4 + 5*x^3 + 6*x + 2,
            x^4 + 3*x^2 + 2,
            x^4 + 6*x^3 + 2*x^2 + 4*x + 2,
            x^4 + 4*x^2 + 4,
            x^4 + 5*x^3 + 4*x^2 + 6*x + 2
        }
        ]
        return CHAR7

from tabulate import tabulate

def index(l):
    if l == 2: return 0
    if l == 3: return 1
    if l == 5: return 2
    if l == 7: return 3

def inA6at2(H):
    Q,P = H.hyperelliptic_polynomials()
    curve = genus2reduction(P,Q)
    disc = curve.minimal_disc
    if disc.is_square(): return True
    return False

def poor_mans_conductor(C):
    f,h = C.hyperelliptic_polynomials()
    red_data = genus2reduction(h,f)
    N = red_data.conductor
    if red_data.prime_to_2_conductor_only:
        N = 2*N
    return N

def non_exp_red(fmod,p):
    if fmod.is_irreducible(): return p
    return 0

def maximal_quadratic_conductor(N): #stolen
    if N % 2 == 0:
        return 4*radical(N)
    else:
        return radical(N)

def chars(C): #stolen
    c = maximal_quadratic_conductor(C)
    D = DirichletGroup(c,base_ring=QQ,zeta_order=2)
    return [phi for phi in D if phi.conductor() != 1]


def non_exp_ired(fmod,C,p):
    for chi in chars(C):
        if chi(p) == -1 and -fmod[fmod.degree()-1] == 0:
            return 0
    return p

# Returns True if known surjective, False if unable to determine surjective
def is_surj_small(H):
    C = poor_mans_conductor(H)
    CHAR = [sub_list(2), sub_list(3), sub_list(5), sub_list(7)]
    witnesses = [[0]*len(CHAR[index(2)]), [0]*len(CHAR[index(3)]), [0]*len(CHAR[index(5)]), [0]*3]
    if inA6at2(H) == True: witnesses[index(2)] = [-1]*len(CHAR[index(2)])
    for p in primes(2,1000): #Fix upper bound later
        if (2*C) % p != 0:
            Hp = H.change_ring(GF(p))
            f = Hp.frobenius_polynomial()
            for l in [2,3,5,7]:
                for i in range(0,len(witnesses[index(l)])):
                    if p != l and witnesses[index(l)][i] == 0:
                        fmod = f.change_ring(Zmod(l))
                        if l <= 5 or i == 0:
                            if not fmod in CHAR[index(l)][i]: witnesses[index(l)][i] = p
                        else:
                            if i == 1: witnesses[index(l)][i] = non_exp_red(fmod,p)
                            if i == 2: witnesses[index(l)][i] = non_exp_ired(fmod,C,p)
        if not (0 in witnesses[index(2)] or 0 in witnesses[index(3)] or 0 in witnesses[index(5)] or 0 in witnesses[index(7)]):
            break
    return [witnesses[index(2)], witnesses[index(3)], witnesses[index(5)], witnesses[index(7)]]


# witnesses for l=2,3,5 indicate which maximal subgroup is ruled out (in the case of 2, witnesses of all -1 indicate that the discriminant is a square, so the image is contained in A_6). For l=7, the 0th witness rules out the single exceptional group, the 1st witness rules out reducible subs, and 2nd witness rules out irreducible subs
def results(H):
    conclusions= [""]*4
    witnesses = is_surj_small(H)
    for l in [2,3,5,7]:
        if -1 in witnesses[index(l)] or 0 in witnesses[index(l)]:
            conclusions[index(l)] = "Not surjective at", l
        else:
            conclusions[index(l)] = "Surjective at", l
    resultstable = [(conclusions[i], witnesses[i]) for i in range(0, 4)]
    print(tabulate(resultstable, headers=["conclusions", "witnesses for each maximal/exceptional subgroup"]))
    print ""

R.<x> = PolynomialRing(ZZ)

#CM curve
H = HyperellipticCurve(R([1, 0, 0, 0, 0, 0, 1])); H
results(H)

#?
H = HyperellipticCurve(R([1, -2, -1, 4, 3, 2, 1])); H
results(H)

#conductor 249
H = HyperellipticCurve(R([1, 4, 4, 2, 0, 0, 1])); H
results(H)

#Drew first curve on zulip
H = HyperellipticCurve( -x^6+6*x^5+3*x^4+5*x^3+23*x^2-3*x+5,x); H
results(H)

#Drew second curve on zulip
H=HyperellipticCurve(3*x^5+9*x^4+14*x^3+39*x^2+16,x^3); H
results(H)

#Curve from Calegari table
H=HyperellipticCurve(7*x^6-22*x^5-7*x^4 + 61*x^3 -3*x^2-54*x-12,x);H
results(H)

#Random curve from LMFDB
H = HyperellipticCurve(R([0, 1, 16, 72, 33, 4]), R([0, 1]))
results(H)
︡8a409629-8550-4ed2-a0c2-6541bace920f︡{"stdout":"Hyperelliptic Curve over Integer Ring defined by y^2 = x^6 + 1
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [-1, -1, -1, -1, -1]
('Not surjective at', 3)  [0, 0, 0, 0, 0, 0]
('Not surjective at', 5)  [7, 0, 0, 7, 0, 7, 0, 0, 7]
('Not surjective at', 7)  [13, 0, 13]

Hyperelliptic Curve over Integer Ring defined by y^2 = x^6 + 2*x^5 + 3*x^4 + 4*x^3 - x^2 - 2*x + 1
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 3, 3, 0, 5]
('Not surjective at', 3)  [5, 0, 5, 0, 0, 5]
('Not surjective at', 5)  [3, 3, 3, 11, 3, 0, 3, 0, 3]
('Surjective at', 7)      [3, 11, 3]

Hyperelliptic Curve over Integer Ring defined by y^2 = x^6 + 2*x^3 + 4*x^2 + 4*x + 1
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [7, 0, 0, 0, 7]
('Surjective at', 3)      [7, 5, 17, 7, 131, 11]
('Surjective at', 5)      [7, 11, 11, 11, 11, 13, 11, 29, 7]
('Not surjective at', 7)  [5, 0, 11]

Hyperelliptic Curve over Integer Ring defined by y^2 + x*y = -x^6 + 6*x^5 + 3*x^4 + 5*x^3 + 23*x^2 - 3*x + 5
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Surjective at', 2)      [5, 5, 5, 37, 7]
('Surjective at', 3)      [5, 5, 41, 5, 5, 5]
('Not surjective at', 5)  [11, 29, 29, 29, 0, 7, 29, 23, 7]
('Surjective at', 7)      [5, 13, 5]

Hyperelliptic Curve over Integer Ring defined by y^2 + x^3*y = 3*x^5 + 9*x^4 + 14*x^3 + 39*x^2 + 16
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [11, 11, 11, 0, 17]
('Surjective at', 3)      [17, 11, 17, 29, 29, 11]
('Not surjective at', 5)  [17, 23, 0, 17, 23, 7, 23, 19, 7]
('Surjective at', 7)      [11, 29, 11]

Hyperelliptic Curve over Integer Ring defined by y^2 + x*y = 7*x^6 - 22*x^5 - 7*x^4 + 61*x^3 - 3*x^2 - 54*x - 12
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [13, 0, 0, 0, 13]
('Surjective at', 3)      [17, 5, 41, 17, 17, 17]
('Not surjective at', 5)  [17, 17, 17, 17, 17, 11, 17, 0, 13]
('Surjective at', 7)      [5, 17, 13]

conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 0, 0, 0, 3]
('Surjective at', 3)      [5, 5, 37, 5, 5, 5]
('Surjective at', 5)      [3, 3, 3, 3, 19, 3, 3, 3, 3]
('Surjective at', 7)      [5, 3, 3]


# Genus 2 curves downloaded from the LMFDB on 04 June 2020.
# Query "{'geom_end_alg': u'Q', 'cond': {'$lte': 1000, '$gte': 1}}" returned 82 curves.

# Below are two lists, one called labels, and one called data (in matching order).
# Each entry in the data list has the form:
#    [[f coeffs],[h coeffs]]
# defining the hyperelliptic curve y^2+h(x)y=f(x).
#
# To create a list of curves, type "curves = make_data()"

labels  =  [\
"249.a.249.1",
"249.a.6723.1",
"277.a.277.1",
"277.a.277.2",
"295.a.295.1",
"295.a.295.2",
"349.a.349.1",
"353.a.353.1",
"388.a.776.1",
"389.a.389.1",
"389.a.389.2",
"394.a.394.1",
"394.a.3152.1",
"427.a.2989.1",
"461.a.461.1",
"461.a.461.2",
"464.a.464.1",
"464.a.29696.1",
"464.a.29696.2",
"472.a.944.1",
"472.a.60416.1",
"523.a.523.1",
"523.a.523.2",
"555.a.8325.1",
"574.a.293888.1",
"587.a.587.1",
"597.a.597.1",
"603.a.603.1",
"603.a.603.2",
"604.a.9664.1",
"604.a.9664.2",
"644.b.14812.1",
"688.a.2752.1",
"688.a.704512.2",
"688.a.704512.1",
"691.a.691.1",
"704.a.45056.1",
"708.a.2832.1",
"708.a.19116.1",
"708.a.181248.1",
"709.a.709.1",
"713.a.713.1",
"713.b.713.1",
"731.a.12427.1",
"741.a.28899.1",
"743.a.743.1",
"745.a.745.1",
"762.a.3048.1",
"762.a.82296.1",
"763.a.763.1",
"768.a.1536.1",
"768.a.4608.1",
"797.a.797.1",
"807.a.2421.1",
"816.a.13872.1",
"816.a.39168.1",
"826.a.11564.1",
"830.a.6640.1",
"830.a.830000.1",
"832.a.832.1",
"834.a.1668.1",
"847.c.9317.1",
"856.a.1712.1",
"862.a.862.1",
"862.a.6896.1",
"862.b.862.1",
"886.a.3544.1",
"893.a.893.1",
"909.a.909.1",
"909.a.8181.1",
"925.a.925.1",
"925.a.23125.1",
"932.a.3728.1",
"953.a.953.1",
"966.a.834624.1",
"970.a.1940.1",
"971.a.971.1",
"975.a.63375.1",
"976.a.999424.1",
"997.a.997.1",
"997.a.997.2",
"997.b.997.1"]


data  =  [\
[[0, 1, 1], [1, 0, 0, 1]],
[[2, 3, 1, 1, 0, -1], [1, 0, 0, 1]],
[[0, -1, -1], [1, 1, 1, 1]],
[[-6, 11, -19, 14, -9, 1], [1]],
[[0, 0, -1], [1, 0, 0, 1]],
[[-608, 389, 22, -40, 0, 1], [1, 1, 1]],
[[0, 0, -1, -1], [1, 1, 1, 1]],
[[0, 0, 1], [1, 1, 0, 1]],
[[0, 1, 2, 0, -1], [1, 1, 0, 1]],
[[7, 16, 0, -8, -2, 1], [0, 1, 0, 1]],
[[0, 0, 1, 2, 2, 1], [1, 1]],
[[-9, 17, 0, -12, 1, 2], [0, 1, 0, 1]],
[[0, 0, 0, 0, 0, -1], [1, 1]],
[[-4, 4, 4, -5, -1, 1], [1, 0, 0, 1]],
[[-2, 3, 0, -3, 0, 1], [0, 0, 0, 1]],
[[-306, 272, 10, -39, -1, 1], [1]],
[[0, 0, 0, -1, -2, -2, -1], [1, 1]],
[[0, 0, -2, -4, 3, 8], [1, 1]],
[[0, 1, 16, 72, 33, 4], [0, 1]],
[[0, 1, 0, -2, -1, 1], [1, 0, 1]],
[[0, 0, 2, 4, 5, 8], [1, 1]],
[[0, 0, 0, -1, -1, 1], [1, 1]],
[[0, -1, 21, -110, -31, 1], [0, 1]],
[[0, 1, 1, -4, -2, 3], [1, 1]],
[[1, 1, -3, 0, -1, 1], [0, 1, 1]],
[[0, -1, -1], [1, 1, 0, 1]],
[[0, 1, 2, 3, 2, 1], [1]],
[[0, 2, 4, 4, 8, 1], [1, 0, 1]],
[[0, 1, 0, -1, 0, 1], [1, 0, 1]],
[[-21, -53, -4, 48, 9, 4], [1, 1, 1]],
[[0, -1, 1, 1, -1], [1, 0, 0, 1]],
[[-1, -1, 5, -4, -1, 1], [1, 0, 0, 1]],
[[0, -1, 0, 4, -5, 2], [1]],
[[1, 4, 2, -8, -7, 2], []],
[[1, 2, 1, 4, 0, 2], []],
[[0, 0, -1, -1, 0, 1], [1, 1]],
[[0, 0, -2, -1, 4, 4], [1]],
[[0, 0, 0, 0, 0, 1], [1, 1, 1]],
[[-1, 4, 4, 0, 0, -1], [1, 0, 0, 1]],
[[-36, -98, -41, 48, 9, -4, -1], [1, 0, 0, 1]],
[[0, 1, -2, 0, 0, 1], [0, 1]],
[[0, -1, 0, 0, 0, -1], [1, 1, 0, 1]],
[[0, 0, 0, 0, -1], [1, 1, 0, 1]],
[[-3, -1, 0, 0, 2, 1], [0, 0, 1, 1]],
[[0, 1, 2, 0, -1, -3], [1, 1]],
[[0, 0, 1, 0, -1], [1, 1, 0, 1]],
[[0, -1], [1, 1, 0, 1]],
[[1, 1, 1], [0, 1, 1, 1]],
[[0, -1, 2, 14, -8, 1], [0, 1, 1]],
[[0, -1, 2, 0, -2], [0, 1, 0, 1]],
[[0, 1, 0, -3, -1, 2], [1]],
[[-1, -1, -1, -1], [1, 1, 1, 1]],
[[0, 0, 0, 1, -1, 1], [1]],
[[-1, 2, -1, -2, 0, 1], [0, 1, 0, 1]],
[[3, -8, 6, 0, -2], [0, 0, 1, 1]],
[[0, 1, -1, -4, 0, 3], [1, 0, 1]],
[[3, -4, -4, 3, 1, 1], [0, 1, 1]],
[[1, 1, -2, 0, 1, -1], [1, 0, 0, 1]],
[[0, 1, 8, 16, -2, 1], [0, 1, 1]],
[[-1, 2, 1, -1, 0, 1], [0, 1, 0, 1]],
[[-1, 1, -1], [1, 0, 0, 1]],
[[-2, -1, 0, 1, 1], [0, 0, 1, 1]],
[[0, 1, 0, -1, -1], [0, 1, 0, 1]],
[[5, 2, 7, -7, -2, 1], [1, 0, 0, 1]],
[[0, -1, -3, 0, 6, 4], [0, 1, 1]],
[[-1, -1, 3, 0, -2], [0, 1, 0, 1]],
[[1, -1, 0, 0, -1], [0, 1, 0, 1]],
[[0, 0, -1, 0, -1], [1, 1, 0, 1]],
[[0, -1, 1, 0, -1], [0, 1, 0, 1]],
[[0, -3, 6, 1, -7, 3], [0, 1]],
[[0, 0, -1, -1, 2, -1], [1, 1]],
[[0, -5, 18, -19, 1, 5], [0, 1]],
[[0, -1, 1, 0, 1, -2, 1], [1]],
[[0, 0, 1, 1], [1, 1, 0, 1]],
[[1, -1, 1, 1, -1, 1], [0, 1, 1]],
[[0, 0, 1, 1, 1, 1], [1, 1]],
[[0, 1, 0, -2, 0, 1], [1]],
[[-1, 1, 2, 1, 0, -1], [1, 0, 0, 1]],
[[0, 0, -1, 2, 0, -2, 1], [1, 1]],
[[0, -1, 0, 16, -8, 1], [0, 1]],
[[0, 0, 0, 0, 1, 1], [1, 1]],
[[0, 0, -1, 2, -2, 1], [1]]]


def make_data():
    R.<x>=PolynomialRing(QQ)
    return [HyperellipticCurve(R(r[0]),R(r[1])) for r in data]

curvelist = make_data()
for i in range(0,len(curvelist)):
    H = curvelist[i]
    print labels[i], H
    results(H)

︡67e7e80f-1f5a-4c65-a0bd-3d47a6f96df5︡{"stdout":"249.a.249.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + 1)*y = x^2 + x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [7, 0, 0, 0, 7]
('Surjective at', 3)      [7, 5, 17, 7, 131, 11]
('Surjective at', 5)      [7, 11, 11, 11, 11, 13, 11, 29, 7]
('Not surjective at', 7)  [5, 0, 11]

249.a.6723.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + 1)*y = -x^5 + x^3 + x^2 + 3*x + 2
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [7, 0, 0, 0, 7]
('Surjective at', 3)      [7, 5, 17, 7, 131, 11]
('Surjective at', 5)      [7, 11, 11, 11, 11, 13, 11, 29, 7]
('Not surjective at', 7)  [5, 0, 11]

277.a.277.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + x^2 + x + 1)*y = -x^2 - x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 3, 3, 0, 5]
('Not surjective at', 3)  [5, 0, 5, 0, 0, 5]
('Not surjective at', 5)  [3, 3, 3, 11, 3, 0, 3, 0, 3]
('Surjective at', 7)      [3, 11, 3]

277.a.277.2 Hyperelliptic Curve over Rational Field defined by y^2 + y = x^5 - 9*x^4 + 14*x^3 - 19*x^2 + 11*x - 6
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 3, 3, 0, 5]
('Not surjective at', 3)  [5, 0, 5, 0, 0, 5]
('Not surjective at', 5)  [3, 3, 3, 11, 3, 0, 3, 0, 3]
('Surjective at', 7)      [3, 11, 3]

295.a.295.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + 1)*y = -x^2
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 0, 0, 0, 3]
('Surjective at', 3)      [13, 11, 37, 13, 23, 11]
('Surjective at', 5)      [3, 7, 7, 3, 11, 3, 7, 7, 3]
('Not surjective at', 7)  [3, 0, 3]

295.a.295.2 Hyperelliptic Curve over Rational Field defined by y^2 + (x^2 + x + 1)*y = x^5 - 40*x^3 + 22*x^2 + 389*x - 608
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 0, 0, 0, 3]
('Surjective at', 3)      [13, 11, 37, 13, 23, 11]
('Surjective at', 5)      [3, 7, 7, 3, 11, 3, 7, 7, 3]
('Not surjective at', 7)  [3, 0, 3]

349.a.349.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + x^2 + x + 1)*y = -x^3 - x^2
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 3, 3, 0, 11]
('Surjective at', 3)      [5, 11, 5, 11, 11, 5]
('Surjective at', 5)      [3, 3, 3, 3, 3, 7, 3, 7, 3]
('Surjective at', 7)      [3, 5, 3]

353.a.353.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + x + 1)*y = x^2
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [5, 11, 0, 11, 5]
('Surjective at', 3)      [11, 5, 11, 13, 23, 5]
('Surjective at', 5)      [3, 3, 3, 3, 17, 3, 3, 3, 3]
('Surjective at', 7)      [3, 3, 3]

388.a.776.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + x + 1)*y = -x^4 + 2*x^2 + x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [7, 3, 0, 3, 7]
('Not surjective at', 3)  [5, 0, 5, 0, 0, 5]
('Surjective at', 5)      [3, 3, 3, 3, 3, 7, 3, 7, 3]
('Not surjective at', 7)  [3, 0, 3]

389.a.389.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + x)*y = x^5 - 2*x^4 - 8*x^3 + 16*x + 7
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [5, 0, 0, 0, 5]
('Surjective at', 3)      [5, 5, 41, 5, 5, 5]
('Not surjective at', 5)  [3, 7, 7, 7, 7, 0, 7, 0, 3]
('Surjective at', 7)      [5, 5, 3]

389.a.389.2 Hyperelliptic Curve over Rational Field defined by y^2 + (x + 1)*y = x^5 + 2*x^4 + 2*x^3 + x^2
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [5, 0, 0, 0, 5]
('Surjective at', 3)      [5, 5, 41, 5, 5, 5]
('Not surjective at', 5)  [3, 7, 7, 7, 7, 0, 7, 0, 3]
('Surjective at', 7)      [5, 5, 3]

394.a.394.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + x)*y = 2*x^5 + x^4 - 12*x^3 + 17*x - 9
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [7, 0, 0, 0, 7]
('Surjective at', 3)      [5, 7, 5, 7, 17, 5]
('Not surjective at', 5)  [3, 17, 11, 29, 11, 0, 17, 0, 3]
('Surjective at', 7)      [5, 13, 3]

394.a.3152.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x + 1)*y = -x^5
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [7, 0, 0, 0, 7]
('Surjective at', 3)      [5, 7, 5, 7, 17, 5]
('Not surjective at', 5)  [3, 17, 11, 29, 11, 0, 17, 0, 3]
('Surjective at', 7)      [5, 13, 3]

427.a.2989.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + 1)*y = x^5 - x^4 - 5*x^3 + 4*x^2 + 4*x - 4
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [5, 0, 0, 0, 5]
('Surjective at', 3)      [23, 5, 23, 29, 29, 5]
('Surjective at', 5)      [11, 11, 11, 11, 11, 3, 11, 23, 3]
('Not surjective at', 7)  [3, 0, 5]

461.a.461.1 Hyperelliptic Curve over Rational Field defined by y^2 + x^3*y = x^5 - 3*x^3 + 3*x - 2
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 5, 5, 0, 3]
('Surjective at', 3)      [5, 7, 5, 13, 41, 5]
('Surjective at', 5)      [11, 3, 17, 3, 3, 3, 3, 13, 3]
('Not surjective at', 7)  [5, 0, 3]

461.a.461.2 Hyperelliptic Curve over Rational Field defined by y^2 + y = x^5 - x^4 - 39*x^3 + 10*x^2 + 272*x - 306
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 5, 5, 0, 3]
('Surjective at', 3)      [5, 7, 5, 13, 41, 5]
('Surjective at', 5)      [11, 3, 17, 3, 3, 3, 3, 13, 3]
('Not surjective at', 7)  [5, 0, 3]

464.a.464.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x + 1)*y = -x^6 - 2*x^5 - 2*x^4 - x^3
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 0, 0, 0, 3]
('Surjective at', 3)      [5, 5, 37, 5, 5, 5]
('Surjective at', 5)      [3, 3, 3, 3, 19, 3, 3, 3, 3]
('Surjective at', 7)      [5, 3, 3]

464.a.29696.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x + 1)*y = 8*x^5 + 3*x^4 - 4*x^3 - 2*x^2
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 0, 0, 0, 3]
('Surjective at', 3)      [5, 5, 37, 5, 5, 5]
('Surjective at', 5)      [3, 3, 3, 3, 19, 3, 3, 3, 3]
('Surjective at', 7)      [5, 3, 3]

464.a.29696.2 Hyperelliptic Curve over Rational Field defined by y^2 + x*y = 4*x^5 + 33*x^4 + 72*x^3 + 16*x^2 + x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 0, 0, 0, 3]
('Surjective at', 3)      [5, 5, 37, 5, 5, 5]
('Surjective at', 5)      [3, 3, 3, 3, 19, 3, 3, 3, 3]
('Surjective at', 7)      [5, 3, 3]

472.a.944.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^2 + 1)*y = x^5 - x^4 - 2*x^3 + x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 0, 0, 0, 3]
('Surjective at', 3)      [5, 5, 13, 5, 5, 5]
('Surjective at', 5)      [3, 3, 3, 3, 11, 3, 3, 3, 3]
('Surjective at', 7)      [5, 3, 3]

472.a.60416.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x + 1)*y = 8*x^5 + 5*x^4 + 4*x^3 + 2*x^2
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 0, 0, 0, 3]
('Surjective at', 3)      [5, 5, 13, 5, 5, 5]
('Surjective at', 5)      [3, 3, 3, 3, 11, 3, 3, 3, 3]
('Surjective at', 7)      [5, 3, 3]

523.a.523.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x + 1)*y = x^5 - x^4 - x^3
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [13, 0, 0, 0, 13]
('Surjective at', 3)      [5, 11, 5, 19, 113, 5]
('Not surjective at', 5)  [7, 7, 7, 7, 7, 0, 7, 0, 3]
('Surjective at', 7)      [5, 37, 5]

523.a.523.2 Hyperelliptic Curve over Rational Field defined by y^2 + x*y = x^5 - 31*x^4 - 110*x^3 + 21*x^2 - x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [13, 0, 0, 0, 13]
('Surjective at', 3)      [5, 11, 5, 19, 113, 5]
('Not surjective at', 5)  [7, 7, 7, 7, 7, 0, 7, 0, 3]
('Surjective at', 7)      [5, 37, 5]

555.a.8325.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x + 1)*y = 3*x^5 - 2*x^4 - 4*x^3 + x^2 + x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [7, 0, 0, 0, 7]
('Surjective at', 3)      [7, 7, 127, 7, 29, 29]
('Not surjective at', 5)  [7, 11, 13, 11, 11, 0, 11, 0, 7]
('Surjective at', 7)      [11, 13, 11]

574.a.293888.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^2 + x)*y = x^5 - x^4 - 3*x^2 + x + 1
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [0, 0, 0, 0, 0]
('Surjective at', 3)      [53, 5, 53, 89, 89, 5]
('Not surjective at', 5)  [3, 13, 13, 19, 13, 0, 13, 0, 3]
('Surjective at', 7)      [5, 13, 3]

587.a.587.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + x + 1)*y = -x^2 - x
conclusions           witnesses for each maximal/exceptional subgroup
--------------------  -------------------------------------------------
('Surjective at', 2)  [11, 3, 11, 3, 41]
('Surjective at', 3)  [5, 11, 5, 19, 29, 5]
('Surjective at', 5)  [3, 3, 3, 3, 3, 11, 3, 11, 3]
('Surjective at', 7)  [3, 5, 3]

597.a.597.1 Hyperelliptic Curve over Rational Field defined by y^2 + y = x^5 + 2*x^4 + 3*x^3 + 2*x^2 + x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [5, 7, 7, 0, 5]
('Surjective at', 3)      [11, 5, 11, 17, 17, 5]
('Surjective at', 5)      [7, 7, 7, 7, 13, 7, 7, 7, 7]
('Not surjective at', 7)  [5, 0, 5]

603.a.603.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^2 + 1)*y = x^5 + 8*x^4 + 4*x^3 + 4*x^2 + 2*x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [17, 0, 0, 0, 17]
('Surjective at', 3)      [13, 5, 13, 31, 59, 5]
('Not surjective at', 5)  [11, 19, 11, 19, 11, 0, 19, 0, 7]
('Surjective at', 7)      [5, 37, 5]

603.a.603.2 Hyperelliptic Curve over Rational Field defined by y^2 + (x^2 + 1)*y = x^5 - x^3 + x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [17, 0, 0, 0, 17]
('Surjective at', 3)      [13, 5, 13, 31, 59, 5]
('Not surjective at', 5)  [11, 19, 11, 19, 11, 0, 19, 0, 7]
('Surjective at', 7)      [5, 37, 5]

604.a.9664.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^2 + x + 1)*y = 4*x^5 + 9*x^4 + 48*x^3 - 4*x^2 - 53*x - 21
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 3, 3, 0, 31]
('Not surjective at', 3)  [5, 0, 5, 0, 0, 5]
('Surjective at', 5)      [3, 3, 3, 3, 29, 3, 3, 3, 3]
('Surjective at', 7)      [3, 3, 3]

604.a.9664.2 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + 1)*y = -x^4 + x^3 + x^2 - x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 3, 3, 0, 31]
('Not surjective at', 3)  [5, 0, 5, 0, 0, 5]
('Surjective at', 5)      [3, 3, 3, 3, 29, 3, 3, 3, 3]
('Surjective at', 7)      [3, 3, 3]

644.b.14812.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + 1)*y = x^5 - x^4 - 4*x^3 + 5*x^2 - x - 1
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [0, 0, 0, 0, 0]
('Surjective at', 3)      [17, 11, 29, 17, 17, 11]
('Not surjective at', 5)  [3, 13, 11, 13, 11, 0, 13, 0, 3]
('Surjective at', 7)      [11, 37, 3]

688.a.2752.1 Hyperelliptic Curve over Rational Field defined by y^2 + y = 2*x^5 - 5*x^4 + 4*x^3 - x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [11, 0, 0, 0, 11]
('Surjective at', 3)      [13, 5, 61, 13, 23, 5]
('Not surjective at', 5)  [3, 13, 11, 13, 11, 0, 13, 0, 3]
('Surjective at', 7)      [5, 11, 3]

688.a.704512.2 Hyperelliptic Curve over Rational Field defined by y^2 = 2*x^5 - 7*x^4 - 8*x^3 + 2*x^2 + 4*x + 1
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [11, 0, 0, 0, 11]
('Surjective at', 3)      [13, 5, 61, 13, 23, 5]
('Not surjective at', 5)  [3, 13, 11, 13, 11, 0, 13, 0, 3]
('Surjective at', 7)      [5, 11, 3]

688.a.704512.1 Hyperelliptic Curve over Rational Field defined by y^2 = 2*x^5 + 4*x^3 + x^2 + 2*x + 1
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [11, 0, 0, 0, 11]
('Surjective at', 3)      [13, 5, 61, 13, 23, 5]
('Not surjective at', 5)  [3, 13, 11, 13, 11, 0, 13, 0, 3]
('Surjective at', 7)      [5, 11, 3]

691.a.691.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x + 1)*y = x^5 - x^3 - x^2
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [7, 0, 0, 0, 7]
('Surjective at', 3)      [11, 5, 13, 11, 11, 5]
('Surjective at', 5)      [7, 7, 7, 7, 19, 3, 7, 7, 3]
('Surjective at', 7)      [3, 11, 5]

704.a.45056.1 Hyperelliptic Curve over Rational Field defined by y^2 + y = 4*x^5 + 4*x^4 - x^3 - 2*x^2
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 0, 0, 0, 3]
('Not surjective at', 3)  [5, 0, 5, 0, 0, 5]
('Surjective at', 5)      [3, 7, 7, 7, 7, 3, 7, 3, 3]
('Surjective at', 7)      [3, 31, 3]

708.a.2832.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^2 + x + 1)*y = x^5
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [5, 0, 0, 0, 5]
('Surjective at', 3)      [5, 5, 17, 5, 5, 5]
('Not surjective at', 5)  [7, 7, 7, 7, 7, 0, 7, 0, 7]
('Surjective at', 7)      [5, 5, 5]

708.a.19116.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + 1)*y = -x^5 + 4*x^2 + 4*x - 1
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [5, 0, 0, 0, 5]
('Surjective at', 3)      [5, 5, 17, 5, 5, 5]
('Not surjective at', 5)  [7, 7, 7, 7, 7, 0, 7, 0, 7]
('Surjective at', 7)      [5, 5, 5]

708.a.181248.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + 1)*y = -x^6 - 4*x^5 + 9*x^4 + 48*x^3 - 41*x^2 - 98*x - 36
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [5, 0, 0, 0, 5]
('Surjective at', 3)      [5, 5, 17, 5, 5, 5]
('Not surjective at', 5)  [7, 7, 7, 7, 7, 0, 7, 0, 7]
('Surjective at', 7)      [5, 5, 5]

709.a.709.1 Hyperelliptic Curve over Rational Field defined by y^2 + x*y = x^5 - 2*x^2 + x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 0, 0, 0, 3]
('Surjective at', 3)      [5, 5, 29, 5, 5, 5]
('Surjective at', 5)      [3, 3, 3, 3, 13, 3, 3, 3, 3]
('Surjective at', 7)      [5, 3, 3]

713.a.713.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + x + 1)*y = -x^5 - x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 41, 0, 41, 3]
('Surjective at', 3)      [11, 11, 41, 11, 11, 11]
('Surjective at', 5)      [7, 3, 7, 3, 3, 3, 3, 7, 3]
('Surjective at', 7)      [5, 17, 3]

713.b.713.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + x + 1)*y = -x^4
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 41, 0, 41, 3]
('Not surjective at', 3)  [5, 0, 5, 0, 0, 5]
('Surjective at', 5)      [3, 3, 3, 3, 3, 7, 3, 7, 3]
('Surjective at', 7)      [3, 13, 3]

731.a.12427.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + x^2)*y = x^5 + 2*x^4 - x - 3
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [11, 0, 0, 0, 11]
('Surjective at', 3)      [7, 7, 13, 7, 89, 11]
('Not surjective at', 5)  [7, 7, 7, 11, 7, 0, 7, 0, 3]
('Surjective at', 7)      [11, 83, 11]

741.a.28899.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x + 1)*y = -3*x^5 - x^4 + 2*x^2 + x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [5, 0, 0, 0, 5]
('Surjective at', 3)      [5, 5, 41, 5, 5, 5]
('Surjective at', 5)      [7, 7, 7, 7, 11, 7, 7, 7, 7]
('Surjective at', 7)      [5, 5, 5]

743.a.743.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + x + 1)*y = -x^4 + x^2
conclusions           witnesses for each maximal/exceptional subgroup
--------------------  -------------------------------------------------
('Surjective at', 2)  [3, 3, 3, 5, 7]
('Surjective at', 3)  [13, 5, 41, 13, 23, 5]
('Surjective at', 5)  [3, 3, 3, 3, 11, 3, 3, 3, 3]
('Surjective at', 7)  [3, 3, 3]

745.a.745.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + x + 1)*y = -x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [17, 3, 0, 3, 17]
('Not surjective at', 3)  [29, 0, 29, 0, 0, 29]
('Surjective at', 5)      [11, 11, 11, 11, 11, 3, 11, 13, 3]
('Surjective at', 7)      [11, 13, 11]

762.a.3048.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + x^2 + x)*y = x^2 + x + 1
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [5, 0, 0, 0, 5]
('Not surjective at', 3)  [17, 0, 17, 0, 0, 17]
('Surjective at', 5)      [7, 7, 7, 7, 37, 7, 7, 7, 7]
('Surjective at', 7)      [5, 13, 5]

762.a.82296.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^2 + x)*y = x^5 - 8*x^4 + 14*x^3 + 2*x^2 - x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [5, 0, 0, 0, 5]
('Not surjective at', 3)  [17, 0, 17, 0, 0, 17]
('Surjective at', 5)      [7, 7, 7, 7, 37, 7, 7, 7, 7]
('Surjective at', 7)      [5, 13, 5]

763.a.763.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + x)*y = -2*x^4 + 2*x^2 - x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [13, 0, 0, 0, 13]
('Surjective at', 3)      [11, 5, 11, 67, 257, 11]
('Not surjective at', 5)  [11, 11, 13, 11, 11, 0, 11, 0, 3]
('Surjective at', 7)      [5, 11, 11]

768.a.1536.1 Hyperelliptic Curve over Rational Field defined by y^2 + y = 2*x^5 - x^4 - 3*x^3 + x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [0, 0, 0, 0, 0]
('Not surjective at', 3)  [11, 0, 11, 0, 0, 11]
('Surjective at', 5)      [7, 7, 7, 7, 7, 11, 7, 23, 7]
('Surjective at', 7)      [11, 71, 11]

768.a.4608.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + x^2 + x + 1)*y = -x^3 - x^2 - x - 1
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [0, 0, 0, 0, 0]
('Not surjective at', 3)  [11, 0, 11, 0, 0, 11]
('Surjective at', 5)      [7, 7, 7, 7, 7, 11, 7, 23, 7]
('Surjective at', 7)      [11, 71, 11]

797.a.797.1 Hyperelliptic Curve over Rational Field defined by y^2 + y = x^5 - x^4 + x^3
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 13, 13, 0, 3]
('Surjective at', 3)      [17, 5, 47, 17, 17, 17]
('Surjective at', 5)      [3, 7, 7, 3, 7, 3, 7, 11, 3]
('Not surjective at', 7)  [3, 0, 3]

807.a.2421.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + x)*y = x^5 - 2*x^3 - x^2 + 2*x - 1
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [5, 0, 0, 0, 5]
('Surjective at', 3)      [5, 5, 23, 5, 5, 5]
('Surjective at', 5)      [7, 7, 7, 7, 29, 7, 7, 7, 7]
('Surjective at', 7)      [5, 5, 5]

816.a.13872.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + x^2)*y = -2*x^4 + 6*x^2 - 8*x + 3
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [0, 0, 0, 0, 0]
('Not surjective at', 3)  [11, 0, 11, 0, 0, 11]
('Surjective at', 5)      [7, 7, 7, 7, 7, 11, 7, 29, 7]
('Surjective at', 7)      [11, 59, 11]

816.a.39168.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^2 + 1)*y = 3*x^5 - 4*x^3 - x^2 + x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [0, 0, 0, 0, 0]
('Not surjective at', 3)  [11, 0, 11, 0, 0, 11]
('Surjective at', 5)      [7, 7, 7, 7, 7, 11, 7, 29, 7]
('Surjective at', 7)      [11, 59, 11]

826.a.11564.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^2 + x)*y = x^5 + x^4 + 3*x^3 - 4*x^2 - 4*x + 3
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 0, 0, 0, 3]
('Not surjective at', 3)  [5, 0, 5, 0, 0, 5]
('Surjective at', 5)      [3, 37, 37, 13, 37, 3, 37, 3, 3]
('Surjective at', 7)      [3, 29, 3]

830.a.6640.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + 1)*y = -x^5 + x^4 - 2*x^2 + x + 1
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 0, 0, 0, 3]
('Surjective at', 3)      [11, 7, 13, 11, 11, 11]
('Surjective at', 5)      [3, 3, 3, 3, 7, 3, 3, 3, 3]
('Surjective at', 7)      [11, 3, 3]

830.a.830000.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^2 + x)*y = x^5 - 2*x^4 + 16*x^3 + 8*x^2 + x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 0, 0, 0, 3]
('Surjective at', 3)      [11, 7, 13, 11, 11, 11]
('Surjective at', 5)      [3, 3, 3, 3, 7, 3, 3, 3, 3]
('Surjective at', 7)      [11, 3, 3]

832.a.832.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + x)*y = x^5 - x^3 + x^2 + 2*x - 1
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 0, 0, 0, 3]
('Surjective at', 3)      [11, 17, 11, 17, 17, 11]
('Surjective at', 5)      [3, 3, 3, 3, 17, 3, 3, 3, 3]
('Surjective at', 7)      [5, 3, 3]

834.a.1668.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + 1)*y = -x^2 + x - 1
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [5, 0, 0, 0, 5]
('Surjective at', 3)      [5, 5, 23, 5, 5, 5]
('Surjective at', 5)      [7, 7, 7, 7, 7, 19, 7, 31, 7]
('Surjective at', 7)      [5, 5, 5]

847.c.9317.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + x^2)*y = x^4 + x^3 - x - 2
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 0, 0, 0, 3]
('Surjective at', 3)      [5, 5, 23, 5, 5, 5]
('Surjective at', 5)      [3, 3, 3, 3, 29, 3, 3, 3, 3]
('Surjective at', 7)      [5, 3, 3]

856.a.1712.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + x)*y = -x^4 - x^3 + x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 0, 0, 0, 3]
('Not surjective at', 3)  [11, 0, 11, 0, 0, 11]
('Surjective at', 5)      [3, 7, 7, 7, 7, 3, 7, 3, 3]
('Surjective at', 7)      [3, 13, 3]

862.a.862.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + 1)*y = x^5 - 2*x^4 - 7*x^3 + 7*x^2 + 2*x + 5
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 0, 0, 0, 3]
('Surjective at', 3)      [5, 5, 13, 5, 5, 5]
('Surjective at', 5)      [3, 3, 3, 3, 13, 3, 3, 3, 3]
('Surjective at', 7)      [5, 3, 3]

862.a.6896.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^2 + x)*y = 4*x^5 + 6*x^4 - 3*x^2 - x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 0, 0, 0, 3]
('Surjective at', 3)      [5, 5, 13, 5, 5, 5]
('Surjective at', 5)      [3, 3, 3, 3, 13, 3, 3, 3, 3]
('Surjective at', 7)      [5, 3, 3]

862.b.862.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + x)*y = -2*x^4 + 3*x^2 - x - 1
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 3, 3, 0, 5]
('Not surjective at', 3)  [5, 0, 5, 0, 0, 5]
('Surjective at', 5)      [3, 17, 17, 17, 17, 3, 17, 3, 3]
('Surjective at', 7)      [3, 3, 3]

886.a.3544.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + x)*y = -x^4 - x + 1
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 3, 3, 0, 11]
('Not surjective at', 3)  [5, 0, 5, 0, 0, 5]
('Not surjective at', 5)  [3, 3, 3, 13, 3, 0, 3, 0, 3]
('Surjective at', 7)      [3, 5, 3]

893.a.893.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + x + 1)*y = -x^4 - x^2
conclusions           witnesses for each maximal/exceptional subgroup
--------------------  -------------------------------------------------
('Surjective at', 2)  [7, 3, 7, 3, 131]
('Surjective at', 3)  [7, 5, 13, 7, 41, 5]
('Surjective at', 5)  [3, 3, 3, 3, 3, 11, 3, 13, 3]
('Surjective at', 7)  [3, 13, 3]

909.a.909.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + x)*y = -x^4 + x^2 - x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [5, 0, 0, 0, 5]
('Surjective at', 3)      [5, 5, 7, 5, 5, 5]
('Surjective at', 5)      [13, 7, 13, 7, 7, 7, 7, 13, 7]
('Surjective at', 7)      [5, 5, 5]

909.a.8181.1 Hyperelliptic Curve over Rational Field defined by y^2 + x*y = 3*x^5 - 7*x^4 + x^3 + 6*x^2 - 3*x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [5, 0, 0, 0, 5]
('Surjective at', 3)      [5, 5, 7, 5, 5, 5]
('Surjective at', 5)      [13, 7, 13, 7, 7, 7, 7, 13, 7]
('Surjective at', 7)      [5, 5, 5]

925.a.925.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x + 1)*y = -x^5 + 2*x^4 - x^3 - x^2
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 0, 0, 0, 3]
('Surjective at', 3)      [11, 11, 29, 11, 11, 11]
('Surjective at', 5)      [3, 3, 3, 3, 23, 3, 3, 3, 3]
('Surjective at', 7)      [11, 3, 3]

925.a.23125.1 Hyperelliptic Curve over Rational Field defined by y^2 + x*y = 5*x^5 + x^4 - 19*x^3 + 18*x^2 - 5*x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 0, 0, 0, 3]
('Surjective at', 3)      [11, 11, 29, 11, 11, 11]
('Surjective at', 5)      [3, 3, 3, 3, 23, 3, 3, 3, 3]
('Surjective at', 7)      [11, 3, 3]

932.a.3728.1 Hyperelliptic Curve over Rational Field defined by y^2 + y = x^6 - 2*x^5 + x^4 + x^2 - x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [5, 7, 0, 7, 5]
('Surjective at', 3)      [7, 11, 7, 11, 11, 11]
('Surjective at', 5)      [3, 7, 7, 11, 7, 3, 7, 3, 3]
('Surjective at', 7)      [3, 11, 3]

953.a.953.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + x + 1)*y = x^3 + x^2
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [5, 7, 0, 7, 5]
('Surjective at', 3)      [7, 5, 7, 43, 59, 17]
('Surjective at', 5)      [3, 3, 3, 3, 19, 3, 3, 3, 3]
('Surjective at', 7)      [3, 3, 3]

966.a.834624.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^2 + x)*y = x^5 - x^4 + x^3 + x^2 - x + 1
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [0, 0, 0, 0, 0]
('Not surjective at', 3)  [11, 0, 11, 0, 0, 11]
('Surjective at', 5)      [13, 13, 13, 13, 17, 11, 13, 13, 13]
('Surjective at', 7)      [11, 13, 11]

970.a.1940.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x + 1)*y = x^5 + x^4 + x^3 + x^2
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [7, 0, 0, 0, 7]
('Surjective at', 3)      [7, 7, 29, 7, 11, 11]
('Not surjective at', 5)  [7, 13, 13, 13, 13, 0, 13, 0, 3]
('Surjective at', 7)      [13, 11, 11]

971.a.971.1 Hyperelliptic Curve over Rational Field defined by y^2 + y = x^5 - 2*x^3 + x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 3, 3, 0, 11]
('Surjective at', 3)      [7, 5, 37, 7, 29, 11]
('Surjective at', 5)      [3, 3, 3, 3, 19, 3, 3, 3, 3]
('Surjective at', 7)      [3, 3, 3]

975.a.63375.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x^3 + 1)*y = -x^5 + x^3 + 2*x^2 + x - 1
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [0, 0, 0, 0, 0]
('Not surjective at', 3)  [11, 0, 11, 0, 0, 11]
('Surjective at', 5)      [7, 7, 7, 7, 7, 11, 7, 23, 7]
('Surjective at', 7)      [11, 23, 11]

976.a.999424.1 Hyperelliptic Curve over Rational Field defined by y^2 + (x + 1)*y = x^6 - 2*x^5 + 2*x^3 - x^2
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 3, 3, 0, 7]
('Surjective at', 3)      [5, 5, 127, 5, 5, 5]
('Surjective at', 5)      [3, 7, 7, 7, 13, 7, 7, 7, 3]
('Surjective at', 7)      [3, 3, 3]

997.a.997.1 Hyperelliptic Curve over Rational Field defined by y^2 + x*y = x^5 - 8*x^4 + 16*x^3 - x
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 0, 0, 0, 3]
('Surjective at', 3)      [7, 5, 11, 7, 53, 11]
('Surjective at', 5)      [3, 3, 3, 3, 11, 3, 3, 3, 3]
('Surjective at', 7)      [5, 3, 3]

997.a.997.2 Hyperelliptic Curve over Rational Field defined by y^2 + (x + 1)*y = x^5 + x^4
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 0, 0, 0, 3]
('Surjective at', 3)      [7, 5, 11, 7, 53, 11]
('Surjective at', 5)      [3, 3, 3, 3, 11, 3, 3, 3, 3]
('Surjective at', 7)      [5, 3, 3]

997.b.997.1 Hyperelliptic Curve over Rational Field defined by y^2 + y = x^5 - 2*x^4 + 2*x^3 - x^2
conclusions               witnesses for each maximal/exceptional subgroup
------------------------  -------------------------------------------------
('Not surjective at', 2)  [3, 3, 3, 0, 29]
('Not surjective at', 3)  [5, 0, 5, 0, 0, 5]
('Surjective at', 5)      [3, 3, 3, 3, 7, 3, 3, 3, 3]
('Surjective at', 7)      [3, 3, 3]










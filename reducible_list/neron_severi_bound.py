"""Shameless copy/paste from edgar costa's repo endomorphisms

"""

def is_ordinary(a):
    assert len(a) == 5
    p = sqrt(a[-1]);
    return not ((p**2).divides(a[2]) or p.divides(a[1]))

def is_totally_split(L, p):
    if L.discriminant() % p == 0:
        return False;
    return len(PolynomialRing(FiniteField(p),'z')(L.absolute_polynomial().list()).factor()) == L.absolute_polynomial().degree()

def RM_and_notCM(ef, RM_coeff):
    QQt = PolynomialRing(QQ, 't')
    RM_field = NumberField(QQt(RM_coeff),'r')
    possible_CM = None;
    for p1 in ef:
        if len(p1) == 5:
            p = sqrt(p1[-1])
            if  QQt(p1).is_irreducible() and is_ordinary(p1) and is_totally_split(RM_field, p):
                N = NumberField(QQt(p1), "a")
                if possible_CM is None:
                    possible_CM = N;
                elif not N.is_isomorphic(possible_CM):
                    return True;
                else:
                    pass;
    return False

def cyclotomic_polynomial_bound_4():
    return [cyclotomic_polynomial(k) for k in [1, 2, 3, 4, 5, 6, 8, 10, 12] ]

cyclo_bound_4 = map( list, cyclotomic_polynomial_bound_4())


def rank_from_endo(string_list):
    """
    string_list given by the following process:
    X = mHyperellipticCurve(f,g)
    Endo = EndomorphismData(X, prec = 300, molin_neurohr = False)
    overK = Endo.geometric()
    print overK._desc_[2]
    """
    rank = 0
    for s in string_list:
        # in the LMFDB the description is stored without a space between M_2 and (
        if s in ['M_2 (CC)','M_2(CC)']:
            rank += 4
        elif s in ['M_2 (RR)', 'M_2(RR)']:
            rank += 3
        elif s == 'RR' or s =='CC':
            rank += 1
    return rank

def P2_4factor(a):
    # ref: equation 7.1.5
    assert len(a) == 5
    q = sqrt(a[-1])
    b = [0]*5;
    b[0] = 1
    b[1] = 2*q - a[2]
    b[2] = (2*q ** 2 + a[1]**2 * q - 2*a[2]*q)
    b[3] = q**2*b[1]
    b[4] = q**4
    return q, b

def rank_disc(P1):
    R= PolynomialRing(QQ, 'T')
    T = R.gen();
    if len(P1) != 5:
        return +Infinity, None

    p, p2 =  P2_4factor(P1)

    cp = R(p2)(T/p)
    rank = 2

    rank = 2;
    t_cp = cp
    n_cp = R(1)
    for z in cyclo_bound_4:
        q, r = t_cp.quo_rem( R(z) )
        while r == 0:

            n_cp *= R(z);
            t_cp = q
            rank += len(z) -1
            q, r = t_cp.quo_rem(R(z))

    assert n_cp * t_cp == cp
    e = 1
    assert rank == n_cp.degree() + 2
    while (T-1)**(rank - 2) != characteristic_polynomial_extension(n_cp, e):
        e += 1

    disc = (-1) * characteristic_polynomial_extension(t_cp, e)(1) * p**e
    assert rank % 2 == 0
    return p, rank, disc.squarefree_part()


def characteristic_polynomial_extension(cp, r):
    cplist = list(cp)
    assert cplist[-1] == 1

    n = len(cplist) -1

    A = Matrix(cp.base_ring(), n, n)
    for i in range(n-1):
        A[i+1,i] = 1
    for i in range(n):
        A[i, n-1] = -cplist[i]

    A = A**r
    cpnewlist = list(A.charpoly())
    cpnew =  cp.parent()(cpnewlist)
    return cpnew


def upperrank(ef, verbose = False):
    rd = [];
    rank = +Infinity
    disc = None
    for p1 in ef:
        if len(p1) == 5:
            p, r, d = rank_disc(p1)
            # print p, r, d
            rd.append( [p, r, d] )
            if r < rank:
                rank = r;
                disc = d;
            elif r == rank:
                if disc != d:
                    rank -= 1
    if verbose:
        print(rd)
    return rank, disc
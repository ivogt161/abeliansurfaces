# This code will check that all of the elements of the exceptional subgroups (of projective sizes 1920 and 720 and 5040) over number fields to produce the finite list of statistis for (trace^2/similitude factor, middle coefficient/similitude factor) indicated below.  There will be 4 cases, two for each exceptional maximal subgroup.  However, the list we get in both cases of a given exceptional maximal subgroup will be the same.

G1920_group_data = [(0, -2),(0, -1),(0, 0),(0, 1),(0, 2),(1, 1),(2, 1),(2, 2),(4, 2),(4, 3),(8, 4),(16, 6)]

G720_group_data = [(0, 1), (0, 0), (4, 3), (1, 1), (16, 6), (0, 2), (1, 0), (3, 2), (0, -2)]
G5040_group_data_mod7 = [(0, 0), (0, 1), (0, 2), (0, 5), (0, 6), (1, 0), (1, 1), (2, 6), (3, 2), (4, 3), (5, 3), (6, 3)]

I = matrix([[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]])

#The skew symmetric matrix representing the nondegenerate skew form that matrices in GSp_4 must preserve up to a scalar
J = matrix([[0,0, 0, 1], [0, 0, 1, 0], [0, -1, 0, 0], [-1, 0, 0, 0]])

#Calculates the similitude factor: i.e., the scalar by which a matrix M scales the skew form
def similitude_factor(M):
    return (M.transpose()*J*M)[0][3]

#A subtlety is that we want to work with honest matrices, but up to projective equivalence (to get a finite set), so we use this function to test projective equivalence
def proj_equal(M, N):
    return (M*N^(-1)).is_scalar()

################################################################################

#First case: make the exceptional subgroup of order 1920 that occurs for primes congruent to -3 mod 8.  In this case there is a squareroot of -1 in F_ell.  We'll work in the number field QQ(sqrt(-1)) to take advantage of this.

K = QuadraticField(-1)
a = K.gen()

#The four matrices on page 13 of Mitchell's paper whose projective image has order 1920.  The second matrix comes from the choice of a = 1, b = sqrt(-1), d = 1, in Mitchell's language
M1 = matrix(K, [[1, 0, 0, -1], [0, 1, -1, 0], [0, 1, 1, 0], [1, 0, 0, 1]])
M2 = matrix(K, [[1, 0, 0, a], [0, 1, a, 0], [0, a, 1, 0], [a, 0, 0, 1]])
M3 = matrix(K, [[1, 0, 0, -1], [0, 1, 1, 0], [0, -1, 1, 0], [1, 0, 0, 1]])
M4 = matrix(K, [[1, 0, 1, 0], [0, 1, 0, 1], [-1, 0, 1, 0], [0, -1, 0, 1]])


#We now make the group generated by these matrices up with projective equivalence

#S1920_a is going to be the elements in this subgroup, up to projective equivalense
S1920_a = [I]

#X1920_a is going to be a list of partial words in the generators that we use to build all possible words, and hence the entire group
X1920_a = [I]

while X1920_a:
    print(len(S1920_a), len(X1920_a))
    N = X1920_a.pop()
    for M in [M1*N, M2*N, M3*N, M4*N]:
        found = False
        for T in S1920_a:
            if proj_equal(M, T):
                found = True
                break
        if not found:
            S1920_a.append(M)
            X1920_a.append(M)

#Confirms that the group we've generate has the correct order
assert len(S1920_a) == 1920


#check that the statistics for this group are equal to the set G1920_group_data
Stats_1920_a = []

for s in S1920_a:
    t = - s.characteristic_polynomial()[3]
    m = s.characteristic_polynomial()[2]
    lam = similitude_factor(s)
    Stats_1920_a.append((t^2/lam, m/lam))

assert set(Stats_1920_a) == set(G1920_group_data)


################################################################################

#Second case: make the exceptional subgroup of order 1920 that occurs for primes congruent to 3 mod 8.  In this case there is a squareroot of -2 in F_ell.  We'll work in the number field QQ(sqrt(-2)) to take advantage of this.

K = QuadraticField(-2)
a = K.gen()

#The four matrices on page 13 of Mitchell's paper whose projective image has order 1920.  The second matrix comes from the choice of a = 0, b = sqrt(-2), d = 2, in Mitchell's language
M1 = matrix(K, [[1, 0, 0, -1], [0, 1, -1, 0], [0, 1, 1, 0], [1, 0, 0, 1]])
M2 = matrix(K, [[0, 0, 0, a], [0, 0, a, 0], [0, a, 2, 0], [a, 0, 0, 2]])
M3 = matrix(K, [[1, 0, 0, -1], [0, 1, 1, 0], [0, -1, 1, 0], [1, 0, 0, 1]])
M4 = matrix(K, [[1, 0, 1, 0], [0, 1, 0, 1], [-1, 0, 1, 0], [0, -1, 0, 1]])


#We now make the group generated by these matrices up with projective equivalence

#S1920_b is going to be the elements in this subgroup, up to projective equivalense
S1920_b = [I]

#X1920_b is going to be a list of partial words in the generators that we use to build all possible words, and hence the entire group
X1920_b = [I]

while X1920_b:
    print(len(S1920_b), len(X1920_b))
    N = X1920_b.pop()
    for M in [M1*N, M2*N, M3*N, M4*N]:
        found = False
        for T in S1920_b:
            if proj_equal(M, T):
                found = True
                break
        if not found:
            S1920_b.append(M)
            X1920_b.append(M)

#Confirms that the group we've generate has the correct order
assert len(S1920_b) == 1920


#check that the statistics for this group are equal to the set G1920_group_data
Stats_1920_b = []

for s in S1920_b:
    t = - s.characteristic_polynomial()[3]
    m = s.characteristic_polynomial()[2]
    lam = similitude_factor(s)
    Stats_1920_b.append((t^2/lam, m/lam))

assert set(Stats_1920_b) == set(G1920_group_data)

################################################################################

#Third case: make the exceptional subgroup of order 720 that occurs for primes congruent to 7 mod 12 (but not equal to 7).  In this case there is a primitive third root of unity in F_ell.  We'll work in the number field QQ(zeta_3) to take advantage of this.


K.<a> = NumberField(x^2+x+1)


#Matrices representing a skew perspectivity of order 3 with given axes listed on page 13 of pdf of Mitchell's paper
M1 = matrix(K, [[a, 0, 0, 0], [0, a, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]])
M2 = matrix(K, [[a, 0, 0, 0], [0, 1, 0, 0], [0, 0, a, 0], [0, 0, 0, 1]])

#In the basis of the columns of B3, it is easy to write down the action of the skew perspectivity of order 3, so we change basis from this:
D3 = matrix(K, [[a*(2*a + 1), 0, 0, 0], [0, a*(2*a + 1), 0, 0], [0, 0, 1*(2*a + 1), 0], [0, 0, 0, 1*(2*a + 1)]])
B3= matrix(K, [[0, 1, 0, -2], [1, 0, -2, 0], [1, 1, 1, 1], [1, -1, 1, -1]])
M3 = matrix(K, [[a, 0, -a-1, a+1], [0, a, -a-1, -a-1], [-a-1, -a-1, -1, 0], [a+1, -a-1, 0, -1]])

assert M3 == B3*D3*B3^(-1)

#This final reflection, which is obtained from the two axes written in Mitchell's paper as checked with the assertion below
M4 = matrix([[0, -1, 0, 0], [1, 0, 0, 0], [0, 0, 0, -1], [0, 0, 1, 0]])

L.<b> = QuadraticField(-1)
B4 = matrix(L, [[1, 0, 1, 0], [b, 0, -b, 0], [0, 1, 0, 1], [0, b, 0, -b]])
D4 = matrix([[-b, 0, 0, 0], [0, -b, 0, 0], [0, 0, b, 0], [0, 0, 0, b]])
assert B4*D4*B4^(-1) == M4

#We now make the group generated by these matrices up with projective equivalence

#S720_a is going to be the elements in this subgroup, up to projective equivalense
S720_a = [I]

#X720_a is going to be a list of partial words in the generators that we use to build all possible words, and hence the entire group
X720_a = [I]

while X720_a:
    print(len(S720_a), len(X720_a))
    N = X720_a.pop()
    for M in [M1*N, M2*N, M3*N, M4*N]:
        found = False
        for T in S720_a:
            if proj_equal(M, T):
                found = True
                break
        if not found:
            S720_a.append(M)
            X720_a.append(M)

#Confirms that the group we've generate has the correct order
assert len(S720_a) == 720


#check that the statistics for this group are equal to the set G720_group_data
Stats_720_a = []

for s in S720_a:
    t = - s.characteristic_polynomial()[3]
    m = s.characteristic_polynomial()[2]
    lam = similitude_factor(s)
    Stats_720_a.append((t^2/lam, m/lam))

assert set(Stats_720_a) == set(G720_group_data)

################################################################################

#Fourth case: make the exceptional subgroup of order 720 that occurs for primes congruent to 5 mod 12.  In this case there is a squareroot of -1 in F_ell.  We'll work in the number field QQ(sqrt(-1)) to take advantage of this.


K.<b> = NumberField(x^2+1)


#First two matrices M1, M2 representing a skew perspectivity of order 3 with given axes listed on page 14 of pdf of Mitchell's paper, can be simplified to this form by multiplying by an appropriate scalar matrix, as checked below

M1 = matrix([[-1, 0, 0, -1], [0, -1, -1, 0], [0, 1, 0, 0], [1, 0, 0, 0]])
M2 = matrix([[0, 0, 0, 1], [0, -1, -1, 0], [0, 1, 0, 0], [-1, 0, 0, -1]])

R.<x> = PolynomialRing(K)
L.<a> = K.extension(x^2+x+1)

B1 = matrix(L, [[1, 0, 1, 0], [0, 1, 0, 1], [0, a, 0, a^2], [a, 0, a^2, 0]])
D1 = matrix(L, [[a^2, 0, 0, 0], [0, a^2, 0, 0], [0, 0, a, 0], [0, 0, 0, a]])

B2 = matrix(L, [[1, 0, 1, 0], [0, 1, 0, 1], [0, a, 0, a^2], [a^2, 0, a, 0]])
D2 = D1

assert M1 == B1 * D1 * B1^(-1)
assert M2 == B2 * D2 * B2^(-1)


#Third matrix M3 representing a skew perspectivity of order 3 with given axes listed on page 14 of pdf of Mitchell's paper, with the choice alpha = 1, lambda = sqrt(-1), can be simplified to this form by multiplying by an appropriate scalar matrix, as checked below

M3 = matrix(K, [[-b-1, b, 2*b, -2*b+1], [b, b-1, 2*b+1, 2*b], [b, b-1, -b-2, -b], [-b-1, b, -b, b-2]])

B3 = matrix(L, [[1-b, 1, 1-b, 1], [-1, 1+b, -1, 1+b], [-a^2, a^2 + b*a, -a, a+ b*a^2], [a^2 - b*a, a^2, a-b*a^2, a]])
D3 = matrix([[3*a^2, 0, 0, 0], [0,3*a^2, 0, 0], [0, 0, 3*a, 0], [0, 0, 0, 3*a]])

assert M3 == B3 * D3 * B3^(-1)
                

#This final reflection, which is obtained from the two axes written in Mitchell's paper as checked with the assertion below
M4 = matrix(K, [[0, -b, -2*b, 0], [b, 0, 0, 2*b], [-2*b, 0, 0, -b], [0, 2*b, b, 0]])

B4 = matrix(L, [[b, 1, -b, 1], [1, b, 1, -b], [a, b*a^2, a, -b*a^2], [b*a, a^2, -b*a, a^2]])
D4 = matrix(L, [[-(2*a+1), 0, 0, 0], [0, -(2*a+1), 0, 0], [0, 0, 2*a+1, 0], [0, 0, 0,2*a+1]])

assert M4 == B4*D4*B4^(-1)

#We now make the group generated by these matrices up with projective equivalence

#S720_b is going to be the elements in this subgroup, up to projective equivalense
S720_b = [I]

#X720_b is going to be a list of partial words in the generators that we use to build all possible words, and hence the entire group
X720_b = [I]

while X720_b:
    print(len(S720_b), len(X720_b))
    N = X720_b.pop()
    for M in [M1*N, M2*N, M3*N, M4*N]:
        found = False
        for T in S720_b:
            if proj_equal(M, T):
                found = True
                break
        if not found:
            S720_b.append(M)
            X720_b.append(M)

#Confirms that the group we've generate has the correct order
assert len(S720_b) == 720


#check that the statistics for this group are equal to the set G720_group_data
Stats_720_b = []

for s in S720_b:
    t = - s.characteristic_polynomial()[3]
    m = s.characteristic_polynomial()[2]
    lam = similitude_factor(s)
    Stats_720_b.append((t^2/lam, m/lam))

assert set(Stats_720_b) == set(G720_group_data)


################################################################################

#Fifth case: make the exceptional subgroup of order 5040 that occurs for the prime 7.  In this case there is a primitive third root of unity in F_7.  We'll work in the number field QQ(zeta_3) to take advantage of this.


F = GF(7)

a = F(2)
assert a^2 + a + 1 == 0

I = matrix(F, [[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]])

#The skew symmetric matrix representing the nondegenerate skew form that matrices in GSp_4 must preserve up to a scalar
J = matrix(F, [[0,0, 0, 1], [0, 0, 1, 0], [0, -1, 0, 0], [-1, 0, 0, 0]])


#This group is generated by the same matrices as the group of order 720 for primes congruent to 7 mod 12, and one additional skew perspectivity of order 3 whose axes are given on page 14 of the pdf of Mitchell's paper
M1 = matrix(F, [[a, 0, 0, 0], [0, a, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]])
M2 = matrix(F, [[a, 0, 0, 0], [0, 1, 0, 0], [0, 0, a, 0], [0, 0, 0, 1]])

D3 = matrix(F, [[a, 0, 0, 0], [0, a, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]])
B3= matrix(F, [[0, 1, 0, -2], [1, 0, -2, 0], [1, 1, 1, 1], [1, -1, 1, -1]])
M3 = B3*D3*B3^(-1)

M4 = matrix(F, [[0, -1, 0, 0], [1, 0, 0, 0], [0, 0, 0, -1], [0, 0, 1, 0]])

#The final skew perspectivity of order 3:

B5 = matrix(F, [[1,0,1,0], [2,0,3,0], [0,3,0,2], [0, 1, 0, 1]])
D5 = matrix(F, [[a, 0, 0, 0], [0, a, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]])
M5 = B5*D5*B5^(-1)

#We now make the group generated by these matrices up with projective equivalence

#S5040 is going to be the elements in this subgroup, up to projective equivalense
S5040 = [I]

#X5040 is going to be a list of partial words in the generators that we use to build all possible words, and hence the entire group
X5040 = [I]

while X5040:
    print(len(S5040), len(X5040))
    N = X5040.pop()
    for M in [M1*N, M2*N, M3*N, M4*N, M5*N]:
        found = False
        for T in S5040:
            if proj_equal(M, T):
                found = True
                break
        if not found:
            S5040.append(M)
            X5040.append(M)

#Confirms that the group we've generate has the correct order
assert len(S5040) == 5040


#check that the statistics for this group are equal to
Stats_5040 = []

for s in S5040:
    t = - s.characteristic_polynomial()[3]
    m = s.characteristic_polynomial()[2]
    lam = similitude_factor(s)
    Stats_5040.append((t^2/lam, m/lam))

assert set(Stats_5040) == set(G5040_group_data_mod7)

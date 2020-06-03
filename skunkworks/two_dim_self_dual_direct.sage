"""two_dim_self_dual_direct.sage

Given a polynomial f, return the primes l where the mod-l galois representation
falls into Case 3.3 of Dieulefait's paper, i.e., splits as a sum of two 2-d
pieces, each self-dual.

This is the bit which uses CuspForms.

This is actually *NOT* what we want to do - we don't want to work with
the newforms directly; but it might be useful to someone for some purpose
"""

# Global info
R.<x> = ZZ[]


# Zev's function, copied here for now
def special_divisors(N)
	D0 = [d for d in divisors(N) if d <= sqrt(N)]
	D0.reverse()
	D = []
	for d0 in D0:
    		if all([d % d0 != 0 for d in D]):
            		D.append(d0)
            
	D.reverse()
	return D


# Zev's function, copied here for now
def set_up_cuspidal_spaces(N)
	D = special_divisors(N)
	return [CuspForms(d) for d in D]


def basis_of_eigenforms_of_level(t):
    """This should return a basis of eigenforms of this level.

    There's a result in Diamond/Shurman telling us that a basis of
    newforms at each M | N gives us this basis. Since we're probably 
    not using this idea anyway, we just quickly deal with the case
    of prime t. If you want to use this properly, then this becomes TODO.
    """

    return CuspForms(t).newforms(names='a')

def left_hand_of_3_8(t,p,f):
    C_p = HyperellipticCurve(f).base_extend(GF(p))
    Pol_p = R(C_p.frobenius_polynomial())
    polys_in_prod = [(x^2 - f[p]*x + p) for f in basis_of_eigenforms_of_level(t)]
    the_prod_poly = prod(polys_in_prod)
    return the_prod_poly.resultant(Pol_p)


def get_two_dim_self_dual_primes(f):
    """main calling function"""
    N_away_2 = genus2reduction(0,f).conductor  # Dieulefait calls this c (kinda)

    S = special_divisors(N_away_2)

    final_primes = set()

    for t in S:
        left_hand_of_3_8_list = []
        for p in primes(3,100):
            if N_away_2 % p != 0:
                left_hand_of_3_8_list.append(left_hand_of_3_8(t,p,f))
        gcd_of_this_list = gcd(left_hand_of_3_8_list)
        final_primes = final_primes.union(set(prime_divisors(gcd_of_this_list)))

    return final_primes

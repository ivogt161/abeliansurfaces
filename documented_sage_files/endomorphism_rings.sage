"""endomorphism_rings.sage

We need to ensure that the absolute endomorphism ring is Z for all of this.

"""

from neron_severi_bound import rank_disc


def can_conclude_trivial(running_triples, this_triple):
    """This should implement Edgar Costa's suggestion from the Zulip chat.
    Basically, if you find two primes with rank(NS) = 2 and different
    squarefree part, then return True
    TODO"""

    return False

def is_abs_endo_ring_trivial(f):
    """Given f, univariate polynomial over Z of degree 5 or 6, return true if 
    absolute endomorphism ring is Z, otherwise false"""

    C = HyperellipticCurve(f)
    reduction_data = genus2reduction(0,f)
    the_conductor = reduction_data.conductor
    
    running_triples = []

    for p in primes(100):
        if the_conductor % p != 0:  # i.e. if p is a good prime
            C_p = C.base_extend(GF(p))
            P_p_dual = C_p.zeta_function().numerator()
            coeffs_P_p_dual = [P_p_dual[i] for i in range(5)]
            this_triple = rank_disc(coeffs_P_p_dual)  # a tuple, not a list
            if can_conclude_trivial(running_triples, this_triple ):
                return True
            else:
                running_triples.append(this_triple)
    
    # if we haven't returned True by now, probably it's False
    return False

"""non_semistable_primes.sage

Given a genus 2 curve, return the non semistable primes.

"""


def non_semistable_primes(f):
    """Given f, univariate polynomial over Z of degree 5 or 6, return primes
    of non-semistable reduction
    
    Actually this is probably larger than the set we really want most of the
    time; we're just taking the primes which divide the conductor with exponent
    at least 2. It's a start.
    TODO do it properly
    """

    reduction_data_C = genus2reduction(0,f)
    conductor_C = reduction_data_C.conductor_C
    return [p[0] for p in conductor_C if p[1]>1]

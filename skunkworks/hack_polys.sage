"""hack_polys.sage

This is Zev's suggestion of verifying polys with the LMFDB. 
Use with caution.
"""

# Set up some poly rings
R.<x> = PolynomialRing(ComplexField())
S.<y> = PolynomialRing(RealField())
T.<z> = PolynomialRing(IntegerRing())

def hack_poly_together(roots, p):
    Answer = 1
    for root, mul in roots:
        Answer = Answer * (x^2 - root*x + p)^mul
    Answer = S(Answer)
    
    # At this point you'd think that coercing Answer into T would be 
    # good. Think again! That don't work. So we need a hack of a hack.

    degree_of_poly = Answer.degree()
    final_answer = 0
    for i in range(degree_of_poly+1):
        final_answer += round(Answer[i]) * z^i

    return final_answer

# Toy example
f = CuspForms(389).hecke_polynomial(5)
the_roots = f.roots(ComplexField())
answer_hopefully = hack_poly_together(the_roots, 5).factor()

# You'd hope that this would be the poly listed at the bottom of:
# https://www.lmfdb.org/ModularForm/GL2/Q/holomorphic/389/2/a/#moreep
# but it ain't :( 
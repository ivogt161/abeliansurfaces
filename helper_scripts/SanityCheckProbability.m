/*
    This code sanity checks the probability results in Section 5
    of the paper.
*/

G1920_statistics := {@ <0, -2>,<0, -1>,<0, 0>, <0, 1>, <0, 2>, <1, 1>, <2, 1>, <2, 2>, <4, 2>, <4, 3>, <8, 4>, <16, 6> @};
G720_statistics := {@ <0, 1>, <0, 0>, <4, 3>, <1, 1>, <16, 6>, <0, 2>, <1, 0>, <3, 2>, <0, -2> @};
G5040_statistics := {@ <0,0>, <0,1>, <0,2>, <0,5>, <0,6>, <1,0>, <1,1>, <2,6>, <3,2>, <4,3>, <5,3>, <6,3>@};

/* The similitude factor is how the transformation scales the skew-symmetric form, e.g., how it scales J. */
SimilitudeFactor := function(M, ell)
 J := Matrix(GF(ell), [[0, 0, 0, 1], [0, 0, 1, 0], [0, -1, 0, 0], [-1, 0, 0, 0]]);
 lam := (Transpose(M)*J*M)[1,4];
 return lam;
end function;


_<t>:=FunctionField(Rationals());
f1:=1/4 - 1/(2*(t^2+1));
f2:=3/8 - 3/(4*(t-1)) + 1/(2*(t-1)^2);
f3:=1 - 3*t/(t^2+1);

for p in PrimesInInterval(3,100) do
    n:=#CSp(4,GF(p));
    CG:=ConjugacyClasses(CSp(4,GF(p)));
    if p eq 7 then
        GA:=ChangeUniverse(G1920_statistics join G720_statistics join G5040_statistics, CartesianPower(GF(p),2));
    else
        GA:=ChangeUniverse(G1920_statistics join G720_statistics, CartesianPower(GF(p),2));
    end if;
    C1:={@C:C in CG|IsIrreducible(f) where f is CharacteristicPolynomial(C[3])@};
    C2:={@C:C in CG|Coefficient(f,3) ne 0 and #[g:g in Factorization(f)|Degree(g[1]) eq 1 and IsOdd(g[2])] gt 0 where f is CharacteristicPolynomial(C[3])@};
    C3:={@C:C in CG|not <Coefficient(f,3)^2/v,Coefficient(f,2)/v> in GA  where v is SimilitudeFactor(C[3],p) where f is CharacteristicPolynomial(C[3])@};
    a1:=&+[Integers()|C[2]:C in C1];
    a2:=&+[Integers()|C[2]:C in C2];
    a3:=&+[Integers()|C[2]:C in C3];
    assert(a1/n eq Evaluate(f1,p));
    assert(a2/n eq Evaluate(f2,p));
    assert(a3/n ge Evaluate(f3,p));
    "Validated for p = ",p;
end for;

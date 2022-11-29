

/* This code tests to see if we recognize all of the maximal subgroups of GSp_4(F_ell) for ell between 11 and 47, as a sanity check. It also checks that the statistics of (tr^2/similitude factor, middle coefficient/similitude factor) for all elements of the exceptional groups are in the finite precomputed list.
*/

 
 /* The precomputed list of possible (t^2/l, m/l), where  the characteristic polynomial is of the form x^4 - tx + mx^2 - ltx + l^2.  We call t the trace, m the middle coefficient, and l the similitude factor.
 */
G1920_statistics := {* <0, -2>,<0, -1>,<0, 0>, <0, 1>, <0, 2>, <1, 1>, <2, 1>, <2, 2>, <4, 2>, <4, 3>, <8, 4>, <16, 6> *};
G720_statistics := {* <0, 1>, <0, 0>, <4, 3>, <1, 1>, <16, 6>, <0, 2>, <1, 0>, <3, 2>, <0, -2> *};
G5040_statistics_mod7 := {* <0, 0>, <0, 1>, <0, 2>, <0, 5>, <0, 6>, <1, 0>, <1, 1>, <2, 6>, <3, 2>, <4, 3>, <5, 3>, <6, 3> *};

/* This skew-symmetric matrix J represents the standard nondegenerate skew-symmetric form (e.g., used by Magma and also Mitchell).*/
J := Matrix([[0, 0, 0, 1], [0, 0, 1, 0], [0, -1, 0, 0], [-1, 0, 0, 0]]);

/* The similitude factor is how the transformation scales the skew-symmetric form, e.g., how it scales J. */
SimilitudeFactor := function(M, ell)
    J := Matrix(GF(ell), [[0, 0, 0, 1], [0, 0, 1, 0], [0, -1, 0, 0], [-1, 0, 0, 0]]);
    lam := (Transpose(M)*J*M)[1,4];
    return lam;
    end function;


for ell in PrimesInInterval(3, 50) do

    printf "ell=%o\n", ell;

    F := GF(ell);
    P<x> := PolynomialRing(F);
    
    c := PrimitiveRoot(ell);
    
    /* Reduce the list G1920_statistics mod ell */
    G1920_statistics_modell := {* *};
    for st in G1920_statistics do
        Include(~G1920_statistics_modell, <F!st[1], F!st[2]>);
    end for;
    
    /* Reduce the list G720_statistics mod ell */
    G720_statistics_modell := {* *};
    for st in G720_statistics do
        Include(~G720_statistics_modell, <F!st[1], F!st[2]>);
    end for;

    G:=CSp(4,GF(ell));
    M:=MaximalSubgroups(G);

    orderGL2Fell := (ell^2 - 1)*(ell^2 - ell);
    orderSL2Fell := orderGL2Fell / (ell -1);

    /* The nonexceptional maximal subgroups that we understand already:*/

    /* The 4 ``normalizers of Cartans''*/
    orderN1 := 2 *  orderGL2Fell * (ell - 1);
    orderN2 := 2 * orderGL2Fell * (ell + 1);
    orderN3 := 2 * orderGL2Fell * ell * (ell^2 - 1);
    orderN4 := 2 * orderGL2Fell * ell * (ell^2 + 1);

    /* The ``Borels'' */
    orderBorel := ell^4*(ell^2 - 1)*(ell - 1)^2;;

    /* The stabilizer of a twisted cubic */
    orderTwisted := orderGL2Fell;
    
    /* All of the orders of the nonexceptional maximal subgroups */
    KnownOrders := [* orderN1, orderN2, orderN3, orderN4, orderBorel, orderTwisted *];
    /*printf "Known orders are:%o, %o\n", KnownOrders, Type(KnownOrders[1]);*/

    for H in M do
    
        recognize := false;
        
        /* First we see if the order is one of the orders of our "known" nonexceptional maximal subgroups*/
        for k in KnownOrders do
            if Order(H`subgroup) eq k then
                recognize := true;
            end if;
        end for;
            
        /* Then we see if the index is at most ell - 1 (this takes care of the groups that don't have surjective similitude character) */
        if Order(G)/Order(H`subgroup) le (ell-1) then
            recognize := true;
        end if;
        
        /* The maximal subgroups that are left are "exceptional"*/
        
        /* As in Mitchell's classification, the first type of exceptional group has order mod scalars 16*120 = 1920 and only gives rise to a maximal subgroup of PGSp_4(F_ell) when it is not contained in PSp_4(F_ell).  This happens precisely for ell congruent to pm 3 mod 8.  We separate the cases in order to explicitly write down the second matrix on page 13 of the PDF of Mitchell's paper. */
        if ell mod 8 eq 3 then
            if Order(H`subgroup) eq 1920 * (ell - 1) then
            
                /* First we'll check to see if all of the statistics of (t^2/l, m/l) are in our finite list G1920_statistics_modell */
                for h in H`subgroup do
                    t := - Coefficient(CharacteristicPolynomial(h), 3);
                    m := Coefficient(CharacteristicPolynomial(h), 2);
                    l := SimilitudeFactor(h, ell);
                    assert l^2 eq Coefficient(CharacteristicPolynomial(h), 0);
                    assert <t^2/l, m/l> in G1920_statistics_modell;
                end for;
            
                /* Under these congruence conditions, there is a squareroot of -2 in the field */
                a := Roots(x^2 + 2)[1][1];
                
                /* These matrices can be found on page 13 of the PDF of Mitchell's paper */
                M1 := Matrix(F, [[1, 0, 0, -1], [0, 1, -1, 0], [0, 1, 1, 0], [1, 0, 0, 1]]);
                M2 := Matrix(F, [[0, 0, 0, a], [0, 0, a, 0], [0, a, 2, 0], [a, 0, 0, 2]]);
                M3 := Matrix(F, [[1, 0, 0, -1], [0, 1, 1, 0], [0, -1, 1, 0], [1, 0, 0, 1]]);
                M4 := Matrix(F, [[1, 0, 1, 0], [0, 1, 0, 1], [-1, 0, 1, 0], [0, -1, 0, 1]]);
                
                /* Add in the scalar matrices to get the full preimage in GSp */
                M5 := Matrix(F, [[c, 0, 0, 0], [0, c, 0, 0], [0, 0, c, 0], [0, 0, 0, c]]);
                
                S := sub<G | [M1, M2, M3, M4, M5]>;
                
                /* Check that the subgroup we make is conjugate to H */
                if IsConjugate(G, H`subgroup, S) then
                    recognize := true;
                end if;
            end if;
        end if;
        
        if ell mod 8 eq 5 then
            if Order(H`subgroup) eq 1920 * (ell - 1) then
            
                /* First we'll check to see if all of the statistics of (t^2/l, m/l) are in our finite list G1920_statistics_modell */
                for h in H`subgroup do
                    t := - Coefficient(CharacteristicPolynomial(h), 3);
                    m := Coefficient(CharacteristicPolynomial(h), 2);
                    l := SimilitudeFactor(h, ell);
                    assert l^2 eq Coefficient(CharacteristicPolynomial(h), 0);
                    assert <t^2/l, m/l> in G1920_statistics_modell;
                end for;
            
                /* Under these congruence conditions, there is a squareroot of -1 in the field */
                a := Roots(x^2 + 1)[1][1];
                
                /* These matrices can be found on page 13 of the PDF of Mitchell's paper */
                M1 := Matrix(F, [[1, 0, 0, -1], [0, 1, -1, 0], [0, 1, 1, 0], [1, 0, 0, 1]]);
                M2 := Matrix(F, [[1, 0, 0, a], [0, 1, a, 0], [0, a, 1, 0], [a, 0, 0, 1]]);
                M3 := Matrix(F, [[1, 0, 0, -1], [0, 1, 1, 0], [0, -1, 1, 0], [1, 0, 0, 1]]);
                M4 := Matrix(F, [[1, 0, 1, 0], [0, 1, 0, 1], [-1, 0, 1, 0], [0, -1, 0, 1]]);
                
                /* Add in the scalar matrices to get the full preimage in GSp */
                M5 := Matrix(F, [[c, 0, 0, 0], [0, c, 0, 0], [0, 0, c, 0], [0, 0, 0, c]]);
                
                S := sub<G | [M1, M2, M3, M4, M5]>;
                
                /* Check that the subgroup we make is conjugate to H */
                if IsConjugate(G, H`subgroup, S) then
                    recognize := true;
                end if;
            end if;
        end if;
        
        if ell mod 12 eq 7  and ell ne 7 then
            if Order(H`subgroup) eq 720 * (ell - 1) then
            
                /* First we'll check to see if all of the statistics of (t^2/l, m/l) are in our finite list G720_statistics_modell */
                for h in H`subgroup do
                    t := - Coefficient(CharacteristicPolynomial(h), 3);
                    m := Coefficient(CharacteristicPolynomial(h), 2);
                    l := SimilitudeFactor(h, ell);
                    assert l^2 eq Coefficient(CharacteristicPolynomial(h), 0);
                    assert <t^2/l, m/l> in G720_statistics_modell;
                end for;
                /* Under these congruence conditions, there is a primitive third root of unity in the field */
                a := Roots(x^2 + x + 1)[1][1];
                
                /* These matrices can be written down from the description on page 13 of Mitchell's paper: a skew perspectivity of order 3 is attached to a direct sum decomposition of a 4-dimensional vector space into two two dimensional subspaces.  The skew perspectivity multiplies the vectors in one subspace by a primitive 3rd root of unity. */
                M1 := Matrix(F, [[a, 0, 0, 0], [0, a, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]);
                M2 := Matrix(F, [[a, 0, 0, 0], [0, 1, 0, 0], [0, 0, a, 0], [0, 0, 0, 1]]);

                D := Matrix(F, [[a, 0, 0, 0], [0, a, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]);
                B := Matrix(F, [[0, 1, 0, -2], [1, 0, -2, 0], [1, 1, 1, 1], [1, -1, 1, -1]]);
                M3 := B*D*B^(-1);

                /* The skew perspectivity of order 2 (what Mitchell calls a reflection) */
                M4 := Matrix(F, [[0, -1, 0, 0], [1, 0, 0, 0], [0, 0, 0, -1], [0, 0, 1, 0]]);
                
                /* Add in the scalar matrices to get the full preimage in GSp */
                M5 := Matrix(F, [[c, 0, 0, 0], [0, c, 0, 0], [0, 0, c, 0], [0, 0, 0, c]]);
                S := sub<G | [M1, M2, M3, M4, M5]>;
                if IsConjugate(G, H`subgroup, S) then
                    recognize := true;
                end if;
            end if;
        end if;
        
        if ell eq 7 then
            if Order(H`subgroup) eq 5040 * (ell - 1) then
            
                /* First we'll check to see if all of the statistics of (t^2/l, m/l) are in our finite list G5040_statistics_modell */
                for h in H`subgroup do
                    t := - Coefficient(CharacteristicPolynomial(h), 3);
                    m := Coefficient(CharacteristicPolynomial(h), 2);
                    l := SimilitudeFactor(h, ell);
                    assert l^2 eq Coefficient(CharacteristicPolynomial(h), 0);
                    assert <t^2/l, m/l> in G5040_statistics_mod7;
                end for;
                
                
                /* Under these congruence conditions, there is a primitive third root of unity in the field */
                a := Roots(x^2 + x + 1)[1][1];
                
                /* These matrices can be written down from the description on page 13 of Mitchell's paper: a skew perspectivity of order 3 is attached to a direct sum decomposition of a 4-dimensional vector space into two two dimensional subspaces.  The skew perspectivity multiplies the vectors in one subspace by a primitive 3rd root of unity. */
                M1 := Matrix(F, [[a, 0, 0, 0], [0, a, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]);
                M2 := Matrix(F, [[a, 0, 0, 0], [0, 1, 0, 0], [0, 0, a, 0], [0, 0, 0, 1]]);

                D := Matrix(F, [[a, 0, 0, 0], [0, a, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]);
                B := Matrix(F, [[0, 1, 0, -2], [1, 0, -2, 0], [1, 1, 1, 1], [1, -1, 1, -1]]);
                M3 := B*D*B^(-1);

                /* The skew perspectivity of order 2 (what Mitchell calls a reflection) */
                M4 := Matrix(F, [[0, -1, 0, 0], [1, 0, 0, 0], [0, 0, 0, -1], [0, 0, 1, 0]]);
                
                /* The last extra skew perspectivity of order 3 */
                
                B6 := Matrix(F, [[1,0,1,0], [2,0,3,0], [0,3,0,2], [0, 1, 0, 1]]);
                D6 := Matrix(F, [[a, 0, 0, 0], [0, a, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]);
                M6 := B6*D6*B6^(-1);
                
                /* Add in the scalar matrices to get the full preimage in GSp */
                M5 := Matrix(F, [[c, 0, 0, 0], [0, c, 0, 0], [0, 0, c, 0], [0, 0, 0, c]]);
                S := sub<G | [M1, M2, M3, M4, M5, M6]>;
                if IsConjugate(G, H`subgroup, S) then
                    recognize := true;
                end if;
            end if;
        end if;
        
        
        if ell mod 12 eq 5 then
            if Order(H`subgroup) eq 720 * (ell - 1) then
            
                /* First we'll check to see if all of the statistics of (t^2/l, m/l) are in our finite list G720_statistics_modell */
                for h in H`subgroup do
                    t := - Coefficient(CharacteristicPolynomial(h), 3);
                    m := Coefficient(CharacteristicPolynomial(h), 2);
                    l := SimilitudeFactor(h, ell);
                    assert l^2 eq Coefficient(CharacteristicPolynomial(h), 0);
                    assert <t^2/l, m/l> in G720_statistics_modell;
                end for;
                
                /* Under these congruence conditions, there is a squareroot of -1 in the field */
                b := Roots(x^2 + 1)[1][1];
                
                /* These matrices can be obtained from the skew perspectivity description (appropriately scaling by a scalar matrix to make there be no 3rd roots of unity. */
                M1 := Matrix(F, [[-1, 0, 0, -1], [0, -1, -1, 0], [0, 1, 0, 0], [1, 0, 0, 0]]);
                M2 := Matrix(F, [[0, 0, 0, 1], [0, -1, -1, 0], [0, 1, 0, 0], [-1, 0, 0, -1]]);
                M3 := Matrix(F, [[-b-1, b, 2*b, -2*b+1], [b, b-1, 2*b+1, 2*b], [b, b-1, -b-2, -b], [-b-1, b, -b, b-2]]);
                
                /* The last reflection */
                M4 := Matrix(F, [[0, -b, -2*b, 0], [b, 0, 0, 2*b], [-2*b, 0, 0, -b], [0, 2*b, b, 0]]);
                
                /* Add in the scalar matrices*/
                M5 := Matrix(F, [[c, 0, 0, 0], [0, c, 0, 0], [0, 0, c, 0], [0, 0, 0, c]]);
                
                S := sub<G | [M1, M2, M3, M4, M5]>;
                if IsConjugate(G, H`subgroup, S) then
                    recognize := true;
                end if;
            end if;
        end if;
        if recognize eq false then
            printf "NOT RECOGNIZED: ell= %o, order=%o\n", ell, Order(H`subgroup);
        end if;
    end for;
end for;



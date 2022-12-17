# -*- coding: utf-8 -*-
r"""
Galois representations attached to Jacoians of hyperelliptic curves of
genus 2 over the rationals.
The Jacobian variety of a genus 2 hyperelliptic curve over `\QQ` defines
an abelian surface whose `p`-torsion Galois module defines a
`4`-dimensional Galois representation of the absolute Galois group
`G_{\QQ}` of `\QQ`. The image of this representation is a subgroup of
`\text{GSp}_4(\GF{p})`, and it is known by an analogue of Serre's Open Image
Theorem that this representation is surjective for almost all primes `p`
under the additional assumption that the Jacobian is "generic", meaning
that the ring of endomorphisms defined over `\overline{\QQ}` is `\ZZ`.
Currently sage can decide whether or not the image of this representation
associated to a generic jacobian is surjective, and moreover can
determine exactly the finitely many primes at which the representation
is not surjective.
For the surjectivity at one prime:
- ``is_surjective(p)``
For the list of non-surjective primes:
- ``non_surjective()``

EXAMPLES::

    sage: R.<x>=QQ[]
    sage: f = x^6 + 2*x^3 + 4*x^2 + 4*x + 1
    sage: C = HyperellipticCurve(f)
    sage: A = C.jacobian()
    sage: rho = A.galois_representation()
    sage: rho.non_surjective()
    [2, 7]
    sage: rho.is_surjective(7)
    False
    sage: rho.is_surjective(2)
    False
    sage: rho.is_surjective(3)
    True
    sage: rho.is_surjective(13)
    True

If the Jacobian has any non-trivial endomorphisms, we raise a ValueError::

    sage: R.<x>=QQ[]
    sage: f = x^5 + 17
    sage: C = HyperellipticCurve(f)
    sage: A = C.jacobian()
    sage: rho = A.galois_representation()
    sage: rho.non_surjective()
    Traceback (most recent call last):
    ...
    NotImplementedError: Currently surjectivity can only be determined if the Jacobian has no extra endomorphisms, but this Jacobian does have such.

REFERENCES::
- [Ser1972]_
- [Ser1987]_

AUTHORS::
- Barinder Singh Banwait, Armand Brumer, Hyun Jong Kim, Zev Klagsbrun,
  Jacob Mayle, Padmavathi Srinivasan, Isabel Vogt
"""

######################################################################
#                 Copyright (C) 2022 The Authors
#
#  Distributed under the terms of the GNU General Public License (GPL)
#
#    This code is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#    General Public License for more details.
#
#  The full text of the GPL is available at:
#
#                  http://www.gnu.org/licenses/
######################################################################
from __future__ import print_function, absolute_import

from sage.structure.sage_object import SageObject
from sage.arith.all import lcm, gcd
from sage.rings.fast_arith import prime_range
from sage.misc.lazy_import import lazy_import

lazy_import("sage.interfaces.genus2reduction", ["genus2reduction", "Genus2reduction"])
from sage.misc.all import prod
from sage.rings.all import GF, ZZ, Zmod
from .jacobian_galrep_utils import (
    _init_wit,
    _update_wit,
    set_up_cuspidal_spaces,
    set_up_quadratic_chars,
    maximal_square_divisor,
    rule_out_1_plus_3_via_Frob_p,
    rule_out_2_plus_2_nonselfdual_via_Frob_p,
    rule_out_cuspidal_spaces_using_Frob_p,
    rule_out_quadratic_ell_via_Frob_p,
)


class GaloisRepresentation(SageObject):
    r"""
    The compatible family of Galois representations
    attached to the Jacobian of a  hyperelliptic curve over the rational
    numbers.
    More text here.

    EXAMPLES::

        sage: R.<x>=QQ[]
        sage: f = x**5 + 17
        sage: C = HyperellipticCurve(f)
        sage: J = C.jacobian()
        sage: rho = J.galois_representation()
        sage: rho
        Compatible family of Galois representations associated to the Jacobian of Hyperelliptic Curve over Rational Field defined by y^2 = x^5 + 17

    """

    def __init__(self, A):
        r"""
        See ``GaloisRepresentation`` for documentation

        EXAMPLES::

            sage: rho = EllipticCurve('11a1').galois_representation()
            sage: loads(rho.dumps()) == rho
            True
        """
        self.__image_type = {}
        self._A = A
        self.non_surjective_primes = None

    def __repr__(self):
        r"""
        String representation of the class

        EXAMPLES::

            sage: rho = EllipticCurve([0,1]).galois_representation()
            sage: rho
            Compatible family of Galois representations associated to the Elliptic Curve defined by y^2 = x^3 + 1 over Rational Field
        """
        return "Compatible family of Galois representations associated to the " + repr(
            self._A
        )

    #####################################################################
    # surjectivity
    #####################################################################

    def find_surj_from_list(self, L=prime_range(1000), bound=1000, verbose=False):
        r"""
        Return a list of primes in L at which the residual Galois
        representation of the Jacobian of `H` might not be surjective.
        Outside of the returned list, all primes in L are surjective.
        The primes in the returned list are likely non-surjective.

        INPUT::

        - ``H`` -- hyperelliptic curve with typical Jacobian
        - ``L`` -- list of primes (default: list of primes less than 1000)
        - ``bound`` -- integer (default: `1000`)
        - ``verbose`` -- boolean (default: `False`)

        OUTPUT:: a list of prime numbers

        EXAMPLES::

            sage: R.<x> = PolynomialRing(QQ);
            sage: H = HyperellipticCurve(R([0, 1, 1]), R([1, 0, 0, 1]));
            sage: rho = H.jacobian().galois_representation()
            sage: rho.find_surj_from_list()
            [2, 7]

        ::

            sage: R.<x> = PolynomialRing(QQ)
            sage: H = HyperellipticCurve(R([0, 21, -5, -9, 1, 1]), R([1, 1])); H
            Hyperelliptic Curve over Rational Field defined by y^2 + (x + 1)*y = x^5 + x^4 - 9*x^3 - 5*x^2 + 21*x
            sage: rho = H.jacobian().galois_representation()
            sage: rho.find_surj_from_list()
            [2, 13]
        """
        H = self._A.curve()
        f, h = H.hyperelliptic_polynomials()
        C = 2 * prod(genus2reduction(h, f).local_data.keys())
        witnesses = _init_wit(L)
        to_check = (
            L.copy()
        )  # to_check is the list of primes for which we still need to determine surjectivity. Initially, it equals L and we remove primes as their status is determined.
        for p in prime_range(3, bound):
            if C % p != 0:
                Hp = H.change_ring(GF(p))
                frob = Hp.frobenius_polynomial()
                to_remove = []
                for l in to_check:
                    if p != l and 0 in witnesses[l]:
                        witnesses[l] = _update_wit(l, p, frob, f, h, witnesses[l])
                        if 0 not in witnesses[l]:
                            to_remove.append(l)
                for l in to_remove:
                    to_check.remove(l)
                if len(to_check) == 0:
                    break
        if verbose:
            return witnesses
        probably_non_surj_primes = []
        for l in L:
            if -1 in witnesses[l] or 0 in witnesses[l]:
                probably_non_surj_primes.append(l)
        return probably_non_surj_primes

    def is_surjective(self, p, bound=1000, verbose=False):
        r"""
        Return whether the mod-`p` representation is surjective onto
        `\\operatorname{Aut}(A[p]) = \\operatorname{GSp}_4(\\GF{p})`.
        The output of this function is cached.
        For the primes `p=2` and `3`, this function will always return either
        ``True`` or ``False``. For larger primes it might return ``None``.

        INPUT::

        -  ``p`` -- prime integer
        -  ``A`` -- integer; a bound on the number of `a_p` to use

        OUTPUT:: ``True`` if the mod-p representation is determined to be
        surjective, ``False`` if the representation is determined to be
        not surjection, and ``None`` if the representation is neither
        determined to be surjective nor determined to be not surjective

        EXAMPLES::

            sage: rho = EllipticCurve('37b').galois_representation()
            sage: rho.is_surjective(2)
            True
            sage: rho.is_surjective(3)
            False

        ::

            sage: rho = EllipticCurve('121a1').galois_representation()
            sage: rho.non_surjective()
            [11]
            sage: rho.is_surjective(5)
            True
            sage: rho.is_surjective(11)
            False
            sage: rho = EllipticCurve('121d1').galois_representation()
            sage: rho.is_surjective(5)
            False
            sage: rho.is_surjective(11)
            True

        Here is a case in which the algorithm does not return an answer::

            sage: rho = EllipticCurve([0,0,1,2580,549326]).galois_representation()
            sage: rho.is_surjective(7)

        In these cases, one can use image_type to get more information about the image::

            sage: rho.image_type(7)
            'The image is contained in the normalizer of a split Cartan group.'

        .. NOTE::

            1. If `p \\geq 5` then the mod-p representation is
            surjective if and only if the p-adic representation is
            surjective. When `p = 2, 3` there are
            counterexamples. See papers of Dokchitsers and Elkies
            for more details.
        """
        # TODO: Add the papers of Dokchitsers and Elklies in the master
        # bibliography file; consider adding the reference to these papers
        # in the module docstring instead.

        if not self._A.geometric_endomorphism_ring_is_ZZ():
            raise NotImplementedError(
                "Currently surjectivity can only be determined if the Jacobian has no extra endomorphisms, but this Jacobian does have such."
            )

        if self.non_surjective_primes is not None:
            if not p.is_prime():
                raise ValueError("p must be prime")
            return p not in self.non_surjective_primes

        ans = self.find_surj_from_list(L=[p], bound=1000, verbose=False)

        if ans:
            return False
        else:
            return True

    def non_surjective(self, N=None, bound=1000):
        r"""
        Returns a list of primes p such that the mod-p representation
        *might* not be surjective. If `p` is not in the returned list,
        then the mod-p representation is provably surjective.
        By a theorem of Serre, there are only finitely
        many primes in this list, except when the curve has
        complex multiplication.
        If the curve has CM, we simply return the
        sequence [0] and do no further computation.

        INPUT::

        - ``A`` -- an integer (default: `1000`); by increasing this parameter
          the resulting set might get smaller.

        OUTPUT::
        
        A list; if the curve has CM, returns [0].
        Otherwise, returns a list of primes where mod-p representation is
        very likely not surjective. At any prime not in this list, the
        representation is definitely surjective.

        EXAMPLES::

            sage: E = EllipticCurve([0, 0, 1, -38, 90])  # 361A
            sage: E.galois_representation().non_surjective()   # CM curve
            [0]

        ::

            sage: E = EllipticCurve([0, -1, 1, 0, 0]) # X_1(11)
            sage: E.galois_representation().non_surjective()
            [5]
            sage: E = EllipticCurve([0, 0, 1, -1, 0]) # 37A
            sage: E.galois_representation().non_surjective()
            []
            sage: E = EllipticCurve([0,-1,1,-2,-1])   # 141C
            sage: E.galois_representation().non_surjective()
            [13]

        ::

            sage: E = EllipticCurve([1,-1,1,-9965,385220]) # 9999a1
            sage: rho = E.galois_representation()
            sage: rho.non_surjective()
            [2]
            sage: E = EllipticCurve('324b1')
            sage: rho = E.galois_representation()
            sage: rho.non_surjective()
            [3, 5]
            
        ALGORITHM::

        We first find an upper bound `B` on the possible primes. If `E`
        is semi-stable, we can take `B=11` by a result of Mazur. There is
        a bound by Serre in the case that the `j`-invariant is not integral
        in terms of the smallest prime of good reduction. Finally
        there is an unconditional bound by Cojocaru, but which depends
        on the conductor of `E`.
        For the prime below that bound we call ``is_surjective``.
        """
        # TODO Add the results of Mazur, Serre, and Cojocaru in Sage's master
        # bibliography file and cite them here.
        if self.non_surjective_primes is not None:
            return self.non_surjective_primes

        if not self._A.geometric_endomorphism_ring_is_ZZ():
            raise NotImplementedError(
                "Currently surjectivity can only be determined if the Jacobian has no extra endomorphisms, but this Jacobian does have such."
            )

        C = self._A.curve()

        M1p3 = 0
        y1p3 = 0
        M2p2nsd = 0
        y2p2nsd = 0

        f, h = C.hyperelliptic_polynomials()
        red_data = genus2reduction(h, f)
        poor_cond = 2 * prod(red_data.local_data.keys())

        if N is None:
            N = (
                red_data.conductor
            )  # is this the true conductor if red_data.prime_to_2_conductor_only is False?
            max_cond_exp_2 = None
            if red_data.prime_to_2_conductor_only:
                # I think this is the case where we don't know exactly the two-part of conductor
                N = 2 * N
                max_cond_exp_2 = red_data.minimal_disc.valuation(2)

        # MCusp is a list of the form <S,M,y>, where S is either a space of cusp forms or
        # a level, M is an integer such that all primes with a reducible sub isomorphic to the
        # rep of a cusp form in S divide M, y is a counter for the number of nontrivial Frobenius
        # conditions go into M
        MCusp = set_up_cuspidal_spaces(N, max_cond_exp_2=max_cond_exp_2)

        # MQuad is a list of the form <phi,M,y>, where phi is a quadratic character, M is the integer
        # all nonsurjective primes governed by phi must divide, and y is counter for the number of nontrivial
        # Frobenius conditions going into M
        MQuad = set_up_quadratic_chars(N)

        d = maximal_square_divisor(N)

        # we'll test as many p as we need to get at least 2 nontrivial Frobenius conditions for every
        # possible cause of non-surjectivity
        sufficient_p = False

        p = 1

        while not sufficient_p:
            p = ZZ(p).next_prime()
            if poor_cond % p != 0:
                Cp = C.change_ring(GF(p))
                fp = Cp.frobenius_polynomial()
                fp_rev = Cp.zeta_function().numerator()

                f = Zmod(d)(p).multiplicative_order()
                c = gcd(f, 120)
                c = lcm(c, 8)  # adding in the max power of 2
                tp = -fp.coefficients(sparse=False)[3]
                sp = fp.coefficients(sparse=False)[2]

                M1p3, y1p3 = rule_out_1_plus_3_via_Frob_p(c, p, tp, sp, M1p3, y1p3)
                M2p2nsd, y2p2nsd = rule_out_2_plus_2_nonselfdual_via_Frob_p(
                    c, p, tp, sp, M2p2nsd, y2p2nsd
                )
                MCusp = rule_out_cuspidal_spaces_using_Frob_p(p, fp_rev, MCusp)
                MQuad = rule_out_quadratic_ell_via_Frob_p(p, fp, MQuad)

            if (M1p3 == 1) or (y1p3 > 1):
                if (M2p2nsd == 1) or (y2p2nsd > 1):
                    if all((Mq == 1 or yq > 1) for phi, Mq, yq in MQuad):
                        if all((Mc == 1 or yc > 1) for S, Mc, yc in MCusp):
                            sufficient_p = True

            # Stop the code if we haven't found helpful information from all Frobenius elements up to 1000
            if p > 1000:
                raise RuntimeError("Couldn't pass all tests with aux primes < 1000")

        # we will always include the bad primes.
        non_maximal_primes = set([p[0] for p in list(N.factor())])

        # we will always include the primes 2,3,5,7
        non_maximal_primes = non_maximal_primes.union({2, 3, 5, 7})

        ell_red_1p3 = M1p3.prime_factors()
        non_maximal_primes = non_maximal_primes.union(set(ell_red_1p3))

        ell_red_2p2 = M2p2nsd.prime_factors()
        non_maximal_primes = non_maximal_primes.union(set(ell_red_2p2))

        ell_red_cusp = [(S.level(), ZZ(M).prime_factors()) for S, M, y in MCusp]
        non_maximal_primes = non_maximal_primes.union(
            set([p for a, j in ell_red_cusp for p in j])
        )

        ell_irred = [(phi, ZZ(M).prime_factors()) for phi, M, t in MQuad]
        non_maximal_primes = non_maximal_primes.union(
            set([p for a, j in ell_irred for p in j])
        )

        self.non_surjective_primes = self.find_surj_from_list(
            L=non_maximal_primes, bound=bound
        )
        return self.non_surjective_primes
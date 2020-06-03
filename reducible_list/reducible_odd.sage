"""reducible_odd.sage

Given a genus 2 curve, return a finite list of primes ell containing all primes for which the mod ell representation is reducible with an odd-dimensional subquotient

"""

#computes the formulas for the polynomials whose roots are the 
#2nd, 3rd, and 5th power of the roots of a degree 4 polynomial

R = QQ['a, b, c, d']

SF = SymmetricFunctions(QQ)
e = SF.e()

def _coeff_t(n):
	return e.from_polynomial(a^n + b^n + c^n + d^n).restrict_parts(4)

def _coeff_s(n):
	return e.from_polynomial(a^n*b^n + a^n*c^n + a^n*d^n + b^n*c^n + b^n*d^n  + c^n*d^n).restrict_parts(4)

#returns:
#sage: _coeff_t(2)
#e[1, 1] - 2*e[2]
#sage: _coeff_s(2)
#e[2, 2] - 2*e[3, 1] + 2*e[4]
#sage: _coeff_t(3)
#e[1, 1, 1] - 3*e[2, 1] + 3*e[3]
#sage: _coeff_s(3)
#e[2, 2, 2] - 3*e[3, 2, 1] + 3*e[3, 3] + 3*e[4, 1, 1] - 3*e[4, 2]
#sage: _coeff_t(5)
#e[1, 1, 1, 1, 1] - 5*e[2, 1, 1, 1] + 5*e[2, 2, 1] + 5*e[3, 1, 1] - 5*e[3, 2] - 5*e[4, 1]
#sage: _coeff_s(5)
#e[2, 2, 2, 2, 2] - 5*e[3, 2, 2, 2, 1] + 5*e[3, 3, 2, 1, 1] + 5*e[3, 3, 2, 2] - 5*e[3, 3, 3, 1] + 5*e[4, 2, 2, 1, 1] - 5*e[4, 2, 2, 2] - 5*e[4, 3, 1, 1, 1] - 5*e[4, 3, 2, 1] + 5*e[4, 3, 3] + 5*e[4, 4, 1, 1] + 5*e[4, 4, 2]

#the following three functions implement the following for n=2,3,5:
#f(x) = x^4 - t*x^3 + s*x^2 - p^alpha*t*x + p^(2*alpha) is a
#degree 4 polynomial whose roots multiply in pairs to p^alpha
#returns the tuple (p, tn, sn, alphan) of the polynomial
#f^(n)(x) = x^4 - tn*x^3 + sn*x^2 - p^(alphan)*tn*x + p^(2*alphan)
#whose roots are the nth powers of the roots of f

def power_roots2((p, t , s, alpha)):
	return (p, t^2 - 2*s, s^2 - 2*p^alpha*t^2 + 2*p^(2*alpha), 2*alpha)

def power_roots3((p, t, s, alpha)):
	return (p, t^3 - 3*s*t + 3*p^alpha*t, s^3 - 3*p^alpha*s*t^2 + 3*p^(2*alpha)*t^2 + 3*p^(2*alpha)*t^2 - 3*p^(2*alpha)*s, 3*alpha)

def power_roots5((p, t, s, alpha)):
	return (p, t^5 - 5*s*t^3 + 5*s^2*t + 5*p^alpha*t^3 - 5*p^alpha*s*t - 5*p^(2*alpha)*t, s^5 - 5*p^alpha*s^3*t^2 + 5*p^(2*alpha)*s*t^4 + 5*p^(2*alpha)*s^2*t^2 - 5*p^(3*alpha)*t^4 + 5*p^(2*alpha)*s^2*t^2 - 5*p^(2*alpha)*s^3 - 5*p^(3*alpha)*t^4 - 5*p^(3*alpha)*s*t^2 + 5*p^(4*alpha)*t^2 + 5*p^(4*alpha)*t^2 + 5*p^(4*alpha)*s, 5*alpha)


#puts these together to do n=120
def power_roots12((p, t, s, alpha)):
	return power_roots2(power_roots2(power_roots2(power_roots3(power_roots5((p,t,s,alpha))))))

#given a quartic f whose roots multiply to p^alpha in pairs,
#returns the quartic whose roots are the products of roots
#of f that DO NOT multiply to p^alpha
def roots_pairs_not_p((p, t, s, alpha)):
	return (p, s - 2*p, p*t^2 - 2*p*s + 2*p^2, 2*alpha)

#t and s are the first and second elementary symmetric functions in the
#roots of the characteristic polynomial of Frobenius at p
def rule_out_1_plus_3_via_Frob_p(p, t, s, M):
	p, t12, s12, alpha12 = power_roots12((p, t, s, 1))
	P12(x) = x^4 - t12*x^3 + s12*x^2 - p^alpha12*t12*x + p^(2*alpha12)
	#print P12(1), P12(p^120)
	return gcd(M, P12(1)*P12(p^120))

def rule_out_2_plus_2_nonselfdual_via_Frob_p(p, t, s, M):
	p, tnew, snew, alphanew = power_roots12(roots_pairs_not_p((p, t, s, 1)))
	Pnew(x) = x^4 - tnew*x^3 + snew*x^2 - p^alphanew*tnew*x + p^(2*alphanew)
	return gcd(M, Pnew(1)*Pnew(p^120)*Pnew(p^240))

#very minimal working example
x = QQ['x'].gen()
f = x^6 - x^3 - x + 1
C = HyperellipticCurve(f,0)
Naway2 = genus2reduction(0,f).conductor
p=11
Cp = C.change_ring(GF(p))
fp = Cp.frobenius_polynomial()
tp = - fp.coefficients()[3]
sp = fp.coefficients()[2]
M0 = 0
for p in prime_range(7, 100):
	if p != 23:
		M0 = rule_out_1_plus_3_via_Frob_p(p, tp, sp, M0)
M0

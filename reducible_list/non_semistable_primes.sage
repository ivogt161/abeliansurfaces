"""non_semistable_primes.sage

Given a genus 2 curve, return the non semistable primes.

"""

R.<x> = QQ[]
Q_x = 0
P_x = x^5 + 17
J = genus2reduction(Q_x, P_x)  # the curve y^2 + Q_x * x = P_x
R.local_data()
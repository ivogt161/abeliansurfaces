#must have files nonmaximal.sage, test_ell.sage, and g2c_curves_list.sage
#loaded in the sage terminal to run this

curves = make_data()

for C, N, label in curves:
    pot_non_surj = find_nonmaximal_primes(C, N,coeff_table = 'gamma0_wt2_hecke_lpolys_1000.txt')
    non_surj = is_surj(C, pot_non_surj)

    g = open("surj_data.txt", "a")
    g.write(label + ":" + str(list(pot_non_surj)) + ":" + str(non_surj) + "\n")
    g.close()

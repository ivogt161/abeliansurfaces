/*TorsionPrimes.m

  Use this script to generate torsion prime data:

  ls ./data/curve_data_new_may_23 | parallel -j64 "magma -b InputFileName:={} helper_scripts/TorsionPrimes.m"

  This will take the data files in `./data/curve_data_new_may_23`, and for each curve in each file,
  will generate a new file (appended with `with_torsion`) in the directory `torsion_data_out` containing
  the torsion primes. 

  In the pipeline for running the main algorithm on lots of curves, one would then use the `produce_final_output.py`
  script in the `helper_scripts` folder to combine the output of the `nonmaximal.py` algorithm with these torsion
  primes.

*/

RealInputFileName := "./data/curve_data_new_may_23/" cat InputFileName;
OutputFileName := "./torsion_data_out/" cat "with_torsion_" cat InputFileName;

LinesOfInputFile := Split(Read(RealInputFileName), "\n");
Reverse(~LinesOfInputFile);
Prune(~LinesOfInputFile);
Reverse(~LinesOfInputFile);
header:= "cond,disc,data,torsion_primes\n";
fprintf OutputFileName, header;

R<x> := PolynomialRing(Rationals());

TorsionPrimes := function(f,g);
    C := HyperellipticCurve(R!f, R!g);
    C := SimplifiedModel(C);
    J := Jacobian(C);
    the_primes := PrimeDivisors(#TorsionSubgroup(J));
    output := "";
    for p in the_primes do
        output := output cat IntegerToString(p) cat ",";
    end for;
    Prune(~output);
    return output;
end function;

for MyLine in LinesOfInputFile do
    FirstCommaPos := Position(MyLine,",");
    DataOnly := MyLine[FirstCommaPos+1..#MyLine];

    SecondCommaPos := Position(DataOnly,",");
    DataOnly := DataOnly[SecondCommaPos+1..#DataOnly];
    DataOnly:=eval(DataOnly);
    DataOnly:=eval(DataOnly);
    f,g := Explode(DataOnly);

    torsion_primes := TorsionPrimes(f,g);
    torsion_primes := "\"{" cat torsion_primes cat "}\"";
    to_print := MyLine cat "," cat torsion_primes cat "\n";
    fprintf OutputFileName, to_print;
end for;

quit;

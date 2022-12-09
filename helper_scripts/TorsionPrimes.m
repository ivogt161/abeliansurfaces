/*TorsionPrimes.m

  Use this script to generate torsion prime data.

  ls ./torsion_data_in | parallel "magma -b InputFileName:={} TorsionPrimes.m"
*/

RealInputFileName := "./torsion_data_in/" cat InputFileName;
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


// DataOnly := "[[17,7,7,11,2,2,1],[0,1,0,1]]";
/*
one_line_print := function(list);
  output := "[";
    for i in [1..#list] do
      if i eq #list then
        str := "%o]";
      else
        str := "%o,";
      end if;
      output := output cat Sprintf(str, list[i]); 
    end for;
  return output;
end function;

R<x> := PolynomialRing(RationalField());

for N in MissingLevels do
    NCF := NewSubspace(CuspForms(N));
    for p in PrimesUpTo(100) do
        pol := R!HeckePolynomial(NCF,p);
        S<a,b> := PolynomialRing(RationalField(),2);
        test:=S!Evaluate(pol,a);
        test:=Homogenization(test,b);
        test:=Evaluate(test,a,1 + p * b^2);
        pol:=Evaluate(test,a,0);
        base:=one_line_print(Reverse(Coefficients(pol)));
        to_print:=Sprintf("%o:%o",N,p);
        to_print := to_print cat ":" cat base cat "\n";
        fprintf OutputFileName, to_print;
    end for;
end for;
*/
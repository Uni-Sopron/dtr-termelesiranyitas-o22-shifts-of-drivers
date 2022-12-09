/* STIGLER, original Stigler's 1939 diet problem weight gain version */

set C;
set N;

param data{c in C, {"price", "weight"} union N};

param szuksegesmakrok{n in N};


var x{c in C}, >= 0;

s.t. nb{n in N}: sum{c in C} data[c,n] * x[c] >= szuksegesmakrok[n];



minimize cost: sum{c in C} x[c];

param days := 365;

param commodity{c in C}, symbolic;

param unit{c in C}, symbolic;

solve;


printf "\n";
printf "Tömegnövelő étrend a legolcsóbb alapanyagokból az év során napi %g dollárból\n",cost;
printf "\n";
printf "        Árucikk            Egység     Mennyiség     Ár   \n";
printf "\n";
printf{c in C: x[c] != 0} "%-25s %10s %10.2f   $%7.2f\n", commodity[c],
   unit[c], days * x[c] / data[c,"price"], days * x[c];
printf "                                         -----------------\n";
printf "                                         Total:   $%7.2f\n",
   days * sum{c in C} x[c];
printf "\n";

end;
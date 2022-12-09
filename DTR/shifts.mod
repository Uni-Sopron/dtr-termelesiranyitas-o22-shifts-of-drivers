set vezetok;
set targoncak;
set muszakok;
set egymuszak;


param ido{vezetok, targoncak} >=0;
param jogsi{vezetok, targoncak};
param dolgozike{vezetok,muszakok};

param initial_ido;

param nDays;
set Days := 1..nDays;

var vezeti{vezetok,targoncak} binary;
var dolgozik {vezetok,muszakok} binary;
var idonk {Days} >=0;



s.t. mindenki1targocat {v in vezetok}:
sum{t in targoncak} vezeti[v,t] = 1;


s.t. mindenki1muszak {v in vezetok}:
 sum{m in muszakok} dolgozik[v,m] = 1;


s.t. Initial_ido:
    idonk[1] = initial_ido + sum{v in vezetok, t in targoncak: jogsi[v,t]<>0} ido[v,t] * vezeti[v,t];


s.t. Set_ido{d in Days : d != 1}:
    idonk[d] = idonk[d-1]  + sum{v in vezetok, t in targoncak: jogsi[v,t] <>0} ido[v,t] * vezeti[v,t];


s.t. vezethetie {v in vezetok, t in targoncak : jogsi[v,t] <> 1}:
vezeti[v,t] = 0;

s.t. muszake {v in vezetok, m in muszakok : dolgozike[v,m] <> 1}:
dolgozik[v,m] = 0;


minimize time_at_end: idonk[nDays];


solve;

printf "\n\n";
printf "\n\n";


printf "Rakodással töltött idő hetente: %d\n",time_at_end;
printf "\n";


for { d in Days}
{
  
 
      printf " Rakodással töltött időnk összesen a(z) %d. munkanapig: %g\n",d,idonk[d];
printf "\n";
  }
 
 
     printf "\n";
  
    for { m in muszakok }
    {
      printf "\n";
    printf 'Műszak: %s\n',m;
    printf "\n";
    for {v in vezetok, t in targoncak: vezeti[v,t] <>0 and dolgozik[v,m] <> 0}
    {
        printf " %s -  %s - napi %g mp - heti %g mp \n ",v,t,ido[v,t],ido[v,t]*nDays;
}
  }
    end;
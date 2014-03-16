//(2^k-1)^n
program sets;
const
     mo=1000000007;
function calc(x,n:int64):int64;
begin
     calc:=1;
     while n>0 do
     begin
          if odd(n) then calc:=int64(calc*x)mod mo ;
          x:=int64(x*x);
          n:=n shr 1;
     end;
end;

procedure init;
var
   n,k,a:int64;
begin
     readln(n,k);
     a:=calc(2,k)-1;
     if a<0 then a:=int64(a+mo);
     a:=calc(a,n);
     writeln(a);
end;
begin
     assign(input,'sets.in');assign(output,'sets.out');
     reset(input);rewrite(output);

     init;

     close(input);close(output);
end.


program Project1;

var

function lowbit(i:longint):longint;
         lowbit:=i and (i xor(i-1));

procedure make;
var i,j:integer;
begin
     for i:=1 to n do
         for j:=i-lowbit(i) to i do
         c[i]:=c[i]+a[j];
end;

procedure chang(i,x:longint);
begin
     while i<n do
           begin
                c[i]:=c[i]+x;
                i:=i+lowbit(i);
           end;
end;

function sum(i:longint);
begin
     sum:=0;
         while i>0 do
         begin
              sum:=sum+c[i];
              i:=i-lowbit(i);
         end;
end;

begin

end.


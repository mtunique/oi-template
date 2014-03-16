program aa;
var
  a:array[0..10000]of longint;
  n,m,x,y,z,i,j,min:longint;
begin
     assign(input,'a.in');
     assign(output,'aa.out');
     reset(input);rewrite(output);
     readln(n,m);
     for i:=1 to n do
     read(a[i]);readln;
     for i:=1 to m do
     begin
       readln(x,y,z);
       if x=2 then a[y]:=z
       else
         begin
           min:=maxlongint;
           for j:=y to z do
           if min>a[j] then min:=a[j];
         end;
         write(min,' ');
     end;
     close(input);close(output);
end.

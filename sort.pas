program sort;
var
  a:array[1..10000000] of longint;
  i,n:longint;
procedure init;
begin
  assign(input,'sort.in');
  assign(output,'sort.out');
  reset(input);
  rewrite(output);
  readln(n);
  for i:=1 to n do
    read(a[i]);
end;
procedure qsort(l,r:longint);
var
  i,j,x,t:longint;
begin
  i:=l;
  j:=r;
  x:=a[(l+l+r) div 3];
  repeat
    while a[i]>x do inc(i);
    while a[j]<x do dec(j);
      if i<=j  then
      begin
          if a[i]<>a[j] then
             begin
             t:=a[i]; a[i]:=a[j]; a[j]:=t
             end;
          inc(i); dec(j)
      end;
  until i>j;
  if i<r then qsort(i,r);
  if j>l then qsort(l,j);
end;   
begin
  init;
  qsort(1,n);
  for i:=1 to n do
    write(a[i],' ');
  close(input);
  close(output)
end.


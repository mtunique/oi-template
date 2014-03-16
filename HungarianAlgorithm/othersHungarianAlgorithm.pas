var
  a:array[1..1000,1..1000] of boolean;
  b:array[1..1000] of longint;
  c:array[1..1000] of boolean;
  n,k,i,x,y,ans,m:longint;
 
function path(x:longint):boolean;
var
  i:longint;
begin
  for i:=1 to n do
  if a[x,i] and not c[i] then
  begin
	c[i]:=true;
	if (b[i]=0) or path(b[i]) then
	begin
	  b[i]:=x;
	  exit(true);
	end;
  end;
  exit(false);
end;
 
procedure hungary;
var
  i:longint;
begin
  fillchar(b,sizeof(b),0);
  for i:=1 to m do
  begin
	fillchar(c,sizeof(c),0);
	if path(i) then inc(ans);
  end;
end;
 
begin
  fillchar(a,sizeof(a),0);
  readln(m,n,k);
  for i:=1 to k do
  begin
	readln(x,y);
	a[x,y]:=true;
  end;
  ans:=0;
  hungary;
  writeln(ans);
end.
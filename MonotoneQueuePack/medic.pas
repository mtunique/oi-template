program medic;
var
   a:array[0..10,0..10]of longint;
   num,w,v:array[0..200]of longint;
   f,zhi,hao:array[0..110000]of longint;
   ge,m:longint;
procedure dp;
var
   y,l,r,mo,j,i,temp:longint;
begin
     for i:=1 to ge do
     begin
          if m div v[i]<num[i] then num[i]:=m div v[i];
          for mo:=0 to v[i]-1 do
          begin
               l:=1;r:=0;
               temp:=(m-mo)div v[i];
               for j:=0 to temp do
               begin
                    y:=f[v[i]*j+mo]-w[i]*j;
                    while(l<=r)and(zhi[r]<=y) do dec(r);
                    inc(r);zhi[r]:=y;hao[r]:=j;
                    if j-hao[l]>num[i] then inc(l);
                    f[v[i]*j+mo]:=zhi[l]+w[i]*j;
               end;
          end;
     end;
     writeln(f[m]);
end;

procedure init;
var
   i,n,x,y,j:longint;
begin
     readln(n,m);
     for i:=1 to n do
     begin
          readln(x,y);
          inc(a[x,y]);
     end;

     ge:=0;
     for i:=1 to 10 do
     for j:=1 to 10 do
     if a[i,j]>0 then
     begin
          inc(ge);
          v[ge]:=i;w[ge]:=j;num[ge]:=a[i,j];
     end;
     dp;
end;

begin
     assign(input,'medic.in');assign(output,'medic.out');
     reset(input);rewrite(output);

     init;

     close(input);close(output);
end.


program dancinglessons;
var
   a:array[0..410000]of record
   x,y,d:longint;
   end;
   c:array[0..210000]of char;
   data,next,pre:array[0..210000]of longint;
   ans:array[0..410000]of record
   x,y:longint;
   end;
   u:array[0..210000]of boolean;
   zz,ge:longint;
procedure insert(x,y,z:longint);
var
   i:longint;
begin
     inc(ge);
     i:=ge;
     while i>1 do
     begin
          if(z<a[i shr 1].d)or(z=a[i shr 1].d)and(x<a[i shr 1].x) then
          begin
               a[i]:=a[i shr 1];i:=i shr 1;
          end
          else break;
     end;
     a[i].x:=x;a[i].y:=y;a[i].d:=z;
end;

procedure delete;
var
   i,j,x,z:longint;
begin
     x:=a[ge].x;z:=a[ge].d;
     dec(ge);
     i:=1;
     while i*2<=ge do
     begin
          j:=i shl 1;
          if(j+1<=ge)and((a[j].d>a[j+1].d)or(a[j].d=a[j+1].d)and(a[j].x>a[j+1].x))
          then inc(j);
          if(z>a[j].d)or(z=a[j].d)and(x>a[j].x) then
          begin
               a[i]:=a[j];i:=j;
          end
          else
          break;
     end;
     a[i]:=a[ge+1];
end;

procedure pop;
begin
     while(u[a[1].x])or(u[a[1].y])and(ge>0)do
     delete;
     if ge>0 then
     begin
     inc(zz);
     ans[zz].x:=a[1].x;ans[zz].y:=a[1].y;
     u[ans[zz].x]:=true;u[ans[zz].y]:=true;
     delete;
     if(pre[ans[zz].x]<>0)and(next[ans[zz].y]<>0)and
     (c[pre[ans[zz].x]]<>c[next[ans[zz].y]])then
     insert(pre[ans[zz].x],next[ans[zz].y],abs(data[pre[ans[zz].x]]-data[next[ans[zz].y]]));
     pre[next[ans[zz].y]]:=pre[ans[zz].x];
     next[pre[ans[zz].x]]:=next[ans[zz].y];
     end;
end;

procedure init;
var
   n,i,j:longint;
begin
     readln(n);
     for i:=1 to n do
          read(c[i]);

     for i:=1 to n-1 do
     next[i]:=i+1;
     for i:=2 to n do
     pre[i]:=i-1;

     for i:=1 to n do
     read(data[i]);

     for i:=1 to n-1 do
     if c[i]<>c[i+1] then
     insert(i,i+1,abs(data[i]-data[i+1]));

     zz:=0;
     while ge>0 do
     pop;
     writeln(zz);
     for i:=1 to zz do
     writeln(ans[i].x,' ',ans[i].y);
end;

begin
     assign(input,'dancinglessons.in');assign(output,'dancinglessons.out');
     reset(input);rewrite(output);

     init;

     close(input);close(output);
end.


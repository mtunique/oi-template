const maxn=500000;
var
     b,use:array[0..maxn]of boolean;
     v,nex,pre,c,l,r:array[0..maxn]of longint;
     ans1,ans2:array[0..maxn]of longint;
     ch:char;ans,top,n,i:longint;
var tmp:longint;
procedure swap(var x,y:longint);
begin
    tmp:=x;x:=y;y:=tmp;
end;
procedure Updata(i:longint);
var j:longint;
begin
    while i>1 do
          begin
          j:=i>>1;
          if (c[j]>c[i])or((c[j]=c[i])and(l[j]>l[i])) then
             begin
             swap(c[j],c[i]);
             swap(l[j],l[i]);
             swap(r[j],r[i]);
             end else break;
          i:=j;
          end;
end;
procedure Downdata(i:longint);
var j:longint;
begin
    while 2*i<=top do
          begin
          j:=i<<1;
          if (j+1<=top)and((c[j]>c[j+1])or((c[j]=c[j+1])and(l[j]>l[j+1]))) then inc(j);
          if (c[j]<c[i])or((c[j]=c[i])and(l[j]<l[i])) then
             begin
             swap(c[j],c[i]);
             swap(l[j],l[i]);
             swap(r[j],r[i]);
             end else break;
          i:=j;
          end;
end;
procedure add(x,y:longint);
begin
    inc(top);
    c[top]:=abs(v[x]-v[y]);
    l[top]:=x;
    r[top]:=y;
    Updata(top);
end;
procedure dele;
begin
    c[1]:=c[top];
    l[1]:=l[top];
    r[1]:=r[top];
    dec(top);
    Downdata(1);
end;
begin
   assign(input,'dancinglessons.in');
   assign(output,'dancinglessons2.out');
   reset(input);
   rewrite(output);
   readln(n);
   for i:=1 to n do
       begin
       read(ch);
       b[i]:=(ch='B');
       end;
   readln;
   for i:=1 to n do
       read(v[i]);
   for i:=1 to n do
       begin
       nex[i]:=i+1;
       pre[i]:=i-1;
       end;
   top:=0;
   for i:=1 to n-1 do
       if b[i]xor b[i+1] then add(i,i+1);
   fillchar(use,sizeof(use),0);
   ans:=0;
   while top>0 do
         begin
         if use[l[1]] or use[r[1]] then
            begin
            dele;
            continue;
            end;
         use[l[1]]:=true;
         use[r[1]]:=true;
         inc(ans);
         ans1[ans]:=l[1];
         ans2[ans]:=r[1];
         dele;
         if (ans1[ans]=1) or (ans2[ans]=n) then continue;
         nex[pre[ans1[ans]]]:=nex[ans2[ans]];
         pre[nex[ans2[ans]]]:=pre[ans1[ans]];
         if b[pre[ans1[ans]]]xor b[nex[ans2[ans]]] then
            add(pre[ans1[ans]],nex[ans2[ans]]);
         end;
   writeln(ans);
   for i:=1 to ans do
       writeln(ans1[i],' ',ans2[i]);
   close(input);
   close(output);
end.



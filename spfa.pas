program magic;
const
     maxn=600*600;
var
   dis,ci,a,head:array[0..660] of longint;
   dui:array[0..600*600]of longint;
   u:array[0..660]of boolean;
   d,v,next:array[0..6000]of longint;
   hp,num,n:longint;
procedure add(x,y,z:longint);
begin
     inc(num);v[num]:=y;d[num]:=z;next[num]:=head[x];head[x]:=num;
end;

procedure print;
var
   x,i:longint;
begin
     for x:=0 to n do
     begin
          writeln(x);
          i:=head[x];
          while i<>0 do
          begin
               write(v[i],':',d[i],';');
               i:=next[i];
          end;
          writeln;
     end;
     writeln;
end;

function can(cd:longint):boolean;
var
   y,i,t,w:longint;
begin
     fillchar(head,sizeof(head),0);
     num:=0;
     for i:=1 to n do
     if a[i]-hp>=0 then
     begin
          y:=(a[i]-hp)div 15;
          add(i-1,y,-1)
     end;
     for i:=1 to n do
     add(i,i-1,0);

     for i:=cd to n do
     add(i-cd,i,1);

     fillchar(dis,sizeof(dis),$7f);
     fillchar(ci,sizeof(ci),0);
     fillchar(u,sizeof(u),false);
     dui[1]:=0; dis[0]:=0;ci[0]:=1;
     t:=0;w:=1;

     if cd=2 then begin  writeln('cd=2');print;end;
     if cd=1 then begin  writeln('cd=1');print;end;

     while t<>w do
     begin
          t:=t mod maxn +1;
          i:=head[dui[t]];
          while i<>0 do
          begin
                if dis[dui[t]]+d[i]<dis[v[i]] then
                begin                     
                     dis[v[i]]:=dis[dui[t]]+d[i];                     
                     if not u[v[i]] then
                     begin
                          w:=w mod maxn +1;
						  inc(ci[v[i]]);
						  if ci[v[i]]>n then exit(false);
                          dui[w]:=v[i];u[v[i]]:=true;
                     end;
                end;
               i:=next[i];
          end;
          u[dui[t]]:=false;
     end;
     if w<=n*n then exit(true) else exit(false);
end;

procedure init;
var
   i,l,r,mid,x:longint;
begin
     readln(n,hp);
     for i:=1 to n do
     begin
          a[i]:=a[i-1];
          read(x);
          a[i]:=a[i]+x;
     end;
     l:=0;r:=n+1;
     while l<r do
     begin
          mid:=(l+r)>>1;
          if can(mid) then l:=mid+1 else r:=mid;
     end;
     if r=n+1 then writeln('No upper bound.')
     else writeln(r-1)
end;

begin
     assign(input,'magic.in');assign(output,'magic.out');
     reset(input);rewrite(output);

     init;

     close(input);close(output);
end.


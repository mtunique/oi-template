program magic;
const
     maxn=600*600;
var
   a,dis:array[0..660] of longint;
   bian:array[0..30000]of record
   x,y,z:longint;
   end;

   u:array[0..660]of boolean;
   d,v,next:array[0..6000]of longint;
   hp,num,n:longint;
procedure add(x,y,z:longint);
begin
     inc(num);bian[num].x:=x;
     bian[num].y:=y;
     bian[num].z:=z;
end;

{procedure print;
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
end; }

function can(cd:longint):boolean;
var
   y,i,t,w,ci:longint;   flag:boolean;
begin

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
     dis[0]:=0;
     flag:=true;
     ci:=0;
     while flag do
     begin
          flag:=false;
          inc(ci);
          if ci>n+1 then break;
          for i:=1 to num do
          if dis[bian[i].y]>dis[bian[i].x]+bian[i].z then
          begin
               dis[bian[i].y]:=dis[bian[i].x]+bian[i].z;
               flag:=true;
          end;
     end;

     if ci>n+1 then exit(false) else exit(true);
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


program manger;
const
        maxn=1000;
        maxm=300*300;
        mo=10000;
type
    minmax=object
           dis,fa,head : array[0..maxn]of longint;
                     u : array[0..maxn]of boolean;
            next,v,d,f : array[0..maxm]of longint;
                   dui : array[0..mo]of longint;
                ge,s,t : longint;
           constructor init(x,y:longint);
           function main:longint;
           function spfa(x:longint):longint;
           procedure aug;
           procedure add(x,y,a,c:longint);
    end;

var
   n:longint;
   m:minmax;
   a:array[1..maxn,1..maxn]of longint;
   sum:array[1..maxn]of longint;
procedure minmax.add(x,y,a,c:longint);
begin
     inc(ge);next[ge]:=head[x];head[x]:=ge;v[ge]:=y;d[ge]:=a;f[ge]:=c;
     inc(ge);next[ge]:=head[y];head[y]:=ge;v[ge]:=x;d[ge]:=-a;f[ge]:=0;
end;

constructor minmax.init(x,y:longint);
begin
     ge:=1;
     s:=x;t:=y;
     fillchar(head,sizeof(head),0);
     fillchar(next,sizeof(next),0);
end;

function minmax.spfa(x:longint):longint;
var
   y,tou,wei,i:longint;
begin
     fillchar(dis,sizeof(dis),$3f);
     fillchar(u,sizeof(u),false);
     dis[x]:=0;
     
     tou:=0;wei:=1;
     dui[tou]:=x;
     
     u[x]:=true;
     fa[s]:=0;
     repeat
           x:=dui[tou];
           i:=head[x];
           inc(tou);
           if tou=mo then tou:=0;
           while i<>0 do
           begin
                y:=v[i];
                if(f[i]>0)and(dis[x]+d[i]<dis[y])then
                begin
                     dis[y]:=dis[x]+d[i];
                     fa[y]:=i xor 1;
                     if not u[y] then
                     begin
                          if dis[y]>dis[dui[tou]]then
                          begin
                          dui[wei]:=y;
                          inc(wei);if wei=mo then wei:=0;
                          end
                          else
                          begin
                          dec(tou);if tou<0 then tou:=mo-1;
                          dui[tou]:=y;
                          end;
                          u[y]:=true;
                     end;
                end;
                i:=next[i];
           end;
           u[x]:=false;
     until tou=wei;
     exit(dis[t]);
end;

procedure minmax.aug;
var
   x,y:longint;
begin
     y:=t; x:=fa[t];
     while x<>0 do
     begin
          dec(f[fa[x] xor 1]);
          inc(f[fa[x]]);
          y:=x;x:=v[fa[y]];
     end;
end;

function minmax.main:longint;
var
   cost,x:longint;
begin
     cost:=0;
     x:=spfa(s);
     while x<>1061109567 do
     begin
     aug;
     inc(cost,x);spfa(s);end;
     exit(cost);
end;

procedure init;
var
   i,j:longint;
begin
     assign(input,'manger.in');reset(input);
     assign(output,'manger.out');rewrite(output);
     readln(n);
     m.init(0,n*3+1);
     
     for i:=1 to n do
     begin
         for j:=1 to n do
         begin
              read(a[i,j]);
              inc(sum[j],a[i,j]);
         end;
         readln;
     end;
     
     for i:=1 to n do
     begin
         m.add(0,i,0,1);
         m.add(i+n,i+n*2,0,1);
         m.add(i+n*2,n*3+1,0,1);
         for j:=1 to n do
         m.add(i,j+n,sum[i]-a[i,j],1);
     end;
     close(input);
     writeln(m.main);
end;

begin
     init;
end.


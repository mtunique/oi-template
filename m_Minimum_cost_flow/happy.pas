program happy;
const
        maxn=30000;
        maxm=1500*1050;
        mo=10000000;
type
    minmax=object
           dis,fa,head : array[0..maxn]of longint;
                     u : array[0..maxn]of boolean;
            next,v,d,f : array[0..maxm]of longint;
                   dui : array[0..mo]of longint;
                ge,s,t : longint;
           constructor init(x,y:longint);
           function main:longint;
           function main2(m:longint):longint;
           function spfa(x:longint):longint;
           procedure aug;
           procedure print;
           procedure add(x,y,a,c:longint);
    end;

var
   n,t,mm:longint;
   a:array[0..85,0..85]of longint;
   m:minmax;
   
procedure minmax.print;
var
   i,x:longint;
begin
     for x:=s to t do
     begin
          i:=head[x];
          writeln(x,':');
          while i<>0 do
          begin
               writeln('   ',v[i],' ',f[i],' ',d[i]);
               i:=next[i];
          end;
     end;
end;

procedure minmax.add(x,y,a,c:longint);
begin
     inc(ge);next[ge]:=head[x];head[x]:=ge;v[ge]:=y;d[ge]:=c;f[ge]:=a;
     inc(ge);next[ge]:=head[y];head[y]:=ge;v[ge]:=x;d[ge]:=-c;f[ge]:=0;
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
     fillchar(fa,sizeof(fa),0);
     dis[x]:=0;

     tou:=1;wei:=1;
     dui[tou]:=x;

     u[x]:=true;
     fa[s]:=0;
     repeat
           x:=dui[tou];
           i:=head[x];
           inc(tou);
           while i<>0 do
           begin
                y:=v[i];
                if(f[i]>0)and(dis[x]+d[i]<dis[y])then
                begin
                     dis[y]:=dis[x]+d[i];
                     fa[y]:=i xor 1;
                     if not u[y] then
                     begin
                          inc(wei);
                          dui[wei]:=y;
                          u[y]:=true;
                     end;
                end;
                i:=next[i];
           end;
           u[x]:=false;
     until tou>wei;
     exit(dis[t]);
end;

procedure minmax.aug;
var
   x,y:longint;
begin
     y:=t; x:=v[fa[t]];
     while x<>0 do
     begin
          dec(f[fa[y] xor 1]);
          inc(f[fa[y]]);
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
     inc(cost,x);x:=spfa(s);end;
     exit(cost);
end;
function minmax.main2(m:longint):longint;
var
   cost,x:longint;
begin
     cost:=0;
     x:=spfa(s);
     while x<>1061109567 do
     begin
     aug;
     inc(cost,x);dec(m);if m=0 then break;x:=spfa(s);end;
     exit(cost);
end;

procedure init;
var
   i,j,box:longint;
begin
     assign(input,'happy.in');reset(input);
     assign(output,'happy.out');rewrite(output);
     readln(n,mm);
     
     t:=(mm+mm+n-1)*n div 2;
     m.init(0,t*2+1);
     
     box:=0;
     
     for i:=1 to mm do
     m.add(0,i*2-1,1,0);
     
     for i:=1 to n-1 do
     begin
          for j:=1 to mm+i-1 do
          begin
               read(a[i,j]);
               inc(box);
               m.add(box,box+1,1,a[i,j]);
               m.add(box+1,box+mm*2+i*2-2,1,0);
               m.add(box+1,box+mm*2+i*2,1,0);
               inc(box);
          end;
          readln;
     end;
     for j:=1 to mm+n-1 do
          begin
               read(a[n,j]);
               inc(box);
               m.add(box,box+1,1,a[n,j]);
               m.add(box+1,t*2+1,1,0);
               inc(box);
          end;
          


     writeln(m.main);
     m.init(0,t+1);
     
     for i:=1 to mm do
     m.add(0,i,2,a[1,i]);
     
     box:=0;
     for i:=1 to n-1 do
         for j:=1 to mm+i-1 do
         begin
              inc(box);
              m.add(box,box+mm+i-1,1,a[i+1,j]);
              m.add(box,box+mm+i,  1,a[i+1,j+1]);
         end;
     for i:=1 to n+mm-1 do
     begin
     inc(box);
     m.add(box,t+1,mm,0);
     end;
     //m.print;
     writeln(m.main2(mm));
     close(input);close(output);
end;

begin
     init;
end.


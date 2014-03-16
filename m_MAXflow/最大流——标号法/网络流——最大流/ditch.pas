Const Maxn=200;
type
  nettype=record
    C,F:longint;
    end;
  nodetype=record
    L,P:integer;
    end;
var
  L:array[0..maxn] of nodetype;
  G:Array[0..Maxn,0..Maxn] of Nettype;
  N,S,T,m:integer;
  
procedure init;
var
   i,z,y,x:longint;
begin
     readln(m,n);
     fillchar(g,sizeof(g),0);
     for i:=1 to m do
     begin
          readln(x,y,z);
          inc(g[x,y].c,z);
     end;
end;

function find:integer;
var
   i:longint;
begin
     for i:=1 to n do
     if(l[i].l<>0)and(l[i].p=0) then exit(i);
     exit(0);
end;

function ford(var a:longint):boolean;
var
i,j,m:longint;
begin
     ford:=true;
     fillchar(l,sizeof(l),0);
     l[s].l:=s;
     repeat
           i:=find;
           if i=0 then exit;
            for j:=1 to n do
           if(l[j].l=0)and((G[I,J].C<>0)or(G[J,I].C<>0))then
           begin
                if g[i,j].c>g[i,j].f then l[j].l:=i;
                if g[j,i].f>0 then l[j].l:=-i;
           end;
           l[i].p:=1;
     until l[t].l<>0;
     m:=t; a:=maxlongint;
     
     repeat
           j:=m;m:=abs(l[j].l);
           if(l[j].l>0)and(a>g[m,j].c-g[m,j].f)then a:=g[m,j].c-g[m,j].f;
           if(l[j].l<0)and(a>g[j,m].f)then a:=g[j,m].f;
     until m=s;
     exit(false);
end;

procedure change(a:longint);
var
   i,j:Longint;
begin
     i:=t;
     repeat
           j:=i;i:=abs(l[j].l);
           if l[j].l>0 then g[i,j].f:=g[i,j].f+a;
           if l[j].l<0 then g[j,i].f:=g[j,i].f-a;
     until i=s;
end;

procedure print;
var
   ans,i:longint;
begin
     ans:=0;
     for i:=1 to n do
     ans:=ans+g[i,t].f;
     writeln(ans);
end;

procedure main;
var
   del:longint;
   succ:boolean;
begin
     s:=1;t:=n;
     repeat
           succ:=ford(del);
           if not succ then change(del)
           else
           print;
     until succ;
end;


begin
     assign(input,'ditch.in');assign(output,'ditch.out');
     reset(input);rewrite(output);
     init;
     main;
     close(input);close(output);
end.


type
    un=object
             fa:array[0..maxn]of longint;
             function find(x:longint):Longint;
             function calc(t,w:longint):longint;
             procedure union(a,b:longint);
             constructor init;
    end;
    
var
   u:un;
   a:array[1..26]of integer;
   b:array[1..26]of longint;
   st,st2:array[0..maxn]of longint;
   sum,k:longint;
   //s1,s2:array[0..maxn]of char;
    
function un.calc(t,w:longint):longint;
var
   ans,i:longint;
begin
     ans:=0;
     for i:=t to w do
     begin
     find(i);
     if fa[i]=0 then inc(ans);
     end;
     exit(ans);
end;

function un.find(x:longint):longint;
var
   i,j,t:longint;
begin
     i:=x;
     while fa[i]<>0 do i:=fa[i];
     j:=x;
     while fa[j]<>0 do begin t:=j;j:=fa[j];fa[t]:=i;end;
     exit(i);
end;

constructor un.init;
begin
     fillchar(fa,sizeof(fa),0);
end;

procedure un.union(a,b:longint);
var
   x,y:longint;
begin
     x:=find(a);y:=find(b);
     if x<>y then
     if x<y then
          fa[y]:=x
     else
          fa[x]:=y;

end;

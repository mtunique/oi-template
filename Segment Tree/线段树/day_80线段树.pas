const maxn=4000000;
      maxm=10000000;
var tree,rev:array[0..2*maxn]of longint;
    n,m,p,q,i,j,x,y:longint;
function max(x,y:longint):longint;
begin
     if x>y then exit(x) else exit(y);
end;
procedure swap(var x,y:longint);
var k:longint;
begin
     k:=x;
     x:=y;
     y:=k;
end;

procedure paint(x,i:longint);
begin
     if x>4*n then exit;
     rev[x]:=i;
     tree[x]:=i;
end;

procedure pass(x:longint);
begin
     if rev[x]=0 then exit;
     paint(x*2,rev[x]);
     paint(x*2+1,rev[x]);
     rev[x]:=0;
end;

procedure color(deep,l,r,x,y:longint);
var mid:longint;
begin
    pass(deep);
    if (l=x)and(r=y) then
       begin
       paint(deep,i);
       exit;
       end;
    mid:=(l+r)>>1;
    if y<=mid then color(deep*2,l,mid,x,y)    else
    if x>mid then color(deep*2+1,mid+1,r,x,y) else
    begin
    color(deep*2,l,mid,x,mid);
    color(deep*2+1,mid+1,r,mid+1,y);
    end;
end;

procedure print(deep,l,r:longint);
var mid:longint;
begin
    pass(deep);
    if l=r then
       begin
       writeln(tree[deep]);
       exit;
       end;
    mid:=(l+r)>>1;
    print(deep*2,l,mid);
    print(deep*2+1,mid+1,r);
end;

begin
     assign(input,'day.in');
     assign(output,'day.out');
     reset(input);
     rewrite(output);
     readln(n,m,p,q);
     fillchar(tree,sizeof(tree),0);
     fillchar(rev,sizeof(rev),0);
     for i:=max(m-n+1,1) to m do
         begin
         x:=longint((int64(p)*i+q)mod n+1);
         y:=longint((int64(q)*i+p)mod n+1);
         if x>y then swap(x,y);
         color(1,1,n,x,y);
         end;
     print(1,1,n);
     close(input);
     close(output);
end.


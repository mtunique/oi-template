type
    xdtree=object
           col,rev:array[0..maxn]of word;
           n:longint;
           constructor init(x:longint);
           procedure insert(p,l,r,x,y,c:longint);
           procedure pass(p,l,r:longint);
           procedure print(p,c:longint);
           procedure calc(p,l,r:longint;var x,y:longint);
    end;

var

constructor xdtree.init(x:Longint);
begin
     n:=x;
     fillchar(rev,sizeof(rev));
end;

procedure xdtree.print(p,c:longint);
begin
     if p>n<<2 then exit;
     col[p]:=c;rev[p]:=c;
end;
procedure xdtree.pass(p,l,r:longint);
var
   mid:longint;
begin
     if rev[p]=0 then exit;
     mid:=(l+r)>>1;
     if l<=mid   then print(p<<1,rev[p]);
     if mid+1<=r then print(p<<1+1,rev[p]);
end;
procedure xdtree.insert(p,l,r,x,y,c:longint);
var
   mid:longint;
begin
     mid:=(l+r)>>1;
     pass(p,l,r);
end;
    
begin
end.


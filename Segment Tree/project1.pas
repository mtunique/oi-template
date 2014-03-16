program Project1;
var

procedure build(l,r,p:longint);
begin
     d[p].l:=l;d[p].r:=r;
     d[p].c:=0;
     if r=l+1 then exit;
     if l<(l+r)shr 1 then build(l,(l+r)shr 1,p shl 1);
     if (l+r)shr 1<r then build((l+r)shr 1,r,p shl 1+1);
end;

procedure insert(l,r,p);
begin
     if d[p].c=0 then
     begin
     if(l=d[p].l)and(r=d[p].r)then begin  exir;end
     else
     if r<=(l+r)shr 1 then insert(l,r,p shl 1)
     else
     if l>=(l+r)shr 1 then insert(l,r,p shl 1+1)
     else
     begin
          insert(l,(l+r)shr 1,p shl 1);
          insert((l+r)shr 1,r,p shl 1+1);
     end;
     end;
end;

procedure calc(l,r,p:longint);v
var

begin

end;

begin
end.


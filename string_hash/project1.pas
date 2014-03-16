function checkhash(now:string):boolean;
var g,h,i:longword;
begin
     h:=0;
    for i:=1 to length(now) do
     begin
         h:=h shl 4 + ord(now[i]);
         g:=h and $f0000000;
        if g<>0 then h:=h xor (g shr 24);
         h:=h and (not g);
     end;
     h:=h mod 50239;
    if hash[h] then
     begin
        hash[h]:=false;
        checkhash:=false;
        exit;
     end;
     checkhash:=true;
end;

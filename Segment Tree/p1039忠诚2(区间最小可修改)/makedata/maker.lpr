program maker;
var
   i,n,m:longint;
begin
     assign(output,'a.in');
     reset(input);
     randomize;
     n:=random(1000)+1; m:=random(1000)+1;
     for i:=1 to n do
     write(random(1000),' ');
     writeln;
     for i:=1 to m do
     writeln(random(2)+1,' ',random(1000),' ',random(1000));

     close(input);
end.


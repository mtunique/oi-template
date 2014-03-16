program Project1;
var
   s,shu:string;i,l,sw,c,fw,x:longint;
   sz:array[0..10000]of longint;
   fz:array[0..10000]of char;

function ji(c:char):integer;
begin
     case c of
     '#':exit(0);
     ')':exit(1);
     '+':exit(2);
     '-':exit(3);
     '*':exit(4);
     '/':exit(5);
     '(':exit(6);
     else exit(7);
     end;
end;

function check(c:char):boolean;
begin

end;
begin
     assign(input,'a.in');assign(output,'a.out');
     reset(input);rewrite(output);
     
     readln(s);
     s:=s+'#';
     l:=length(s);
     i:=1;
     sw:=0;
     fw:=1;
     fz[1]:='#';

     while i<=l do
     begin
          while(i<=l)and(ji(s[i])=7) do
          begin
               shu:=shu+s[i];inc(i);
          end;
          if shu<>'' then
             begin
                  inc(sw);
                  val(shu,x,c);
                  sz[sw]:=x;
                  shu:='';
             end
          else
          begin
               if ji(s[i])>ji(fz[fw])then begin inc(fw);fz[fw]:=s[i]; end
               else
               begin
                    case fz[fw] of
                    '+':sz[sw-1]:=sz[sw]+sz[sw-1];
                    '-':sz[sw-1]:=sz[sw]-sz[sw-1];
                    '*':sz[sw-1]:=sz[sw]*sz[sw-1];
                    '/':sz[sw-1]:=sz[sw]div sz[sw-1];
                    end;
                    dec(sw);dec(fw);
               end;
               inc(i);
          end;
     end;
     while fw>0 do
     begin
          case fz[fw] of
          '+':sz[sw-1]:=sz[sw]+sz[sw-1];
          '-':sz[sw-1]:=sz[sw]-sz[sw-1];
          '*':sz[sw-1]:=sz[sw]*sz[sw-1];
          '/':sz[sw-1]:=sz[sw]div sz[sw-1];
          end;
          dec(sw);dec(fw);
     end;
     writeln(sz[1]);
     close(input);close(output);
end.


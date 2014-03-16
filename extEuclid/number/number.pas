program number;
var
   a:array[0..20]of longint;
   m:array[0..20]of longint;

   r,temp:int64;n:longint;

function  extgcd(a,b:int64;var x,y:int64):int64;
begin
     if b=0 then
     begin
          x:=1;y:=0;exit(a);
     end
     else
     begin
          r:=extgcd(b,int64(a) mod b,x,y);
          temp:=x;
          x:=y;
          y:=int64(temp)-(a div b)*x;
          exit(r);
     end;
end;

procedure init;
var
   i:longint;a1,m1,k,x,y,t,c,g:int64;flag:boolean;
begin
     readln(n);
     for i:=1 to n do
     readln(m[i],a[i]);

     a1:=a[1];m1:=m[1];
     for i:=2 to n do
     begin
          g:=extgcd(m1,m[i],x,y);
          c:=a[i]-a1;
          if c mod g<>0 then begin flag:=false;break;end;
          k:=m[i] div g;
          t:=(c div g *x mod k+k)mod k;
          a1:=a1+m1*t;
          m1:=m1 div g*m[i];
     end;
     if flag then writeln(a1)
     else
     writeln(-1);
end;

begin
     assign(input,'number.in');assign(output,'number.out');
     reset(input);rewrite(output);

     init;

     close(input);close(output);
end.


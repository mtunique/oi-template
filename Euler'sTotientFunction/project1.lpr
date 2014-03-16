program project1;

var
   f:array[0..50000]of boolean;
   su:array[0..5000]of longint;
   ge,n:longint;
procedure shai;
var
   x,i,temp:longint;
begin
     fillchar(f,sizeof(f),true);
     x:=trunc(sqrt(2000000000));
     for i:=2 to x do
     if f[i] then
     begin
          inc(ge);
          su[ge]:=i;
          temp:=i;
          while(temp<=x)and(temp>0) do
          begin
               f[temp]:=false;
               temp:=temp+i;
          end;
     end;
end;

function  main(n:longint):longint;
var
   i:longint;
begin
     if n<=2 then exit(0);
     main:=1; i:=1;
     while i<=ge do
     begin
          if su[i]>n then break;
          if n mod su[i]=0 then
          begin
               main:=main*(su[i]-1);
               n:=n div su[i];
               while n mod su[i]=0 do
               begin
                    main:=main*su[i];
                    n:=n div su[i];
               end;
          end;
          inc(i);
     end;
     if n>1 then main:=main*(n-1);
end;

procedure init;
begin
     readln(n);
     shai;
     writeln(main(n));
end;

begin
     assign(input,'a.in');assign(output,'a.out');
     reset(input);rewrite(output);

     init;

     close(input);close(output);
end.


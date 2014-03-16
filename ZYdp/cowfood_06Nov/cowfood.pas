program cowfood;

var
   dui:array[0..4000]of longint;
   a:array[0..15,0..15]of longint;
   f:array[0..13,0..4100]of int64;
   ge,n,m,tot,i:longint;

procedure dp;
var
   flag:boolean;  k,i,j,x,y,t,temp,ans,tt:Longint;
begin
     for k:=0 to ge do
     begin
          i:=dui[k];
          if i=74 then
          i:=74;
          flag:=true;
          tt:=1;
          temp:=i;
          while temp>0 do
          begin
              t:=temp and(temp xor (temp-1));
              temp:=temp-t;
              while t mod 2=0 do begin t:=t div 2;inc(tt);end;
              if a[1,tt]=0 then begin flag:=false;break;end;
              tt:=1;
          end;
          if flag then f[1,i]:=1;
          if not flag then
          flag:=true;
     end;

     for i:=1 to n-1 do
         for x:=1 to ge do
         begin
              j:=dui[x];
              if f[i,j]=0 then continue;
              for y:=1 to ge do
              begin
                    k:=dui[y];
                    if k and j<>0 then continue;
                    flag:=true;
                    tt:=1;
                    temp:=k;
                    while temp>0 do
                    begin
                        t:=temp and(temp xor (temp-1));
                        temp:=temp-t;
                        while t mod 2=0 do begin t:=t div 2;inc(tt);end;
                        if a[i+1,tt]=0 then begin flag:=false;break;end;
                        tt:=1;
                    end;
                    if flag then f[i+1,k]:=(f[i+1,k]+f[i,j])mod 100000000;
              end;
         end;
     ans:=0;
     for i:=1 to ge do
     ans:=ans+f[n,dui[i]];
     writeln(ans);
end;

procedure init;
var
   i,j,temp:longint;  flag:boolean;
begin
     readln(n,m);
     for i:=1 to n do
     begin
          for j:=m downto 1 do
          read(a[i,j]);
          readln;
     end;

     tot:=1<<m; ge:=1;dui[1]:=0;
     for i:=1 to tot do
     begin
          temp:=i; flag:=true;
          while temp>0 do
          begin
               while(temp mod 2=0)and(temp>0) do
               temp:=temp div 2;
               dec(temp);
               if temp div 2 mod 2=1 then begin flag:=false;break end;
          end;
          if flag then begin inc(ge); dui[ge]:=i;end;
     end;
     dec(ge);
     dp;
end;

begin
     assign(input,'cowfood.in');assign(output,'cowfood.out');
     reset(input);rewrite(output);

     init;

     close(input);close(output);
end.


type
    node=array[0..200]of longint;

var
   a,b:node;

operator /(a,b:node)c:node;
var
    i,j,t,w:longint;
    function check(t,w:Longint;a,b:node):boolean;
    var
       i:longint;
    begin
         if w-t+1>b[0] then exit(true);
         if w-t+1<b[0] then exit(false);
         for i:=w downto t do
         begin
              if a[i]>b[b[0]+i-w] then exit(true);
              if a[i]<b[b[0]+i-w] then exit(false);
         end;
         exit(true)
    end;

begin
     fillchar(c,sizeof(c),0);
     if not check(1,a[0],a,b) then
     begin
          c[0]:=1;c[1]:=0;exit(c);
     end;
     w:=a[0];t:=a[0]-b[0]+1;
     repeat
           while(t>0)and(not check(t,w,a,b))do dec(t);
           if t=0 then break;
           while check(t,w,a,b) do
           begin
               inc(c[t]);
               for i:=t to t+b[0]-1 do
               begin
                    dec(a[i],b[i-t+1]);
                    if a[i]<0 then
                    begin
                         inc(a[i],10);
                         dec(a[i+1]);
                    end;
                    while a[w]=0 do dec(w);
               end;
           end;
     until false;
     c[0]:=a[0];
     while c[c[0]]=0 do dec(c[0]);
end;

procedure init(var a:node);
var str:string;
   i,j,l:integer;
begin
  readln(str);
  fillchar(a,sizeof(a),0);
  a[0]:=length(str);
  for i:=1 to a[0] do
  a[i]:=ord(str[a[0]-i+1])-ord('0');
end;

procedure print(a:node);
var i:integer;
begin
  for i:=a[0] downto 1 do
  write(a[i]);
  writeln;
end;

procedure main;
begin
     init(a);
     init(b);
     print(a/b);
end;
begin
     assign(input,'gjc.in');assign(output,'a.out');
     reset(input);rewrite(output);

     main;

     close(input);close(output);
end.


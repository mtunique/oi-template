SAP+GAP

{
ID: yw100101
PROB: ditch
LANG: PASCAL
 
   Test 1: TEST OK [0.000 secs, 900 KB]
   Test 2: TEST OK [0.000 secs, 900 KB]
   Test 3: TEST OK [0.000 secs, 900 KB]
   Test 4: TEST OK [0.000 secs, 900 KB]
   Test 5: TEST OK [0.000 secs, 900 KB]
   Test 6: TEST OK [0.000 secs, 900 KB]
   Test 7: TEST OK [0.000 secs, 900 KB]
   Test 8: TEST OK [0.000 secs, 900 KB]
   Test 9: TEST OK [0.000 secs, 900 KB]
   Test 10: TEST OK [0.000 secs, 900 KB]
   Test 11: TEST OK [0.000 secs, 900 KB]
   Test 12: TEST OK [0.000 secs, 900 KB]
}
program c066;
const
    ProName     = 'ditch';
    inf         = ProName+'.in';
    ouf         = ProName+'.out';
    maxLongword = maxlongint*2;
 
type
    quene           = object
        q           : array[1..200] of integer;
        b,e,c       : integer;
        procedure   add(x:integer);
        function    del():integer;
    end;
 
procedure quene.add(x:integer);
begin
    inc(e);
    q[e]:=x;
    inc(c);
end;
 
function quene.del():integer;
begin
    inc(b);
    del:=q[b];
    dec(c);
end;
 
var
    g,f     : array[1..200,1..200] of int64;
    m,n     : integer;
    l       : array[1..200] of integer;
    b       : array[1..200] of boolean;
    ans     : int64;
    q       : quene;
 
 
function find(x:integer):boolean;
var
    t:integer;
    i:integer;
begin
    q.e:=0;
    q.c:=0;
    q.b:=0;
    fillchar(l,sizeof(l),0);
    fillchar(b,sizeof(b),false);
    l[1]:=1;
 
    q.add(x);
    while q.c > 0 do
        begin
            t:=q.del;
            for i:= 1 to m do
                if (l[i] = 0) and ((g[t,i] - f[t,i] > 0) or (f[i,t] > 0)) then
                    begin
                        l[i]:=t;
                        b[i]:=(g[t,i] - f[t,i] > 0);
                        q.add(i);
                        if i = m then
                            exit(true);
                    end;
        end;
    exit(false);
end;
 
procedure increase(x:integer);
var
    d:int64;
    i:integer;
begin
    i:=x;
    d:=maxlongword;
    while i <> 1 do
        begin
            if b[i] then
                begin
                    if g[l[i],i] - f[l[i],i] < d then
                        d:=g[l[i],i] - f[l[i],i]
                end
            else
                begin
                    if f[i,l[i]] < d then
                        d:=f[i,l[i]];
                end;
            i:=l[i];
        end;
 
    i:=x;
    while i <> 1 do
        begin
            if b[i] then
                inc(f[l[i],i],d)
            else
                dec(f[i,l[i]],d);
            i:=l[i];
        end;
 
    inc(ans,d);
end;
 
procedure readin;
var
    i:byte;
    b,e:byte;
    w:int64;
begin
    readln(n,m);
    for i:=1 to n do
        begin
            readln(b,e,w);
            inc(g[b,e],w);
        end;
end;
 
procedure work;
var
    i:integer;
begin
    while find(1) do increase(m);
end;
 
begin
    assign(input,inf);
    reset(input);
    assign(output,ouf);
    rewrite(output);
 
    readin;
    work;
    writeln(ans);
 
    close(input);
    close(output);
end.
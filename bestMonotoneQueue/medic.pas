program medic;

var
  a:    array[0..10, 0..10] of longint;
  f, zhi, hao: array[0..110000] of longint;
  n, m: longint;

  procedure dp;
  var
    w,v,l,ge,temp,y,r,mo: longint;
  begin
    for v := 1 to 10 do
      for w := 1 to 10 do
      begin
        if a[v, w] = 0 then
          continue;
        if m div v<a[v,w] then a[v,w]:=m div v;
        for mo := 0 to v - 1 do
        begin
          l:= 1;       r:= 0;
          temp := (m - mo) div v;
          for ge := 0 to temp do
          begin
            y := f[ge * v + mo] - ge * w;
            while (l <= r) and (zhi[r]<=y) do Dec(r);
            Inc(r); zhi[r] := y; hao[r]:=ge;

            if hao[l]<ge-a[v,w] then inc(l);////////
            f[ge*v+mo]:=zhi[l]+w*ge;
          end;
        end;
      end;
    writeln(f[m]);
  end;

  procedure init;
  var
    i, x, y: longint;
  begin
    readln(n, m);
    for i := 1 to n do
    begin
      readln(x, y);
      Inc(a[x, y]);
    end;
    dp;
  end;

begin
  Assign(input, 'medic.in');
  Assign(output, 'medic.out');
  reset(input);
  rewrite(output);

  init;

  Close(input);
  Close(output);

end.


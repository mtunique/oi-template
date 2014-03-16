program Maxflow_With_MinCost;
const
  name1='flow.in';
  name2='flow.out';
  maxN=100;{最多顶点数}
type
  Tbest=record  {数组的结构}
      value,fa:integer;
    end;{到源点的最短距离，父辈}
  Nettype=record
    {网络邻接矩阵类型}
    c,w,f:integer;
    {弧的容量，单位通过量费用，流量}
    end;
var
  Net:array[1..maxN,1..maxN] Of Nettype;
     {网络N的邻接矩阵}
  n,s,t:integer;{顶点数，源点、汇点的编号}
  Minw:integer;{最小总费用}
  best:array[1..maxN] of Tbest;{求最短路时用的数组}

procedure Init;{数据读人}
var inf:text;
    a,b,c,d:integer;
begin
  fillchar(Net,sizeof(Net),0);
  Minw:=0;
  assign(inf,name1);
  reset(inf);
  readln(inf,n);
  s:=1;t:=n;{源点为1，汇点n}
  repeat
    readln(inf,a,b,c,d);
    if a+b+c+d>0 then
    begin
    Net[a,b].c:=c;{给弧(a,b)赋容量c}
    Net[b,a].c:=0;{给相反弧(b,a)赋容量0}
    Net[a,b].w:=d;{给弧(a,b)赋费用d}
    Net[b,a].w:=-d;{给相反孤(b，a)赋费用-d}
    end;
  until a+b+c+d=0;
  close(inf);
end;

function Find_Path:boolean;
{求最小费用增广路函数,若best[t].value<>MaxInt,
则找到增广路，函数返回true，否则返回false}
var Quit:Boolean;
    i,j:Integer;
begin
  for i:=1 to n do best[i].value:=Maxint;best[s].value:=0;
  {寻求最小费用增广路径前，给best数组赋初值}
  repeat
    Quit:=True;
    for i:=1 to n do
      if best[i].Value < Maxint then
        for j:=1 to n do
          if (Net[i,j].f < Net[i,j].c) and
          (best[i].value + Net[i,j].w <
          best[j].value) then
          begin
            best[j].value:=best[i].value + Net[i,j].w;
            best[j].fa := i;
            Quit:= False;
          end;
  until Quit;
  if best[t].value<Maxint then find_path:=true else find_path:=false;
end;

procedure Add_Path;
var i,j: integer;
begin
  i:= t;
  while i <> s do
    begin
      j := best[i].fa;
      inc(Net[j,i].f); {增广路是弧的数量修改，增量1}
      Net[i,j].f:=-Net[j,i].f;{给对应相反弧的流量赋值-f}
      i:=j;
    end;
    inc(Minw,best[t].value); {修改最小总费用的值}
end;

procedure Out;{输出最小费用最大流的费用及方案}
var ouf: text;
    i,j: integer;
begin
  assign(ouf,name2);
  rewrite(ouf);
  writeln(ouf,'Min w = ',Minw);
  for i := 1 to n do
    for j:= 1 to n do
      if Net[i,j].f > 0 then
        writeln(ouf,i, ' -> ',j,': ',
         Net[i,j].w,'*',Net[i,j].f);
   close(ouf);
end;

Begin {主程序}
   Init;
   while Find_Path do Add_Path;
   {当找到最小费用增广路，修改流}
   Out;
end. 


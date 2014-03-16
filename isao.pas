var
  flag:boolean;
  jl,min,flow,aug,j,m,n,tmp,a,b,c,i:longint;
  his,pre,dis,vh,di:array[0..1024] of longint;
  map:array[1..1024,1..1024] of longint;
begin
  assign(input,'ditch.in');reset(input);
  assign(output,'ditch.out');rewrite(output);
  readln(m,n);
  for i:=1 to m do
   begin
     readln(a,b,c);
     inc(map[a,b],c);
   end;

vh[0]:=n;

for i:=1 to n do di[i]:=1;{当前弧初始为第一条弧}

i:=1;{从S开始搜}
aug:=maxlongint;
while dis[1]<n do
 begin
  his[i]:=aug;{标记，以便以后返回这个值}
  flag:=false;{这个是是否有找到允许弧的标志}
  for j:=di[i] to n do{从当前弧开始搜}
     begin
       if (map[i,j]>0)and(dis[j]+1=dis[i]) then{找到允许弧}
       begin
         flag:=true;
         di[i]:=j;{标记当前弧}
         if map[i,j]<aug then aug:=map[i,j];
         pre[j]:=i;{记录前驱}
         i:=j;
         if i=n then{找到增广路}
           begin
            inc(flow,aug);
             while i<>1 do
               begin
                tmp:=i;
                i:=pre[i];
                dec(map[i,tmp],aug);
                inc(map[tmp,i],aug);
              end;
            aug:=maxlongint;
          end;
        break;{找到允许弧则退出查找}
      end;
    end;
 if flag then continue;{找到允许弧}
 min:=n-1;{没有允许弧了，需要重标号}
 for j:=1 to n do
   begin
     if (map[i,j]>0)and(dis[j]<min) then 
          begin 
             jl:=j;
             min:=dis[j];
          end;
   end;
 di[i]:=jl;
 dec(vh[dis[i]]);{GAP优化}
 if vh[dis[i]]=0 then break;
 dis[i]:=min+1;
 inc(vh[dis[i]]);
 if i<>1 then 
    begin 
        i:=pre[i];{返回上一层}
       aug:=his[i];{知道之前记录这个值的用处了吧}
    end;
 end;
 write(flow);
 close(input);
 close(output);
end.

优化：

1.邻接表优化：
如果顶点多的话，往往N^2存不下，这时候就要存边：
存每条边的出发点，终止点和价值，然后排序一下，
再记录每个出发点的位置。以后要调用从出发点出发的边时候，
只需要从记录的位置开始找即可（其实可以用链表）。
优点是时间加快空间节省，缺点是编程复杂度将变大，所以在题目允许的情况下，建议使用邻接矩阵。

2.GAP优化：
如果一次重标号时，出现距离断层，则可以证明ST无可行流，此时则可以直接退出算法。

3.当前弧优化：
为了使每次找增广路的时间变成均摊O(V)，
还有一个重要的优化是对于每个点保存“当前弧”：初始时当前弧是邻接表的第一条弧；
在邻接表中查找时从当前弧开始查找，找到了一条允许弧，就把这条弧设为当前弧；
改变距离标号时，把当前弧重新设为邻接表的第一条弧。

常规网络流算法
const
  fin='maxflow.in';
  fout='maxflow.out';
  maxn=100;
type
  tline=array[0..maxn]of integer;
  tmap=array[1..maxn]of tline;
var
  n:integer;
  limit,flow:tmap;

procedure getinfo;
var
  i,j,c:integer;
begin
  assign(input,fin);reset(input);
  readln(n);
  while not seekeof do
    begin
      readln(i,j,c);
      limit[i,j]:=c;
    end;
  close(input);
end;

procedure maxflow;
var
  i,j,delta,x:integer;
  last:tline;
  check:array[0..maxn]of boolean;
begin
  repeat
    fillchar(last,sizeof(last),0);
    fillchar(check,sizeof(check),0);
    last[1]:=maxint;
    repeat
      i:=0;
      repeat
        inc(i);
      until (i>n) or (last[i]<>0) and not check[i];
      if i>n then break;
      for j:=1 to n do
        if last[j]=0 then
          if flow[i,j]<limit[i,j] then
            last[j]:=i
          else
            if flow[j,i]>0 then last[j]:=-i;
      check[i]:=true;
    until last[n]<>0;
    if last[n]=0 then break;
    delta:=maxint;
    repeat
      j:=i;i:=abs(last[j]);
      if last[j]>0 then x:=limit[i,j]-flow[i,j]
                   else x:=flow[j,i];
      if x<delta then delta:=x;
    until i=1;
    i:=n;
    repeat
      j:=i;i:=abs(last[j]);
      if last[j]>0 then inc(flow[i,j],delta)
                   else dec(flow[j,i],delta);
    until i=1;
  until false;
end;

procedure print;
var
  i,j,sum:integer;
begin
  sum:=0;
  assign(output,fout);rewrite(output);
  for i:=1 to n do
    for j:=1 to n do
      if flow[i,j]>0 then
        begin
          if i=1 then inc(sum,flow[i,j]);
          writeln(i,'->',j,' ',flow[i,j]);
        end;
  writeln('maxflow=',sum);
  close(output);
end;

begin
  getinfo;
  maxflow;
  print;
end.



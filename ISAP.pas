const
  filename='ditch';
  maxn=200;
  maxm=200;
var
  n,m,s,t,ans:longint;//n,m为图的点数，边数，s,t为源点，汇点，ans记录最大流
  dist,pre:array [1..maxn] of longint;//dist储存距离标号，pre储存增广路路径
  flow:array [1..maxn,1..maxn] of longint;//flow储存弧的剩余流量
 
procedure fopen;
begin
  assign(input,filename+'.in');
  assign(output,filename+'.out');
  reset(input);
  rewrite(output);
end;
 
procedure fclose;
begin
  close(input);
  close(output);
end;
 
procedure init;
var
  i,u,v,w:longint;
begin
  readln(m,n);
    for i:=1 to m do
      begin
        readln(u,v,w);
        inc(flow[u,v],w);
      end;
  s:=1;//源点
  t:=n;//汇点
end;
 
function min(a,b:longint):longint;//取较小值
begin
  if a<b then exit(a)
    else exit(b);
end;
 
procedure augment;
var
  i,delta:longint;
begin
  i:=t;
  delta:=maxlongint;
    while pre[i]<>-1 do
      begin
        delta:=min(delta,flow[pre[i],i]);
        i:=pre[i];
      end;//找这条增广路的最小割
  inc(ans,delta);//将流量加入答案
  i:=t;
    while pre[i]<>-1 do
      begin
        dec(flow[pre[i],i],delta);//更新前向弧
        inc(flow[i,pre[i]],delta);//更新后向弧
        i:=pre[i];
      end;
end;
 
procedure isap;
var
  i,j,k:longint;
  find:boolean;
  sum:array [0..maxn] of longint;//记录GAP的数组
begin
  fillchar(dist,sizeof(dist),0);//初始化距离标号为0（省略bfs不增加渐进时间复杂度）
  fillchar(sum,sizeof(sum),0);
    for i:=1 to n do inc(sum[dist[i]]);
  fillchar(pre,sizeof(pre),0);
  pre[s]:=-1;
  i:=s;
    while dist[s]<n do
      begin
        find:=false;
          for j:=1 to n do
            if (flow[i,j]>0) and (dist[j]+1=dist[i]) then//找到一条可行弧
              begin
                find:=true;
                pre[j]:=i;//储存路径
                i:=j;//沿可行弧向前
                break;
              end;
          if find then
            begin
              if i=t then//找到增广路
                begin
                  augment;
                  i:=s;
                end
              else continue;
            end
          else
            begin
              k:=i;
                for j:=1 to n do
                  if (flow[i,j]>0) and (dist[j]<dist[k]) then k:=j;//找最小的距离标号
              dec(sum[dist[i]]);
                if sum[dist[i]]=0 then dist[s]:=n;//GAP优化
              dist[i]:=dist[k]+1;//修改距离标号
              inc(sum[dist[i]]);
                if pre[i]<>-1 then i:=pre[i];
            end;
      end;
end;
 
procedure work;
var
  i:longint;
begin
  ans:=0;//初始化最大流为0
  isap;//Improved SAP
  writeln(ans);
end;
 
begin
  fopen;
  init;
  work;
  fclose;
end.
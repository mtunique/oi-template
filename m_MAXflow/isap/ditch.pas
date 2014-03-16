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

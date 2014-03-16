var
   a,b,f:array[0..100000] of longint;
   m,s,c,n,t,i,j,l,r,d:longint;
procedure insert(x,y:longint);
begin
   while (l<=r)and(b[r]<=y) do dec(r);
   inc(r);a[r]:=x;b[r]:=y;
end;
begin
   readln(n,t);              //读入数据 n为物品个数 t为背包容量
   for i:=1 to n do
   begin
      read(m,s,c);         //读入当前物品 m为物品体积、s为物品价值、c为物品可用次数（0表示无限制）
      if (c=0)or(t div m<c) then c:=t div m;
      for d:=0 to m-1 do
      begin
         l:=1;r:=0;     //清空队列
         for j:=0 to (t-d) div m do
         begin
            insert(j,f[j*m+d]-j*s);   //将新的点插入队列
            if a[l]<j-c then inc(l);   //删除失效点
            f[j*m+d]:=b[l]+j*s;        //用队列头的值更新f[j*m+d]
         end;
      end;
   end;
   writeln(f[t]);
end.


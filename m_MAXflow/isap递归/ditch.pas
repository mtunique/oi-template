program ditch;
var
   map:array[0..400,0..400]of longint;
   h:array[0..400]of longint;
   v,n,d:array[0..400*400]of longint;
   pa,pre,sum,dis,now:array[0..400]of longint;
   nn,m,s,num,t,temp,flow,mind:longint;
procedure add(x,y,z:longint);
begin
     inc(num);n[num]:=h[x];h[x]:=num;v[num]:=y;d[num]:=z;
     inc(num);n[num]:=h[y];h[y]:=num;v[num]:=x;d[num]:=0;
end;
   
procedure init;
var
   i,x,y,z,j:longint;
begin
     readln(m,nn);
     fillchar(h,sizeof(h),0);
     fillchar(n,sizeof(n),0);
     for i:=1 to m do
     begin
          readln(x,y,z);
          inc(map[x,y],z);
     end;
     num:=1;
     for i:=1 to nn do
     for j:=1 to nn do
     if map[i,j]<>0 then add(i,j,map[i,j]);
     t:=1;s:=nn;
end;

function min(x,y:longint):longint;
begin
     if x>y then exit(y) else exit(x);
end;
function isap(x,del:longint):longint;
var
   i,now:longint;
begin
     if x=s then exit(del);
     now:=del;
     i:=h[x];
     while i<>0 do
     begin
          if(d[i]>0)and(dis[v[i]]+1=dis[x])then
          begin
               temp:=isap(v[i],min(d[i],now));
               dec(now,temp);
               dec(d[i],temp);
               inc(d[i xor 1],temp);
               if now=0 then exit(del);
               if dis[t]=s then exit(del-now);
          end;
          i:=n[i];
     end;
     if now=del then
     begin
          dec(sum[dis[x]]);
          if sum[dis[x]]=0 then
          begin
          dis[t]:=s;exit(del-now);
          end;
          i:=h[x];
          mind:=s-1;
          while i<>0 do
              begin
               if d[i]>0 then mind:=min(mind,dis[v[i]]);
               i:=n[i];
              end;
          dis[x]:=mind+1;
          inc(sum[dis[x]]);
     end;
     exit(del-now);
end;

begin
     assign(input,'ditch.in');assign(output,'ditch.out');
     reset(input);rewrite(output);
     init;
     flow:=0;
     while dis[t]<s
     do
     flow:=flow+isap(t,$3f3f3f3f*2);
     
     writeln(flow);
     close(input);close(output);
end.

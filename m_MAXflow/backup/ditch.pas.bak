program ditch;
var
   map:array[0..400,0..400]of longint;
   pa,pre,sum,dis,now:array[0..400]of longint;
   n,m,s,t,aug:longint;
procedure init;
var
   i,x,y,z:longint;
begin
     readln(m,n);
     for i:=1 to m do
     begin
          readln(x,y,z);
          inc(map[x,y],z);
     end;
     s:=1;t:=n;
end;

procedure augment;
var
   i,j:longint;
begin
     i:=t;
     while i<>s do
     begin
          j:=i;i:=pre[i];
          dec(map[i,j],aug);
          inc(map[j,i],aug);
     end;
end;

procedure isap;
var
   i,j,min,jp:longint;
   flag:boolean;
   flow:longint;
begin
     for i:=1 to n do now[i]:=1;
     i:=s;
     aug:=maxlongint;
     fillchar(sum,sizeof(sum),0);
     fillchar(dis,sizeof(dis),0);
     flow:=0;
     sum[0]:=n;
     while dis[s]<n do
     begin
           pa[i]:=aug;
           flag:=false;
           for j:=now[i] to n do
           if(map[i,j]>0)and(dis[j]+1=dis[i])then
           begin
                flag:=true;
                now[i]:=j;
                if map[i,j]<aug then aug:=map[i,j];
                pre[j]:=i;
                i:=j;
                if i=t then
                begin
                inc(flow,aug);
                augment;
                i:=1;
                aug:=maxlongint;
                end;
                break;
           end;
           if flag then continue;
           min:=n-1;
           for j:=1 to n do
           if(map[i,j]>0)and(dis[j]<min) then
           begin
                jp:=j;
                min:=dis[j];
           end;
           now[i]:=jp;
           dec(sum[dis[i]]);
           if sum[dis[i]]=0 then break;
           dis[i]:=min+1;
           inc(sum[dis[i]]);
           if i<>1 then
           begin
                i:=pre[i];
                aug:=pa[i];
           end;
     end;
     writeln(flow);
end;

begin
     assign(input,'ditch.in');assign(output,'ditch.out');
     reset(input);rewrite(output);
     init;
     isap;
     close(input);close(output);
end.


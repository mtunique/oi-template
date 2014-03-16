program regexp;
const
     maxn=210000;
     maxm=2100000;
type
    node=record
               d,v:int64;
    end;
    heap=object
         a:array[0..maxm]of node;
         ge:int64;
         constructor init;
         procedure up(i:int64);
         procedure insert(x,v:int64);
         procedure down(i:int64);
         procedure pop;
    end;
var
   list,col,head,dis:array[0..maxn]of int64;
   next,v,d,time,pos:array[0..maxm]of int64;
   u,vis:array[0..maxn]of boolean;
   e:array[0..maxm]of record
   x,y,z:int64;
   end;

   q:heap;
   num,tt,st,en,n,m:int64;
constructor heap.init;
begin ge:=0; end;


procedure heap.up(i:int64);
var
  t:node;
begin
    t:=a[i];
    while(i>1)do
         if t.d<a[i shr 1].d then
         begin pos[a[i shr 1].v]:=i;a[i]:=a[i shr 1];i:=i shr 1; end
         else break;
    a[i]:=t;
    pos[a[i].v]:=i;
end;

procedure heap.insert(x,v:int64);
begin
    inc(ge);
    a[ge].d:=x; a[ge].v:=v;pos[v]:=ge;
    up(ge);
end;

procedure heap.down(i:int64);
var
  t:node;j:int64;
begin
    t:=a[i]; j:=i shl 1;
    while j<=ge do
    begin

         if(j+1<=ge)and(a[j].d>a[j+1].d)then inc(j);
         if t.d>a[j].d then
         begin
         pos[a[j].v]:=i;
         a[i]:=a[j];i:=j;j:=j shl 1
         end
         else break;
    end;
    a[i]:=t;pos[a[i].v]:=i;
end;

procedure heap.pop;
begin
    a[1]:=a[ge]; dec(ge);   down(1);
end;

  procedure dj(x:int64);
  var
     now:int64;i:longint;
  begin
       for i:=1 to n do
       dis[i]:=high(int64);
       q.init;
       i:=head[x];
       while i<>0 do
       begin
            q.insert(d[i],v[i]);
            i:=next[i];
       end;
       dis[x]:=0;
       while q.ge>0 do
       begin
            now:=q.a[1].v;
			while u[now] do
			begin
				q.pop;
				now:=q.a[1].v;
			end;
            u[now]:=true;
            if dis[now]>q.a[1].d then dis[now]:=q.a[1].d;
            q.pop;
            i:=head[now];
            while i<>0 do
            begin
                 if((pos[v[i]]=0)or(q.a[pos[v[i]]].d>dis[now]+d[i]))and(not u[v[i]])then
                 begin
                     if pos[v[i]]<>0 then
                     begin
                     q.a[pos[v[i]]].d:=dis[now]+d[i];
                     q.up(pos[v[i]]);
                     end
                     else
                     q.insert(dis[now]+d[i],v[i]);
                 end;
                 i:=next[i];
            end;
       end;

  end;

procedure add(x,y,z:int64);
begin
     inc(num);v[num]:=y;d[num]:=z;next[num]:=head[x];head[x]:=num;
end;

procedure dfs(x:int64);
var
   i:int64;
begin
     i:=head[x];
     vis[x]:=true;
     while i<>0 do
     begin
          if not vis[v[i]] then
          dfs(v[i]);
          i:=next[i];
     end;
     inc(tt);
     time[x]:=tt;
end;

procedure color(x:int64);
var
   i:int64;
begin
     i:=head[x];
     col[x]:=tt;
     while i<>0 do
     begin
          if col[v[i]]=0 then
          color(v[i]);
          i:=next[i];
     end;
end;

procedure make;
var
   i:longint;
begin
     st:=col[1];
     en:=col[n];
     fillchar(head,sizeof(head),0);
     num:=0;
     for i:=1 to m do
     if col[e[i].x]<>col[e[i].y] then
     add(col[e[i].x],col[e[i].y],e[i].z);
end;

procedure print;
var
   i,x:longint;
begin
     for x:=1 to n do
     begin
          i:=head[x];
          writeln(x);
          while i<>0 do
          begin
               write(v[i],' ',d[i],'; ');
               i:=next[i];
          end;
          writeln;
     end;
end;

procedure init;
var
   i,x,y,z:longint;
begin
     assign(input,'regexp.in');assign(output,'regexp.out');
     reset(input);rewrite(output);

     readln(n,m);
     num:=0;
     for i:=1 to m do
     begin
          readln(x,y,z);
          e[i].x:=x;e[i].y:=y;e[i].z:=z;
          add(x,y,z);
     end;

     tt:=0;
     dfs(1);
     fillchar(head,sizeof(head),0);
     num:=0;
     for i:=1 to m do
     add(e[i].y,e[i].x,e[i].z);

     for i:=1 to n do
     list[time[i]]:=i;
     tt:=0;

     for i:=n downto 1 do
     if col[list[i]]=0 then
     begin
     inc(tt);
     color(list[i]);
     end;

     {for i:=1 to n do
     writeln(col[i]);}

     make;
     print;
     dj(st);
     writeln(dis[en]);
     close(input);close(output);
end;

begin

     init;

end.


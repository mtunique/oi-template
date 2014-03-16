type
    node=record
    p,d:longint;
    end;
var
   h,dis,o:array[0..20000]of longint;
   he:array[0..20000]of node;
   n,v,pos,d:array[0..200000]of longint;
   nn,m,i,num,ge:longint;
   x:node;
procedure add(x,y,z:Longint);
begin
     inc(num);
     n[num]:=h[x];h[x]:=num;v[num]:=y;d[num]:=z;
end;
//上浮
procedure up(i:longint);
var
   x:node;
begin
     x:=he[i];
     while i>1 do
     begin
          if he[i shr 1].d>x.d then
          begin
               pos[he[i shr 1].p]:=i;
               he[i]:=he[i shr 1];
				o[v[he[i].p]]:=i;
               i:=i shr 1;
          end
          else break;
     end;
     pos[x.p]:=i;
     he[i]:=x;
	 o[v[he[i].p]]:=i;
end;

//下沉
procedure down(i:longint);
var
   j:longint;
begin
     x:=he[i];
     while i shl 1<=ge do
     begin
          j:=i shl 1;
          if(j+1<=ge)and(he[j+1].d<he[j].d)then inc(j);
          if x.d>he[j].d then
          begin
               pos[he[j].p]:=i;
               he[i]:=he[j];
				o[v[he[i].p]]:=i;
               i:=j;
          end
          else
          break;
     end;
     pos[x.p]:=i;
     he[i]:=x;
	 o[v[he[i].p]]:=i;
end;

//弹出栈顶元素
procedure pop;
begin
     pos[he[1].p]:=-1;
     he[1]:=he[ge];
     pos[he[1].p]:=1;
     dec(ge);
     down(1);
end;

procedure dj(t:longint);
var
	x,l,j,y,i:longint;
begin
     for j:=1 to nn do
     begin
          x:=v[he[1].p];
          l:=he[1].d;
          i:=h[x];
          pop;
          while i<>0 do
          begin
               y:=v[i];
               if d[i]+l<he[o[y]].d then
			   begin
				he[o[y]].d:=d[i]+l;
				up(o[y]);
                                dis[y]:=d[i]+l;
			   end;
               i:=n[i];
          end;
     end;
end;

procedure init;
var
   i,x,y,z:longint;
begin
     fillchar(h,sizeof(h),0);
     fillchar(n,sizeof(n),0);
     fillchar(dis,sizeof(dis),$7f);
     num:=0; ge:=0;
     readln(nn,m);
     for i:=1 to m do
     begin
          readln(x,y,z);

          if x=1 then
          begin
               if dis[y]>z then dis[y]:=z;
          end
          else
          add(x,y,z);
     end;
     for i:=2 to nn do
     begin
          if dis[i]=2139062143 then
          begin
               add(1,i,maxlongint);
               inc(ge);
               pos[num]:=ge;
               he[ge].d:=maxlongint;
               he[ge].p:=num;
               up(ge);
          end
          else
          begin
               add(1,i,dis[i]);
               inc(ge);
               pos[num]:=ge;
               he[ge].d:=dis[i];
               he[ge].p:=num;
               up(ge);
          end;
     end;
     dj(1);
end;

begin
     assign(input,'path.in');
     assign(output,'path.out');
     reset(input);rewrite(output);
     init;
     for i:=2 to nn do
     writeln(dis[i]);
     close(input);close(output);
end.


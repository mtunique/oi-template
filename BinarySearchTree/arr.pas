var
   l,r,d,f:array[0..100100]of longint;
   sum,root,rn,ln,box,n,ans:longint;
   
procedure insert(x:longint);
var
   i,j:longint;
begin
     if root=0 then
     begin
          inc(sum);
          root:=sum;
          d[sum]:=x;
          exit;
     end;
     i:=root;
     while i<>0 do
     begin
          if x>=d[i] then
          begin
          j:=i; i:=r[i]end
          else
          begin
          j:=i;i:=l[i];
          end;
     end;
     inc(sum);
     d[sum]:=x;
     f[sum]:=j;

     if x<=d[j] then begin  l[j]:=sum;end
     else r[j]:=sum;
end;

function search(x,n:longint):longint;
var      ln,rn:longint;
begin
     {if(l[x]<>0)then
     begin
         box:=search(l[x],n)+1;
         if box=n then begin ans:=x;exit(box+search(r[x],0))end
         else
         begin
             if(box<n)and(r[x]<>0)then
                  box:=box+search(r[x],n-box);
             exit(box);
         end;
     end;

     if n=1 then ans:=x
     else
     if r[x]<>0 then exit(search(r[x],n-1)+1) else exit(1);}
     if l[x]<>0 then
     begin
          ln:=search(l[x],n);
          if r[x]<>0 then
             if ln+1<n then rn:=search(r[x],n-1-ln)
             else rn:=search(r[x],0)
          else rn:=0;
          if n=ln+1 then ans:=x;
          exit(ln+rn+1);
     end
     else
     begin
          if r[x]<>0 then
          rn:=search(r[x],n-1)
          else rn:=0;
          if n=1 then ans:=x;
          exit(rn+1);
     end;
     
end;

function hou(x:longint):longint;   //hou xu
var
   y:longint;
begin
     if r[x]<>0 then
     begin
          x:=r[x];
          while l[x]<>0 do x:=l[x];//min
          exit(x);
     end;
     y:=f[x];
     while(x=r[y])and(y<>0) do
     begin
          x:=y;y:=f[x];
     end;
     exit(y);
end;

procedure delete(z:longint);
var
   x,y:longint;
begin
     if(l[z]=0)and(r[z]=0)then
     begin
     if f[z]<>0 then
     begin
          if z=l[f[z]]then
          begin
          l[f[z]]:=0;
          end
          else
          begin
          r[f[z]]:=0;
          end;
     end
     else
     root:=0;
          exit;
     end;
     
     if(l[z]=0)or(r[z]=0)then
     begin
     if f[z]<>0 then
     begin
          if l[z]<>0 then
          begin
               if z=l[f[z]]then
                begin
                l[f[z]]:=l[z];f[l[z]]:=f[z];
                end
                else
                begin
                r[f[z]]:=l[z];f[l[z]]:=f[z];
                end;
                exit;
          end;
          if r[z]<>0 then
          begin
               if z=l[f[z]]then
                begin
                l[f[z]]:=r[z];f[r[z]]:=f[z];
                end
                else
                begin
                r[f[z]]:=r[z];f[r[z]]:=f[z];
                end;
                exit;
          end;
     end
     else
     begin
          if l[z]<>0 then begin root:=l[z];f[l[z]]:=0;end
          else begin root:=r[z];f[r[z]]:=0;end;
          exit;
     end;
     
     end;
     y:=hou(z);
     d[z]:=d[y];
     delete(y);
end;

procedure print(x:longint);
begin
     writeln(x,':',d[x],': L:',l[x],' R:',r[x]);
     if l[x]<>0  then print(l[x]);
     if r[x]<>0  then print(r[x]);
end;

procedure init;
var
   i:longint;ch,c:char;x,m:longint;
begin
     fillchar(l,sizeof(l),0);
     fillchar(r,sizeof(r),0);
     
     readln(n,m);
     //readln(ch,c,x);
     //d[1]:=x;ln[1]:=0;f[1]:=0;
     //sum:=1;root:=1;
     sum:=0;root:=0;
     for i:=1 to m do
     begin
          readln(ch,c,x);
          if ch='i' then
          insert(x)
          else
          begin
          //print(root);
          ans:=0;
          n:=x;
          search(root,x);
          writeln(d[ans]);
          delete(ans);
          end;
     end;
end;
begin
     assign(input,'arr.in');assign(output,'arr.out');
     reset(input);rewrite(output);
     init;
     close(input);close(output);
end.


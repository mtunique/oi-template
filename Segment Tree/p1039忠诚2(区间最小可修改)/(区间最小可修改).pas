program a;//////////Ã²ËÆ²»ÓÅ»¯
const
     maxn=205000;
type
    tree=object
         s,a,c:array[0..maxn*4]of longint;
         rev:array[0..maxn*4]of boolean;
         ans,len:longint;
         function build(n,l,r:longint):longint;
         procedure search(n,l,r,lr,rr:longint);
         function main(x,y:longint):longint;
         procedure print(n,x:longint);
         procedure pass(n,x:longint);
         procedure updata(n:longint);
         procedure insert(n,l,r,lr,rr,x:longint);
    end;
    node=record
       key,l,r,c:longint;
   end;
var
   q:tree;
   n,m:longint;
{---------------min max---------------------}
function min(i,j:longint):longint;
begin
     if i>j then exit(j) else exit(i);
end;

function tree.main(x,y:longint):longint;
begin
     ans:=maxlongint;search(1,1,len,x,y);
end;

function tree.build(n,l,r:longint):longint;
begin
     if l=r then begin
     s[n]:=a[l];c[n]:=s[n];
     //writeln(l,'->',r,':',s[n]);
     exit;end;
     build(n*2,l,(l+r)div 2);
     build(n*2+1,(l+r)div 2+1,r);
     s[n]:=min(s[n*2],s[n*2+1]);c[n]:=s[n];
     //writeln(l,'->',r,':',s[n]);
end;

procedure tree.print(n,x:longint);
begin
     if n>len*4 then exit;
     rev[n]:=true;
     s[n]:=x;c[n]:=x;
end;

procedure tree.pass(n,x:longint);
begin
     if rev[n] then
     begin
          print(n*2,c[n]);
          print(n*2+1,c[n]);
          rev[n]:=false;
     end;
end;

procedure tree.updata(n:longint);
begin
     s[n]:=min(min(s[n*2],s[n*2+1]),c[n]);
end;

procedure  tree.search(n,l,r,lr,rr:longint);
var
   mid:longint;
begin
     if l<r then pass(n,c[n]);
     if(lr=l)and(r=rr)then
     begin
          updata(n);
          ans:=min(ans,s[n]);
     end
     else
     begin
          mid:=(l+r)div 2;
          if rr<=mid then search(n*2,l,mid,lr,rr)else
          if mid+1<=lr then search(n*2+1,mid+1,r,lr,rr)else
          begin
               search(n*2,l,mid,lr,mid);
               search(n*2+1,mid+1,r,mid+1,rr);
          end;
     end;
end;

procedure  tree.insert(n,l,r,lr,rr,x:longint);
var
   mid:longint;
begin
     c[n]:=x;
     if(lr=l)and(r=rr)then
     begin
          print(n,x);
     end
     else
     begin
          mid:=(l+r)div 2;
          if rr<=mid then insert(n*2,l,mid,lr,rr,x)else
          if mid+1<=lr then insert(n*2+1,mid+1,r,lr,rr,x);
     end;
     updata(n);
end;



procedure init;
var
   i,x,y,z,j:longint;
begin
     readln(n,m);
     fillchar(q.s,sizeof(q.s),$7f);
     fillchar(q.c,sizeof(q.c),$7f);
     for i:=1 to n do
     read(q.a[i]);
     q.len:=n;
     q.build(1,1,n);
     for i:=1 to m do
     begin
          readln(z,x,y);
          if z=1 then write(q.main(x,y),' ')
          else
          q.insert(1,1,q.len,x,x,y);
          {for j:=1 to n*2 do
          writeln(j,' ',q.s[j],' ',q.c[j]); }
     end;
end;

begin
     assign(input,'a.in');assign(output,'a.out');
     reset(input);rewrite(output);

     init;

     close(input);close(output);
end.

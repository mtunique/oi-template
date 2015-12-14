const
     maxn=10100;
     maxm=100100;
type
    node=record
               d,y:longint;
    end;
    heap=object
         a:array[0..maxm]of node;
         n:longint;
         
         constructor init; //��ʼ��
         function top:node;
         function empty:boolean;
         procedure up(i:longint);
         procedure push(t:node);
         procedure down(i:longint);
         procedure pop;
    end;
var
 head,dis : array[0..maxn]of longint;
     vis  : array[0..maxn]of boolean;
 v,d,next : array[0..maxm]of longint;

      n,m : longint;
      q   : heap;
constructor heap.init;
begin n:=0; end;

function heap.empty:boolean;
begin
     exit(n=0);
end;

procedure heap.up(i:longint);//�ϸ�
var
  t:node;
begin
    t:=a[i];
    while(i>1)do
         if t.d<a[i shr 1].d then
         begin a[i]:=a[i shr 1];i:=i shr 1 end
         else break;
    a[i]:=t;
end;

procedure heap.push(t:node);//ѹ��
begin
    inc(n);
    a[n]:=t;
    up(n);
end;

function heap.top:node; //�Ѷ�ֵ
begin
    exit(a[1]);
end;

procedure heap.down(i:longint); //�³�
var
  t:node;j:longint;
begin
    t:=a[i]; j:=i shl 1;
    while j<=n do
    begin

         if(j+1<=n)and(a[j].d>a[j+1].d)then inc(j);
         if t.d>a[j].d then
         begin
         a[i]:=a[j];i:=j;j:=j shl 1
         end
         else break;
    end;
    a[i]:=t;
end;

procedure heap.pop; //�����Ѷ�
begin
    a[1]:=a[n]; dec(n);   down(1);
end;

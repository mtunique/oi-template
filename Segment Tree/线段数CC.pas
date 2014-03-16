Paint(x,i)//表示将x节点以及他的儿子节点数值全部修改为i，这里要用到延迟修改。
Pass(x)//表示将x节点的延迟信息往下传递，如果没有延迟信息则不传递。
Updata(x)//表示维护x节点的信息，通常用来维护区间最大(小)值和区间和。
Search(deep,l,r,x,y)//表示在deep节点处寻找x-y区间。l，r是该节点所表示区间。
只需要以上四个操作，我们就可以完美解决线段树的所有操作了！下面是代码
Procedure paint(x,i:longint);
Begin
	If x>=4*n then exit;//该节点不存在
	C[x]:=I; s[x]:=I; rev[x]:=I;//c表示该节点的权值,s表示区间最大值，rev为延迟信息。
End;
Procedure pass(x:longint);
Begin
	If rev[x]=0 then exit;//该点没有延迟信息
	Paint(l[x],rev[x]);//向左传递
	Paint(r[x],rev[x]);//向右传递
	Rev[x]:=0;//传递完毕
End;
Procedure updata(x:longint);
Begin
	S[x]:=max(s[l[x]],s[r[x]],c[x]);
//这里只维护最大值，如果维护最小值的话要初始化所有节点值为很大的数。
End;
Procedure serarch(deep,l,r,x,y:longint);
Var mid:longint;
Begin
    Pass(deep);//访问到的节点要向下传递延迟信息，否则访问下一层时就会Error。
	If (l=x)and(r=y) then //已经找到了要求的区间
		Begin
		updata(n);
		Ans=max(ans,s[deep]);//更新要求的最大值
		Exit;
		End;
	Mid:=(l+r)>>1;
	If y<=mid then search(deep*2,l,mid,x,y)//要求的区间在左边
	Else if x>mid then search(deep*2+1,mid+1,r,x,y) //要求的区间在右边
	Else begin
		Search(deep*2,l,mid,x,mid); //要求的区间在两边
		Search(deep*2+1,mid+1,r,mid+1,y);
		End;
	updata(deep); 
End;
另外还有一个build(x,l,r)建树操作我就不再赘述了。

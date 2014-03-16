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
	S[x]:=min(s[l[x]],s[r[x]],c[x]);
//这里只维护最大值，如果维护最小值的话要初始化所有节点值为很大的数。
End;
Procedure serarch(deep,l,r,x,y:longint);
Var mid:longint;
Begin
    Pass(deep);//访问到的节点要向下传递延迟信息，否则访问下一层时就会Error。
	If (l=x)and(r=y) then //已经找到了要求的区间
		Begin
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
End;
另外还有一个build(x,l,r)建树操作我就不再赘述了。

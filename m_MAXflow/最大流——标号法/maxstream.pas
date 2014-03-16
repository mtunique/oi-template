Program Max_Stream;
Const Maxn=20;
type
  nettype=record
    C,F:integer;
    end;
  nodetype=record
    L,P:integer;
    end;
var
  Lt:array[0..maxn] of nodetype;
  G:Array[0..Maxn,0..Maxn] of Nettype;
  N,S,T:integer;
  F:Text;

Procedure Init;{初始化过程，读人有向图，并设置流为0}
Var Fn :String;
  I,J :Integer;
Begin
  Write( 'Graph File = ' ); Readln(Fn);
  Assign(F,Fn);
  Reset(F);
  Readln(F,N);
  Fillchar(G,Sizeof(G) ,0);
  Fillchar(Lt,Sizeof(Lt),0);
  For I:=1 To N Do
    For J:=1 To N Do Read(F,G[I,J].C);
  Close(F);
End;

Function Find: Integer; {寻找已经标号未检查的顶点}
Var I: Integer;
Begin
  I:=1;
  While (I<=N) And Not((Lt[I].L<>0)And(Lt[I].P=0)) Do Inc(I);
  If I>N Then Find:= 0 Else Find:= I;
End;

Function Ford(Var A: Integer):Boolean;
Var  {用标号法找增广路径，并求修改量Ａ}
  I,J,M,X:Integer;
Begin
  Ford:=True;
  Fillchar(Lt,Sizeof(Lt),0);
  Lt[S].L:=S;
  Repeat
    I:= Find;
    If i=0 Then Exit;
    For J:=1 To N Do
      If (Lt[J].L= 0)And((G[I,J].C<>0)or(G[J,I].C<>0)) Then
      Begin
if (G[I,J].F<G[I,J].C) Then Lt[J].L:= I;
If (G[J,I].F>0) Then Lt[J].L:=-I;
    End;
    Lt[I].P:=1;
  Until (Lt[T].L<>0);
  M:=T;A:=Maxint;
  Repeat
    J:=M;M:=Abs(Lt[J].L);
    If Lt[J].L<0 Then X:= G[J,M].F;
    If Lt[J].L>0 Then X:= G[M,J].C- G[M,J].F;
    If X<A Then A:= X;
  Until M= S;
  Ford:=False;
End;

Procedure Change(A: Integer);{调整过程}
Var M, J: Integer;
Begin
  M:= T;
  Repeat
    J:=M;M:=Abs(Lt[J].L);
    If Lt[J].L<0 Then G[J,M].F:=G[J,M].F-A;
    If Lt[J].L>0 Then G[M,J].F:=G[M,j].F+A;
  Until M=S;
End;

Procedure Print; {打印最大流及其方案}
VAR
  I ,J: Integer;
  Max: integer;
Begin
  Max:=0;
  For I:=1 To N DO
  Begin
    If G[I,T].F<>0 Then Max:= Max + G[I,T].F;
    For J:= 1 To N Do
If G[I,J].F<>0 Then Writeln( I, '-> ' ,J,' ' ,G[I,J].F);
  End;
  Writeln('The Max Stream=',Max);
End;

Procedure Process;{求最大流的主过程}
Var Del:Integer;
    Success:Boolean;
Begin
  S:=1;T:=N;
  Repeat
    Success:=Ford(Del);
    If Success Then Print
    Else Change(Del);
  Until Success;
End;

Begin {Main Program}
  Init;
  Process;
End.

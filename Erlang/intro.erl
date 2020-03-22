-module(intro).
-export([fibo/1, fib/1, fibonacci/1]). 
%% Diferentes formas de calcular fibonacci
-export([prodVect/2, mulMat/2, identidad/1, transpuesta/1]).
%% Funciones de manejo de matrices
-export([potencia/2, expLog/2, tiempo/2]).
%% Funciones miscelAneas

%% Introducción a Erlang

%% Fibonacci O(2^n)
fib(0)->0;
fib(1)->1;
fib(N)->fib(N-1)+fib(N-2).

%% Fibonacci O(n)
fibo(0)->0;
fibo(N)->fibo(N,0,1,1).

fibo(N,_Fi1,Fi,N)->Fi;
fibo(N,Fi1,Fi,I)->fibo(N,Fi,Fi1+Fi,I+1).

%% Suma de lista
sumaLista([])->0;
sumaLista([H|T])->H+sumaLista(T).
% Otra forma es:
% sumaLista(L)-> lists:foldl(fun(X,Suma)-> X+Suma end, 0, L).

%% Multiplique posiciones
mulPos([],[])->[];
mulPos([H1|T1],[H2|T2])->[H1*H2|mulPos(T1,T2)].

%% Prod Vectores
prodVect(V,W)->sumaLista(mulPos(V,W)).

% Timer
tiempo(Foo,N)->A=erlang:timestamp(), 
               Foo(N), 
               B=erlang:timestamp(),
               timer:now_diff(B,A).

%% Transpuesta de matrices
transpuesta([])->[];
transpuesta([[]|_L])-> [];
transpuesta(M)-> [[H || [H|_T]<-M] | transpuesta([T||[_H|T]<-M])].

%% Multiplicacion de matrices
mulMat(M1,M2)-> M2T=transpuesta(M2),[[prodVect(FIL,COL)||COL<-M2T] || FIL<-M1].


% Elevar un numero B a la E (B^E)
potencia(_B,0)->1;
potencia(B,E)when E rem 2 =:= 0-> R = potencia(B,E div 2), R*R; %guard
potencia(B,E)-> R = potencia(B,E div 2), B*R*R.

% Matriz identidad
identidad(0)->[];
identidad(N)->[[1|[0||_X<-lists:seq(2,N)]]|[[0|Fil]||Fil<-identidad(N-1)]].

% Elevar Matrices a la N
expLog(M,0)->identidad(length(M));
expLog(M,N)when N rem 2 =:= 0-> R = expLog(M,N div 2), mulMat(R,R);
expLog(M,N)-> R = expLog(M, N div 2), C = mulMat(R,R), mulMat(C,M).

% Fibonacci
fibonacci(0)->0;
fibonacci(N)->[[_FN1, FN],[FN,_FN2]] = expLog([[0,1],[1,1]],N), FN.








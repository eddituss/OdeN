-module(piserver).
-export([piserver/1, generaHilos/3, consultaServer/1]).


punto()->{rand:uniform(), rand:uniform()}.

estaDentro({X,Y})-> (X*X+Y*Y) =< 1 .

contarDentro(0,_Bool)->0;
contarDentro(N,true)->1+contarDentro(N-1, estaDentro(punto()));
contarDentro(N,false)->contarDentro(N-1,estaDentro(punto())).

generaPunto(0)->{0,0};
generaPunto(N)->{contarDentro(N, estaDentro(punto())), N}. % {D,T}

print(K)->io:format("El valor es ~p~n",[K]).

piserver({D,T})->
    receive
        {stat, Server} -> Server ! {stat, 4*D/T}, piserver({D,T});
        {ND,NT} -> piserver({D+ND,T+NT});
        stats   -> print(4*D/T), piserver({D,T});
        kill  -> io:format("Me muero con pi = ~p ~n",[4*D/T])
    end.



generaHilos(Server,N,1)-> spawn( fun()-> Server ! generaPunto(N) end );
generaHilos(Server,N,Cant)->spawn( fun()-> Server ! generaPunto(N) end ),
                generaHilos(Server,N,Cant-1).


consultaServer(Server)-> Server ! {stat, self()},
    receive
        R -> io:format("Me llega ~p~n",[R])
    end.




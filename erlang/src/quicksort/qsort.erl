-module (qsort).
-export([qsort/1]).

qsort([]) -> [];
qsort([Pivot|T]) ->
  
  io:format(" >> ~p~n", [Pivot]),
  qsort([X || X <- T, X < Pivot])
  ++ [Pivot] ++
  qsort([X || X <- T, X > Pivot]).

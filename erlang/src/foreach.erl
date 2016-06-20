-module(foreach).
-export([test/1]).

test(N) ->
  for(1, N).
  
print(N) -> io:format("echo ~p~n ", [N]).

for(N, N) -> print(N);
for(I, N) -> [print(I)|for(I+1, N)].
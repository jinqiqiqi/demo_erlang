%%%-------------------------------------------------------------------
%%% @author kinch
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 21. Jun 2016 20:38
%%%-------------------------------------------------------------------
-module(udp_server).
-author("kinch").

%% API
-export([start/0, client/1]).

start() ->
  spawn(fun() -> server(4000) end).

server(Port) ->
  {ok, Socket} = gen_udp:open(Port, [binary]),
  io:format("Server opened socket: ~p~n", [Socket]),
  loop(Socket).

loop(Socket) ->
  receive
  % I removed the Msg variable here.
    {udp, Socket, Host, Port, Bin} ->
      io:format("Server received: ~p~n", [{Port, Bin}]),
      {Ref, N} = binary_to_term(Bin),
      Fac = fac(N),
      gen_udp:send(Socket, Host, Port, term_to_binary({Ref, Fac})),
      loop(Socket)
  end.


fac(0) -> 1;
fac(N) -> N* fac(N-1).


client(N) ->
  {ok, Socket} = gen_udp:open(0, [binary]),
  Ref = make_ref(),
  io:format("Client opened socket: ~p~n", [Socket]),
  ok = gen_udp:send(Socket, "localhost", 4000, term_to_binary({Ref, N})),
  wait_for_ref(Socket, Ref).

wait_for_ref(Socket, Ref) ->
  receive
    {udp, Socket, _Host, _Port, Bin} ->
      case binary_to_term(Bin) of
        {Ref, Val} ->
          io:format("new Value is: ~p~n", [Val]);
        {_SomeOtherRef, _} ->
          wait_for_ref(Socket, Ref)
      end
  after 2000 ->
    io:format(" timeout: 0~n")
  end,
  gen_udp:close(Socket).





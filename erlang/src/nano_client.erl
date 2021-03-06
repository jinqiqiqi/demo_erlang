%%%-------------------------------------------------------------------
%%% @author kinch
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. Jun 2016 20:56
%%%-------------------------------------------------------------------
-module(nano_client).
-author("kinch").

%% API
-export([eval/1]).

eval(Str) ->
  {ok, Socket} = gen_tcp:connect("localhost", 2345, [binary, {packet, 4}]),
  ok = gen_tcp:send(Socket, term_to_binary(Str)),
  receive
    {tcp, Socket, Bin} ->
      io:format("Client received binary = ~p~n", [Bin]),
      Val = binary_to_term(Bin),
      io:format("Client result = ~p~n", [Val]),
      gen_tcp:close(Socket);
    {tcp_closed, Reason} ->
      io:format("error, ~p~n", [Reason]),
      gen_tcp:close(Socket)

  end.
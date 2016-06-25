%%%-------------------------------------------------------------------
%%% @author kinch
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 21. Jun 2016 21:43
%%%-------------------------------------------------------------------
-module(broadcast).
-author("kinch").

%% API
-export([send/1, listen/0]).

send(IoList) ->
  case inet:ifget("en1", [broadaddr]) of
    {ok, [{broadaddr, Ip}]} ->
      {ok, S} = gen_udp:open(5010, [{broadcast, true}]),
      gen_udp:send(S, Ip, 6000, IoList),
      gen_udp:close(S);
    Any ->
      io:format("Bad interface name, or broadcasting not supported~n Msg: ~p~n", [Any])
  end.

listen() ->
  {ok, _} = gen_udp:open(6000),
  loop().

loop() ->
  receive
    Any ->
      io:format("received: ~p~n", [Any]),
      loop()
  end.




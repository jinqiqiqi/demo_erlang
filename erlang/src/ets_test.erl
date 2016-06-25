%%%-------------------------------------------------------------------
%%% @author kinch
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 22. Jun 2016 00:04
%%%-------------------------------------------------------------------
-module(ets_test).
-author("kinch").

%% API
-export([start/0]).

start() ->
  lists:foreach(fun test_ets/1, [set, ordered_set, bag, duplicate_bag]).

test_ets(Mode) ->
  TableId = ets:new(kinchdb, [Mode]),
  ets:insert(TableId, {a, 1}),
  ets:insert(TableId, {b, 2}),
  ets:insert(TableId, {a, 1}),
  ets:insert(TableId, {a, 3}),
  List = ets:tab2list(TableId),
  io:format("~-13w => ~p ~p ~n", [Mode, TableId, List]),
  ets:delete(TableId).

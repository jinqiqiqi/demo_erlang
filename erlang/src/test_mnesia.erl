%%%-------------------------------------------------------------------
%%% @author kinch
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 22. Jun 2016 21:26
%%%-------------------------------------------------------------------
-module(test_mnesia).
-author("kinch").

%% API
-export([do_this_once/0]).

-record(shop, {ite, quantity, cost}).
-record(cost, {name, price}).


do_this_once() ->
  mnesia:create_schema([node()]),
  mnesia:start(),
  mnesia:create_table(shop, [{attributes, record_info(fields, shop)}]),
  mnesia:create_table(cost, [{attributes, record_info(fields, cost)}]),
  mnesia:stop().

demo(select_shop) ->
  do(qlc:q([X|| X <- mnesia:table(shop)])).
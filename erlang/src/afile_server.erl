%%%-------------------------------------------------------------------
%%% @author kinch
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. Jun 2016 22:38
%%%-------------------------------------------------------------------
-module(afile_server).
-author("kinch").

%% API
-export([start/1, loop/1]).


start(Dir) -> spawn(afile_server, loop, [Dir]).

loop(Dir) ->
  receive
    {Client, list_dir} ->
      Client ! {self(), file:list_dir(Dir)};
    {Client, {get_file, File}} ->
      Client ! {self(), file:read_file(File)}
  end,
  loop(Dir).

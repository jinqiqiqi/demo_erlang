-module(area_server).
-export([start/0, area/2, loop/0]).

start() -> spawn(area_server, loop, []).

area(Pid, What) ->
    rcp(Pid, What).

rcp(Pid, Request) ->
    Pid ! {self(), Request},
    receive
%%        {Pid, Response} ->
%%            Response
        Any -> {Any, xx}
    end.

loop() ->
    receive
        {From, {rectangle, Width, Ht}} ->
            From ! {self(), Width* Ht},
            loop();
        {From, {circle, R}} ->
            From ! {self(), 3.1415926* R * R},
            loop();
            
        {From, Other} ->
            From ! {self(), {error, Other}},
            loop()
    end.
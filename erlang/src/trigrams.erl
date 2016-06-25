%%%-------------------------------------------------------------------
%%% @author kinch
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 22. Jun 2016 21:02
%%%-------------------------------------------------------------------
-module(trigrams).
-author("kinch").

%% API
-export([]).

for_each_trigram_in_the_english_language(F, A0) ->
  {ok, Bin0} = file:read_file("dict.gz"),
  Bin = zlib:gunzip(Bin0),
  scan_word_list(binary_to_term(Bin), F, A0).


scan_word_list([], _, A) ->
  A;
scan_word_list(L, F, A) ->
  {Word, L1} = get_next_word(L, []),
  A1 = scan_trigrams([$\s|Word], F, A),
  scan_word_list(L1, F, A1).

get_next_word([$\r, $\n|T], L) ->
  {reverse([$\s|L]), T};
get_next_word([H|T], L) ->
  get_next_word(T, [H|L]);
get_next_word([], L) ->
  {reverse([$\s|L], [])}.

scan_trigrams([X, Y, Z], F, A) ->
  F([X, Y, Z], A);
scan_trigrams([X, Y, Z|T], F, A) ->
  A1 = F([X, Y, Z], A),
  scan_trigrams([Y, Z|T], F, A1);
scan_trigrams(_, _, A) ->
  A.
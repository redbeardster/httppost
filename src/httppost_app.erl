-module(httppost_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
	{'_', [
	    {"/", httppost, []}
	]}
    ]),

    {ok, _} = cowboy:start_http(http, 200, [{port, 8111},{backlog, 9192},  {max_connections, infinity}], [
	{env, [{dispatch, Dispatch}]}]),


    httppost_sup:start_link().

stop(_State) ->
    ok.

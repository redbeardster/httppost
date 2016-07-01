-module(httppost_app).
-behaviour(application).
-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    
    Config = application:get_all_env(rediska),
    HTTPPort = proplists:get_value(http_port, Config),
    Dispatch = cowboy_router:compile([
	{'_', [
	    {"/", httppost, []}
	]}
    ]),

    {ok, _} = cowboy:start_http(http, 200, [{port, HTTPPort},{backlog, 9192},  {max_connections, infinity}], [
	{env, [{dispatch, Dispatch}]}]),


    httppost_sup:start_link().

stop(_State) ->
    ok.

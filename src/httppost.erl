-module(httppost).
-export([init/2]).

init(Req, Opts) ->
    QsVals = cowboy_req:body_qs(Req),
    {ok,[{<<"echo">>, Value}], _} = QsVals,
    Req2 = echo(Value, Req),
    {ok, Req2, Opts}.

echo(undefined, Req) ->
	cowboy_req:reply(400, [], <<"Missing echo parameter.">>, Req);

echo(Value, Req) ->
	rediska ! {request, Value},
	cowboy_req:reply(200, [{<<"content-type">>,<<"text/plain; charset=utf-8">>}], Value, Req).

@ECHO off


@md ebin
erl -noshell -s make all -s init stop


erl -pa ebin -s server


PAUSE

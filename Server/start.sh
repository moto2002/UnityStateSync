#!/bin/bash


mkdir ebin -p
erl -noshell -s make all -s init stop


erl -pa ebin -s server

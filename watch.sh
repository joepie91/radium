#!/bin/bash
coffee -w -c -j gemswap.coffee -o gemswap/ gemswap/*.coffee&
coffee -w -c -j radium.coffee -o compiled/ radium/*.coffee

#!/bin/bash
coffee -w -c -j easing.coffee -o easing/ easing/*.coffee&
coffee -w -c -j gemswap.coffee -o gemswap/ gemswap/*.coffee&
coffee -w -c -j radium.coffee -o compiled/ radium/*.coffee

#!/bin/sh

luac -s -o ekwipunek.luac ekwipunek.lua
luac -s -o intro.lua intro_.lua
luac -s -o gui_c_.luac gui_c_.lua
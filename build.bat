@echo off

pushd dwrite
cl /Zi /nologo /c /EHsc /FC /I. wrapper.cpp
lib /OUT:wrapper.lib wrapper.obj
popd

pushd
odin build .
popd
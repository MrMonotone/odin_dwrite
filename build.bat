@REM @echo off

pushd dwrite
del wrapper.obj wrapper.lib
cl /Zi /nologo /c /EHsc /FC /I. wrapper.cpp
lib /OUT:wrapper.lib wrapper.obj
popd

pushd
odin build . -debug
popd
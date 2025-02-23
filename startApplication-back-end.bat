@echo off

set "PASTA=mysql_data"

docker-compose down -v

if exist "%PASTA%" (
    echo Excluindo pasta %PASTA%...
    rmdir /S /Q "%PASTA%"
) else (
    echo Pasta %PASTA% não encontrada.
)


docker-compose -f docker-compose.dev.yaml up --build -d
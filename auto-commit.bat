@echo off

REM === Caminho do projeto ===
cd /d C:\qa-auto-commit-horario

REM === Verifica se existem mudanças ===
git status --porcelain > changes.txt

REM === Se o arquivo estiver vazio, não há mudanças ===
for %%A in (changes.txt) do if %%~zA==0 (
    del changes.txt
    exit /b
)

REM === Há mudanças: fazer commit ===
git add Scripts
git commit -m "Atualização automática dos scripts"
git push origin main

REM === Limpeza ===
del changes.txt

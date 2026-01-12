@echo off
cd /d C:\qa-auto-commit-evento || exit /b

git add .

git diff --cached --quiet
IF %ERRORLEVEL% NEQ 0 (
    git commit -m "auto commit v2 %date% %time%"
    git push origin main
)

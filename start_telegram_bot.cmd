@echo off
title OpenCode Telegram Bot 24/7
cd /d "D:\OpenCode\opencode-telegram-bot"
echo [%date% %time%] Starting opencode-telegram-bot...
node start-patched.cjs
echo [%date% %time%] Bot exited with code %errorlevel%.
pause

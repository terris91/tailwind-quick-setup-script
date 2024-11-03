@echo off

mkdir src
echo @tailwind base; > src\input.css
echo @tailwind components; >> src\input.css
echo @tailwind utilities; >> src\input.css

mkdir build

call npm init -y
setlocal disabledelayedexpansion
(for /f "tokens=1* delims=]" %%a in ('find /n /v "" package.json') do ( 
  echo %%b|findstr /rc:"\ *\"test\":\ \".*\"" >nul && (
    echo    "dev": "vite"
    ) || echo/%%b
)) > temp.json && move /y temp.json package.json

call npm install -D tailwindcss postcss autoprefixer vite

echo module.exports = { > postcss.config.js
echo.  plugins: { >> postcss.config.js
echo.    tailwindcss: {}, >> postcss.config.js
echo.    autoprefixer: {}, >> postcss.config.js
echo.  }, >> postcss.config.js
echo } >> postcss.config.js

echo /** @type {import('tailwindcss').Config} */ > tailwind.config.js
echo module.exports = { >> tailwind.config.js
echo.  content: ["./src/**/*.{js,jsx,ts,tsx}"], >> tailwind.config.js
echo.  theme: { >> tailwind.config.js
echo.    extend: {}, >> tailwind.config.js
echo.  }, >> tailwind.config.js
echo.  plugins: [], >> tailwind.config.js
echo } >> tailwind.config.js



pause
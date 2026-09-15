#!/usr/bin/env bash
set -e

# Descobre o diretório onde o repositório foi clonado
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$HOME/.local/bin"

# 1. Garante que a pasta exista
mkdir -p "$BIN_DIR"

# 2. Permissão de execução nos arquivos fonte
chmod +x "$REPO_DIR/meditar" "$REPO_DIR/pomodoro"

# 3. Criação forçada dos links simbólicos
ln -sf "$REPO_DIR/meditar" "$BIN_DIR/meditar"
ln -sf "$REPO_DIR/pomodoro" "$BIN_DIR/pomodoro"

# 4. Garante a linha no ~/.bashrc sem checagens frágeis
LINE_TO_ADD='export PATH="$HOME/.local/bin:$PATH"'
if ! grep -Fxq "$LINE_TO_ADD" "$HOME/.bashrc"; then
    echo "$LINE_TO_ADD" >> "$HOME/.bashrc"
fi

echo "Instalado com sucesso em $BIN_DIR!"
echo "ATENÇÃO: Digite 'source ~/.bashrc' para ativar os comandos nesta aba."

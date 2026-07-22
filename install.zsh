#!/usr/bin/env zsh
cd "$(dirname "$0")"

echo "Instalando dependências do sistema..."
sudo pacman -S --needed stow gnome-keyring libsecret seahorse nodejs npm

echo "Linkando dotfiles com Stow..."
stow git hypr nvim vscode zsh

echo
echo "Passos manuais restantes (não automatizáveis com Stow):"
echo "1. git: na próxima operação (push/pull), autenticar com o token do GitHub salvo (validade 1 ano)."
echo "2. Botão de energia: editar /etc/systemd/logind.conf manualmente (ver seção do README)."
echo "3. Abrir o nvim uma vez para o lazy.nvim instalar os plugins e o Mason instalar os LSPs (clangd, pyright, jdtls, lua_ls)."
echo "4. Rodar 'exec zsh' para aplicar as configs do zsh (vi-mode via hook precmd)."git
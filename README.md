# dotfiles

Configurações pessoais gerenciadas via git e [GNU Stow](https://www.gnu.org/software/stow/).

## Estrutura

dotfiles/

├── git/ → ~/.gitconfig

├── hypr/ → ~/.config/hypr/userprefs.conf

├── nvim/ → ~/.config/nvim/

├── vscode/ → ~/.vscode-oss/argv.json

├── zsh/ → ~/.config/zsh/user.zsh

└── install.zsh

O botão de energia (long-press poweroff) **não** é tracked aqui — ver seção própria abaixo.

## Recuperação pós-formatação

### 1. Dependências do sistema

```bash
sudo pacman -S --needed git stow gnome-keyring libsecret seahorse nodejs npm
```

(`nodejs`/`npm` são necessários para o Mason instalar LSPs como o `pyright` dentro do Neovim.)

### 2. Clonar o repositório

```bash
git clone https://github.com/<seu-usuario>/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Na primeira operação (`git push`/`pull`), o git vai pedir usuário e token do GitHub — cole o token salvo (validade de 1 ano). O `libsecret` guarda a partir daí; login manual só se repete se o token expirar.

### 3. Linkar tudo com Stow

```bash
stow git hypr nvim vscode zsh
```

Isso recria todos os arquivos acima como symlinks apontando pro conteúdo já versionado — nenhuma configuração precisa ser refeita manualmente.

Conferir se ficou certo:
```bash
ls -la ~/.gitconfig ~/.config/hypr/userprefs.conf ~/.vscode-oss/argv.json ~/.config/zsh/user.zsh
```

### 4. Neovim: instalar plugins e LSPs

Abrir o nvim uma vez — o `lazy.nvim` se bootstrapa e instala os plugins automaticamente:
```bash
nvim
```
O Mason instala os LSPs (`clangd`, `pyright`, `jdtls`, `lua_ls`) sozinho via `ensure_installed`. Se algum falhar, checar `:Mason` / `:MasonLog`.

### 5. Zsh: aplicar as configs

```bash
exec zsh
```
Isso recarrega a sessão do zero, respeitando a ordem de carregamento do HyDE (`HYDE_ZSH_DEFER`) — os binds do vi-mode são aplicados via hook `precmd` que roda depois de tudo carregado.

### 6. Script de conveniência

Os passos 1 e 3 (dependências + stow) também estão automatizados em:
```bash
./install.zsh
```

## Botão de energia: long-press para desligar

**Por que não é um dotfile:** um drop-in em `/etc/systemd/logind.conf.d/`
não teve efeito (motivo não identificado — possivelmente outro drop-in
sobrescrevendo, ou HyDE/Hyprland interceptando o evento antes do
logind). A solução que funcionou foi editar `/etc/systemd/logind.conf`
diretamente, então este passo precisa ser refeito manualmente após uma
formatação.

Editar `/etc/systemd/logind.conf` (requer sudo) e garantir estas linhas
na seção `[Login]`:

```ini
HandlePowerKey=ignore
HandlePowerKeyLongPress=poweroff
```

Aplicar sem reiniciar o sistema:

```bash
sudo systemctl restart systemd-logind
```

Conferir se a config está mesmo ativa:

```bash
systemd-analyze cat-config systemd/logind.conf
```

Requer systemd ≥ 256 (`systemctl --version`).

## VS Code: usar o gnome-keyring (evita login repetido em extensões/Copilot)

Pacotes necessários: os mesmos já usados pelo git (`gnome-keyring`,
`libsecret`) — nada adicional.

Arquivo tracked em `vscode/.vscode-oss/argv.json`:

```json
{
  "password-store": "gnome-libsecret"
}
```

Na primeira abertura após linkar, o VS Code pode pedir para definir
uma senha do keyring padrão — use a mesma do login do sistema. A
partir daí, logins de extensões (GitHub, Copilot, etc.) ficam salvos
no gnome-keyring e não são pedidos de novo a cada abertura.

## Notas

- Só o `user.zsh` é versionado dentro de `~/.config/zsh/` — não a
  pasta inteira, já que o HyDE gerencia outros arquivos ali.
- O token do GitHub não precisa de backup: se for perdido, gerar um novo é trivial.
# dotfiles
Este repositório reúne todos os dotfiles que me ajudam a explorar as maravilhas do Arch Linux/Hyprland.

Faltando o README, finalizar o nvim (bugs), git também, zsh também.

Quero colocar tbm o guia de login no vscode (one-time login; sem precisar ficar logando direto) - talvez um arquivo de config que pode ser executado com install.sh (argv.json)

## Botão de energia: long-press para desligar

**Por que não é um dotfile:** em uma tentativa anterior, um drop-in em
`/etc/systemd/logind.conf.d/` não teve efeito (motivo não identificado —
possivelmente outro drop-in sobrescrevendo, ou HyDE/Hyprland
interceptando o evento antes do logind). A solução que funcionou foi
editar `/etc/systemd/logind.conf` diretamente, então o passo abaixo
precisa ser refeito manualmente após uma formatação.

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

Pacotes necessários: os mesmos já usados pelo git (`gnome-keyring`, `libsecret`) — nada adicional além disso.

Editar (ou criar) `~/.config/Code/argv.json`

```json
{
  "password-store": "gnome-libsecret"
}
```

Reiniciar o VS Code. Na primeira vez, ele pode pedir para definir uma
senha do keyring padrão — use a mesma do login (evita popups extras
depois). A partir daí, logins de extensões (GitHub, Copilot, etc.)
ficam salvos no gnome-keyring e não são pedidos de novo a cada
abertura.

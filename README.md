# My Linux config files

Este repositorio contiene mis archivos de configuración personal (dotfiles). Utilizo **GNU Stow** para gestionarlos de forma sencilla y centralizada [3, 4].

## 📂 ¿Cómo funciona?

En lugar de tener los archivos dispersos en el sistema, todos viven en esta carpeta. **GNU Stow** crea "accesos directos" (enlaces simbólicos) desde aquí hacia tu carpeta personal (_home_) [1, 5, 6].

Lo mejor de este sistema es que los archivos quedan **"casados"**: si editas la configuración en tu terminal, el cambio se guarda automáticamente aquí, listo para ser subido a GitHub [6, 7].

## 📦 Contenido

- **nvim**: Configuración de Neovim [8, 9].
- **tmux**: Gestión de terminal y plugins [10, 11].
- **zsh / zim**: Entorno de la terminal [1, 9].
- **git**: Identidad y alias globales [1].
- **Otros**: vscode, scripts de VPN y configuraciones de node (npm, pnpm, yarn).

## 🚀 Instalación Rápida

### 1. Requisitos

Instala Stow según tu sistema [1, 12]:

- **macOS**: `brew install stow`
- **Fedora**: `sudo dnf install stow`
- **Ubuntu/Debian**: `sudo apt install stow`

### 2. Clonar y Aplicar

```bash
# Clonar en el home
git clone https://github.com/tu-usuario/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Crear todos los accesos directos automáticamente
stow .
🛠️ Comandos Útiles
Agregar un paquete nuevo: Crea la carpeta del programa dentro de ~/.dotfiles imitando la ruta de tu home y ejecuta stow nombre-carpeta
.
Desinstalar (quitar enlaces): stow -D .
.
Sincronizar: Una vez aplicados los cambios, solo usa los comandos normales de Git (add, commit, push) para respaldar todo en la nube
.

--------------------------------------------------------------------------------
```

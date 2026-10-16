# Neovim Config

Configuración personal y modular de Neovim para macOS, Linux y Windows.

## Objetivo

Mantener una configuración única, documentada y versionada en GitHub
para utilizar Neovim en diferentes equipos.

## Plataformas

- macOS (MacBook)
- Linux (servidor ITPro)
- Windows (Lenovo, pendiente de instalación)

## Características

- Neovim 0.12.6
- Gestión de plugins mediante lazy.nvim
- Configuración modular en Lua
- Explorador lateral con nvim-tree
- Administración de archivos con Oil.nvim
- Búsqueda de archivos con Telescope
- Autocompletado y servidores LSP
- Formateo automático mediante Conform
- Resaltado de sintaxis mediante Treesitter
- Tema Catppuccin

## Atajos principales

| Atajo | Función |
|------|---------|
| Ctrl+B | Abrir/cerrar explorador lateral |
| Ctrl+P | Buscar archivos |
| - | Abrir Oil.nvim |
| gg | Inicio del archivo |
| G | Final del archivo |
| Ctrl+D | Bajar media pantalla |
| Ctrl+U | Subir media pantalla |

## Estructura

- `init.lua`: punto de entrada.
- `lua/config/`: opciones, atajos y configuración general.
- `lua/plugins/`: configuración modular de plugins.
- `lazy-lock.json`: versiones fijadas de plugins.

## Instalación

Las instrucciones específicas para macOS, Linux y Windows
se documentarán en `docs/`.

## Estado

- macOS: configurado.
- Linux: configurado.
- Windows: pendiente.

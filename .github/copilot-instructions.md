# AI Agent Instructions for Dotfiles Repository

## Architecture Overview
This is a macOS-focused dotfiles repository using a symlink-based configuration management system. Key components:
- **Symlink System**: Files ending in `.symlink` are automatically linked to `~/.filename` during bootstrap
- **Tool-Centric Organization**: Configurations grouped by tool (zsh, git, vscode, macos, etc.)
- **Homebrew Integration**: Dependencies managed via `Brewfile`, installed via `brew bundle`

## Critical Workflows

### Initial Setup
```bash
git clone git@github.com:mayoralito/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap                    # Basic setup (symlinks only)
script/bootstrap --update-dependencies  # Full setup with Homebrew dependencies
```

### Updates & Maintenance
- Run `dot` command to pull updates, set macOS defaults, upgrade Homebrew packages
- Use `reload!` to reload ZSH configuration after changes
- Local customizations go in `~/.localrc` (not tracked in git)

### Adding New Configurations
1. Create `toolname/filename.symlink` files
2. Run `script/bootstrap` or `dot` to symlink them
3. Add corresponding `toolname/install.sh` for any setup commands

## Project-Specific Patterns

### ZSH Configuration Loading Order
```zsh
# 1. Load path files first
for file in ${(M)config_files:#*/path.zsh}; do source $file; done

# 2. Load everything except path/completion
for file in ${${config_files:#*/path.zsh}:#*/completion.zsh}; do source $file; done

# 3. Initialize completion
autoload -U compinit; compinit

# 4. Load completion files last
for file in ${(M)config_files:#*/completion.zsh}; do source $file; done
```

### Git Configuration Split
- Global config: `git/gitconfig.symlink` (tracked)
- Local config: `git/gitconfig.local.symlink` (generated from template, contains personal info)
- Use `git/gitconfig.local.symlink.example` as template for new setups

### macOS Defaults
- Configured via `defaults write` commands in `macos/set-defaults.sh`
- Examples: Fast key repeat, Finder list view, Safari dev menu enabled
- Run via `dot` command or manually with `macos/set-defaults.sh`

### Homebrew Package Management
- All packages listed in root `Brewfile`
- Includes both `brew` formulas and `cask` applications
- Installed via `brew bundle` in `script/install`

## Key Files & Directories
- `Makefile`: OS-specific setup targets (macos/linux)
- `script/bootstrap`: Interactive gitconfig setup + dotfile symlinking
- `script/install`: Runs brew bundle + executes all `install.sh` scripts
- `bin/dot`: Update orchestration script
- `Brewfile`: Complete package manifest
- `zsh/zshrc.symlink`: Main ZSH configuration with dynamic loading

## Development Environment
- **Shell**: ZSH with custom prompt and aliases
- **Editor**: Vim (configured in git), VS Code available
- **Package Manager**: Homebrew with Brewfile
- **Container**: Apple's Container tool for Kali Linux VMs
- **Cloud Tools**: AWS CLI, Terraform, Docker/Colima

## Integration Points
- **External Dependencies**: Terraform, Docker, AWS CLI, Ruby (rbenv), Node.js (nvm)
- **Cross-Component**: Symlink system affects all tool configurations
- **OS-Specific**: macOS defaults, Homebrew packages, container setup
- **Version Management**: rbenv for Ruby, nvm for Node.js (via Brewfile)
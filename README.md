# Setup

Install [stow](https://www.gnu.org/software/stow/)

symlink

```bash
stow -vSt ~ source
```

unlink

```bash
stow -vDt source
```

examples:

symlink

```bash
stow -vSt ~ nvim
```

unlink

```bash
stow -vDt nvim
```

symlink all after cloning

```bash
cd files && stow -vSt ~ *
```

Note:

stow will symlink based on the folder structure of the source. For example, to symlink nvim config to `~/.config/nvim`, the folder structure of your nvim config source must be `nvim/.config/nvim`.

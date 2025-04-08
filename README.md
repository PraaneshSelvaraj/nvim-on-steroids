# 🧨 nvim-on-steroids

Welcome to **nvim-on-steroids** — my **beautiful mess** of a Neovim config. A spiritual sequel to Kickstart.nvim, except this one comes with more sarcasm, more tears, and way more ways to accidentally break stuff.

> ⚠️ Warning: This config may cause sleep deprivation, spontaneous coffee addiction, and chronic over-customization syndrome.

-------

## ⚡ What is this?

This is my **Neovim setup**. Or should I say... my endless journey through plugin rabbit holes, dependency hell, and Lua-induced migraines. Built with `Lazy.nvim`, cursed with hope.

It's modular. It's sarcastic. It's angry. It's written by a caffeine-overdosed human whose idea of fun is debugging broken LSPs at 3AM.

> Inspired by [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) because I believed in a lie that Neovim config could be "simple."

---

## ✨ Features (lol)

- 📁 **Modular config** – because monoliths are for people who hate folders.
- 💤 **Lazy.nvim** – plugins load when they *feel like it*, not when you want them to.
- 🧠 **LSP support** – until it randomly stops working, and you end up reading LSP logs like it's Shakespeare.
- 🔬 **Linters & formatters** – to remind you just how bad your code really is.
- ⌨️ **Keybindings** – some are helpful, some will confuse future-you.
- 🎨 **Tokyo Night theme** – because crying should at least look good.
- 🚀 **Zero startup time** (*subjective, not guaranteed, lol*).

---

## 📦 Dependencies

You’ll need the following, because of course you do:

- Neovim **0.9+** – *don’t even try this with 0.8 unless you hate yourself.*
- [`ripgrep`](https://github.com/BurntSushi/ripgrep)
- [`fd`](https://github.com/sharkdp/fd)
- `node` – because half the plugins speak JavaScript.
- `python3` – for those LSPs and random virtualenv voodoo.
- `java` – if you want to relive your nightmares from engineering college.
- `pylint`, `clang-tidy`, `markdownlint-cli` – or just ignore their complaints like the rest of us.

---

## 🛠️ Installation

Clone it. Regret it. Cry. Maybe smile once it works.

```bash
git clone https://github.com/PraaneshSelvaraj/nvim-on-steroids ~/.config/nvim
```

Then open Neovim. Watch the magic happen. Or don’t. Because sometimes it doesn’t.

First run:

```sh
nvim
```

---

## 🧙‍♂️ Folder Structure

```bash
nvim/
├── lua/
│   └── vimboi/         # Because calling it "user" is too basic
│       ├── core/       # Core configs: options, keymaps, autocmds, the usual suspects
│       └── plugins/    # Where plugins live and cry
├── ftplugin/           # Don't know what's this for
└── init.lua            # The point of no return
```

It's structured. It's modular. It's also held together with duct tape and fragile hope.

---

## 🤬 Troubleshooting

> “Hey, something broke!”  
Wow, what a surprise. Welcome to the club.

- Check your Neovim version. If it's not `0.9+`, upgrade or face the wrath.
- Run `:Lazy` and look for angry red errors.
- Delete `~/.local/share/nvim`, `~/.cache/nvim`, and `~/.config/nvim/lazy-lock.json`, then try again with more optimism (or alcohol).
- Still not working? That's the *experience*.

---

## 🤡 FAQ

**Q: Why not just use VS Code?**  
A: Because I enjoy pain and typing `:w` every 3 seconds.

**Q: Can I customize it?**  
A: Sure! But be prepared to fight `nil` errors like it’s Elden Ring.

**Q: Why so many plugins?**  
A: Because I have commitment issues and FOMO.

**Q: Is this beginner-friendly?**  
A: If by "beginner" you mean someone with infinite patience and emotional resilience, yes.

---

## 🐸 Final Words

This config is like IKEA furniture: it looks good when it works, but the moment you touch something, you're missing a screw and cursing in 3 languages.

Enjoy the chaos. Or don’t. I’ll be over here rewriting this for the 15th time.

Peace ✌️

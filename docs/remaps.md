# Custom Remaps
This section is for documented custom remaps and some plugins remaps.

## NeoVim Remaps
`<leader>f`: Open file explorer.

### Search (Using telescope)
`<leader>/`: Search all files.

`<C-p>`: Search git files. Fallback to all files search.

`<C-f>`: Search files contents (Live grep)>

`<leader>b`: Search in opened buffers.

### Clipboard
`<leader>y`: Yank to system's clipboard.

`<leader>p`: Paste from system's clipboard.

`<leader>d`: "Cut" to system's clipboard.

### Buffers
`<Tab>`, `<S-Tab>`: Next, Previous buffer.

### Windows (Integrated with Tmux panes)
`<C-[hjkl]>`: Move to window.

`<M-[hjkl]>`: Resize window.

`<M-|>`: Split vertically.

`<M-->`: Split horizontally.

### Text Manipulation
`K`, `J` (In visual mode): Move selected text up and down.

### Navigate Inside Code

`[g`, `]g`: Next uncommited git change.

#### Using treesitter
`[[`, `]]`: Previous, Next function.

`[l`, `]l`: Previous, Next loop.

`[c`, `]c`: Previous, Next condition.

##### New Motions
`af`, `if`: Around function, In function.

`ac`, `ic`: Around class, In class (Work with go struct).

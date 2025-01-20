# Helix configuration

## Prerequisits
- [Language Support] nodejs/npm 
- [Language Support] go

## Language servers setup
### Setup Langauage servers for frontend
Html, Js, Ts, Css, Jsx, Tsx
> INFO: if using nix home manager run this first
```bash
npm set prefix ~/.npm-global
```

This will setup the required node packages
```bash
npm i -g @tailwindcss/language-server vscode-langservers-extracted@4.8 @fsouza/prettierd typescript typescript-language-server
```
### Setup Language server for go
```bash
go install golang.org/x/tools/gopls@latest
```

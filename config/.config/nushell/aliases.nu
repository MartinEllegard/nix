
alias l = ls --all
alias c = clear
alias ll = ls -l
alias lt = eza --tree --level=2 --long --icons --git
alias v = nvim

#alias update-os = "sudo pacman -Syu; cd ~/nix; stow config -t ~/; home-manager switch --flake ~/nix" 
#alias hms = home-manager switch
#alias as = aerospace

alias cd = z
alias v = fd --type f --hidden --exclude .git --exclude node_modules | fzf-tmux -p --reverse | xargs nvim
#vim
alias vi = nvim
alias vim = nvim
alias svi = sudo nvim
# Git
alias gc = git commit -m
alias gca = git commit -a -m
alias gp = git push origin HEAD
alias gpu = git pull origin
alias gst = git status
alias glog = git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit
alias gdiff = git diff
alias gco = git checkout
alias gb = git branch
alias gba = git branch -a
alias gadd = git add
alias ga = git add -p
alias gcoall = git checkout -- .
alias gr = git remote
alias gre = git reset

# K8s
alias k = kubectl
alias ka = kubectl apply -f
alias kg = kubectl get
alias kd = kubectl describe
alias kdel = kubectl delete
alias kl = kubectl logs
alias kgpo = kubectl get pod
alias kgd = kubectl get deployments
alias kc = kubectx
alias kns = kubens
alias kl = kubectl logs -f
alias ke = kubectl exec -it

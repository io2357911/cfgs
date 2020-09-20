cfg: \
	cfg-termite \
	cfg-tmux \
	cfg-make \
	cfg-nvim \
	cfg-vifm \
	cfg-zathura \
	cfg-keyboard

cfg-termite:
	$(call cfg_home,termite)

cfg-tmux:
	$(call cfg_home,tmux)
	
	rm -rf ~/.tmux
	mkdir -p ~/.tmux
	git clone https://github.com/tmux-plugins/tmux-resurrect.git ~/.tmux/resurrect
	cd ~/.tmux/resurrect ; git checkout 3a31bfbbb835c3d32f25702182cb5deab2a612ae
	cp -v tmux/fix_first_window_name.patch ~/.tmux/resurrect
	cd ~/.tmux/resurrect ; patch -p1 < fix_first_window_name.patch

cfg-make:
	$(call cfg_home,make)

PLUG_VIM_FILE=~/.local/share/nvim/site/autoload/plug.vim

cfg-nvim:
	$(call cfg_home,nvim)

	if [ ! -f $(PLUG_VIM_FILE) ]; then \
		curl -fLo $(PLUG_VIM_FILE) --create-dirs \
    		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim; \
	fi

cfg-vifm:
	$(call cfg_home,vifm)

cfg-zathura:
	$(call cfg_home,zathura)

cfg-keyboard:
	$(call cfg_root,keyboard)

cfg-idea:
	$(call cfg_home,idea)

install-pkglist:
	sudo pacman -Syu - < pkglist.txt

define cfg_home
	rsync -avb --suffix=.orig $1/home/ ~/
endef

define cfg_root
	sudo rsync -avb --suffix=.orig $1/root/ /
endef

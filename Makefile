clean_config:
	rm -rf ~/.config/nvim/*
install:  clean_config
	cp -R . ~/.config/nvim/

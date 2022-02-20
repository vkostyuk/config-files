SHELL:=/bin/bash

.PHONY: dev-packages
dev-packages:
	sudo apt update
	sudo apt install build-essential git libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev

python_ver := $(shell python3.8 -V 2>&1 | sed 's/.* \([0-9]\).\([0-9]\).*/\1\2/')
export python_ver
.PHONY: python
python:
	if [ "$(python_ver)" -lt "38" ]; then \
		cd /opt; \
		sudo wget https://www.python.org/ftp/python/3.8.12/Python-3.8.12.tgz; \
		sudo tar xzf Python-3.8.12.tgz; \
		cd Python-3.8.12; \
		sudo ./configure --enable-optimizations; \
		sudo make altinstall; \
		sudo rm -f Python-3.8.12.tgz; \
	else \
		echo "python already installed"; \
	fi

.PHONY: fzf
fzf:
	if ! [ -x "$$(command -v fzf)" ]; then \
		git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf; \
		~/.fzf/install; \
		rm -rf .fzf; \
	else \
		echo "fzf already installed"; \
	fi

.PHONY: bat
bat:
	if ! [ -x "$$(command -v bat)" ]; then \
		wget https://github.com/sharkdp/bat/releases/download/v0.19.0/bat-musl_0.19.0_amd64.deb; \
		sudo dpkg -i bat-musl_0.19.0_amd64.deb; \
		rm bat-musl_0.19.0_amd64.deb; \
	else \
		echo "bat already installed"; \
	fi

.PHONY: fish
fish:
	if ! [ -x "$$(command -v fish)" ]; then \
		cd ~; \
		git clone https://github.com/fish-shell/fish-shell.git; \
		cd fish-shell; \
		cmake .; \
		make; \
		sudo make install; \
	else \
		echo "fish already installed"; \
	fi


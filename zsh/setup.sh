# install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# link pure theme
if [ -d "$HOME/.zsh/" ]; then
	echo ".zsh文件夹存在"
	ln -sf $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/pure "$HOME/.zsh/"
else
	echo ".zsh文件夹不存在"
	mkdir "$HOME/.zsh" && ln -sf $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/pure "$HOME/.zsh/"
fi
#link zshrc
ln -sf ./zshrc "$HOME/.zshrc"

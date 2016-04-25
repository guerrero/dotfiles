# Zsh

These are my own config files for [Zsh][1]. They are based on [Prezto][2] with some personal modifications.


## Requirements

These config will work with any recent release of Zsh, but the minimum required version is 4.3.17.


## Installation

Launch Zsh:

```sh
zsh
```

Clone the repository:

```sh
git clone --recursive https://github.com/guerrero/zsh.git "${ZDOTDIR:-$HOME}/.dotfiles/zsh"
```

Then create a symbolic link into your home folder for each Zsh runcom file:

```sh
setopt EXTENDED_GLOB
for rcfile in "$HOME"/.dotfiles/zsh/runcoms/^README.md(.N); do
  ln -s "$rcfile" "$HOME/.${rcfile:t}"
done
```

Finally, set Zsh as your default shell:

```sh
chsh -s /bin/zsh
```


## Updating

Pull the latest changes and update submodules.

```sh
git pull && git submodule update --init --recursive
```


## License

(The MIT License)

Copyright (c) 2009-2011 Robby Russell and contributors.
Copyright (c) 2011-2014 Sorin Ionescu and contributors.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[1]: http://www.zsh.org
[2]: http://www.github.com/sorin-ionescu/prezto

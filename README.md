TODO
=========

global
---------
- Ajustar git modules
- Añadir script para añadir a cada carpeta su accion de carpeta


Bootstrap
---------

zsh
---------
- Add colors a zshell
- Hushlogin???

.osx
---------
- Check default mission control animation durations
- Añadir preferencias para el ratón y los lenguajes del teclado
- Añadir archivo para los keybindings
- Configurar para que no muestre el mensaje de los puntos
- Configurar para que muestre en la barra lateral los archivos que deseo
- No funciona la disposicion como lista
- Check if one of this defaults affects quick look views

.functions
----------
- Añadir comandos caffeinate

others
----------
- Ver si se puede desactivar el centro de notificaciones pero manteniendo las alertas
- Mirar si funciona bien lo de activar el tab para cambiar en los modales

Cask
----------
- Mirar si funciona export HOMEBREW_CASK_OPTS='--appdir=/Applications' con archivos de pkg de preferencias, sino poner al final de cada instalacion con cask --appdir=/Applications

Homebrew
---------
If you really need to use these commands with their normal names, you
can add a "gnubin" directory to your PATH from your bashrc like:

    PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

Additionally, you can access their man pages with normal names if you add
the "gnuman" directory to your MANPATH from your bashrc as well:

    MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

Ruta para corregir homebrew en bash (tambien necesito en zsh) => echo export PATH="/usr/local/bin:$PATH" >> ~/.bash_profile

----------------------------

Next versions
-----------------
- Buscar previews para instalar
- Proponer actualizar homebrew-cask o rm -r `brew --cache`/calibre-latest && brew cask uninstall calibre && brew cask install calibre'
- Cambiar tema de monokai por el mio propio
- Mirar si meter grc


sublime
--------
- Meter un tema, por lo demas esta todo bien

.osx
---------
- Modificar los dotfiles para poder volver a los osx por defecto si se desea, mirar la mejor forma, si en un mismo archivo o un archivo externo.

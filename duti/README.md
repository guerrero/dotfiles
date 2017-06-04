# Duti

`duti` is a command-line utility capable of setting default applications for
various document types on Mac OS X, using Apple's Uniform Type Identifiers. You can [find more info at its page](http://duti.org/)

## Contents

- `settings/handlers`: Plain text file with commands to establish which application will be used as default to open a certain type of file
- `setup.fish`: Script that runs duti with the info from `settings/handlers`
- `uninstall.fish`: Script to remove `duti` binary from the machine

## Dependencies

- Homebrew

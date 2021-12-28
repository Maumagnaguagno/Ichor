# Ichor [![Actions Status](https://github.com/Maumagnaguagno/Ichor/workflows/build/badge.svg)](https://github.com/Maumagnaguagno/Ichor/actions)
**Fast S-expression parser extension for Ruby**

The goal of this project is to have a fast ``to_sexpr`` method added to Ruby Strings to parse large [symbolic expression](https://en.wikipedia.org/wiki/S-expression) inputs.
This method only considers atoms and lists, quoted strings, nil and comments are currently not supported.
Whitespaces are used to distinguish atom sequences and are based on the [``isspace`` C function](https://www.cplusplus.com/reference/cctype/isspace/), which is limited to ASCII space values, Unicode whitespaces are currently outside scope.
The input string is expected to not contain [NUL](https://en.wikipedia.org/wiki/Null_character) before the end.

## Build

```Shell
cd Ichor
ruby extconf.rb
make
```

## Usage

```Ruby
require_relative 'ichor'
p '(define example (begin () end))'.to_sexpr
```
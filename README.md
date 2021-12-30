# Ichor [![Actions Status](https://github.com/Maumagnaguagno/Ichor/workflows/build/badge.svg)](https://github.com/Maumagnaguagno/Ichor/actions)
**Fast S-expression parser extension for Ruby**

The goal of this project is to have a fast ``to_sexpr`` method added to Ruby Strings to parse large [symbolic expression](https://en.wikipedia.org/wiki/S-expression) inputs.
Only atoms and lists are considered, quotes, nil and comments are currently not supported.
Whitespaces are used to separate atoms and are based on the [``isspace`` C function](https://www.cplusplus.com/reference/cctype/isspace/), which is limited to ASCII space values.
Parsing stops once a [NUL](https://en.wikipedia.org/wiki/Null_character) is reached.

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
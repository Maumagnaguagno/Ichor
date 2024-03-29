# Ichor [![Actions Status](https://github.com/Maumagnaguagno/Ichor/workflows/build/badge.svg)](https://github.com/Maumagnaguagno/Ichor/actions)
**Fast S-expression parser extension for Ruby**

The goal of this project is to add to Ruby a fast ``String#to_sexpr`` method to parse large [symbolic expressions](https://en.wikipedia.org/wiki/S-expression).
Only atoms and lists are considered, quotes, nil and comments are currently out of scope.
Atoms are expected to be encoded in ASCII and separated by whitespaces, characters with value between 1 and 32.
An exception is raised when missing an open/close parentheses or the expression is malformed.
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

```Shell
ruby -r ./ichor.so -e "p '(+ 2 3)'.to_sexpr"
```
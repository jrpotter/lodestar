Lodestar Plugin
===============

Lodestar is a quickly accessable vim plugin conceptualized to contain computer science-related
content such as data structures, algorithms, etc (though this is not strictly necessary). 

The plugin works by scanning the default lodes directory ($VIM/lodes), though this can be changed
by altering the lodestar#lodes_path variable in autoload/lodestar.vim. By modifiying each lode's
corresponding manifest files, one can quickly construct a hierarchy on which to navigate for use
in vim.

By default, the following keys are used:
* `<F2>` - Open up the lodestar menu. Override by mapping <Plug>LodestarMain in your .vimrc file
* `<CR>` - Open up directory, or open file in previous buffer
* `j`    - Move cursor down
* `k`    - Move cursor up
* `o`    - Same as `<CR>`
* `v`    - Open node in a vertically split window
* `h`    - Open node in a horizontally split window
* `r`    - Refresh current directory
* `w`    - Open wikipedia reference
* `l`    - Leave menu
* `q`    - Quit menu
* `?`    - Display help

Lodes & the Manifest
--------------------

### Title

Like the header suggests, marks the title of the lode. Note all lodes are ordered
alphabetically (unless categorized). The only mandatory piece of the manifest.

```javascript
  "Title" = "AVL Tree"
```

### Links

Marks the names of all links relative to the lode directory. Note this does not
mark which elements are shown- rather, it allows a pretty name. Files without
a name default to the filename itself.

```javascript
  "Links" = {
      "Python"  : "./avl.py",
      "Haskell" : "./avl.hs",
      "README"  : "./README.md"
  }
```

### Ignore

Marks all files to not include in the lode. Note that the manifest file is,
by default, ignored. If you really want to see this (which kind of defeats the
purpose of the file!) change the source ;).

```javascript
  "Ignore" = [
      "hide_this_file.txt",
      "hide_this_one_too.pl"
  ]
```

### Wikipedia

One can get a list of sections and content written out to a buffer when
pressing `w` over a node. If the manifest file specifies the following, 
lodestar queries the value passed. Otherwise it defaults to searching the
title and displaying the results of the first find.

Formatting isn't as clean as desired, though this will be addressed in
future versions.

```javascript
  "Wikipedia" : "Algorithm"  
```

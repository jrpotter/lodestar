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
* `l`    - Leave menu
* `q`    - Quit menu

Lodes & the Manifest
--------------------

### Title

```javascript
  "Title" = "AVL Tree"
```

### Category

```javascript
  "Category" = "Tree"
```

### Links

```javascript
  "Links" = [
      { "Python"  : "./avl.py"    },
      { "Haskell" : "./avl.hs"    },
      { "README"  : "./README.md" }
  ]
```

### Foreign

```javascript
  "Foreign" = [
      "Wikipedia" 
  ]
```

### Ignore

```javascript
  "Ignore" = [
      "hide_this_file.txt",
      "hide_this_one_too.pl"
  ]
```

Vim Medium Mode
==========
Inspired by [hard mode](https://github.com/wikitopian/hardmode) but less...hard.

Medium mode is a Vim plugin that limits character-wise motions, but does not disable
them completely.  By default, medium mode will only allow two consecutive character-wise motions.

Usage
-----
Out of the box, medium mode will be automatically turned on and configured to
listen to the usual Vim motion keys.  See the documentation for configuration
instructions.

Todo
----
Medium mode is a work in progress.  In particular, a better way to determine when
to reset the motion counter would be useful.  Send a pull request if you have any
ideas or bugfixes!

Installation
------------
[Vundle](https://github.com/gmarik/vundle) or [Pathogen](https://github.com/tpope/vim-pathogen) is recommended

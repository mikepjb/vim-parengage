### A Vim plugin to engage with lisps (primarily clojure)

I'm building this plugin up using vader to drive a TDD approach.

reading the paredit.el emacs minor mode
paredit.vim, vim-sexp and my previous attempt vim-lispy

### Task List

- When inserting new parens before another a space should be inserted
    e.g (time) (second (X...)) not (time)(second (X...))
- Burping/slurping should work with } and ], not just )
- Add to documentation, vim 'native' ways of performing common paredit methods
- Actions like C-w should not debalance a sexp

### Further Questions

- should you be allowed to delete parens with x and motion commands like dtf?

### Contributing

Pull requests are welcome, if you'd like to talk about this project contact me on `vim-fireplace` on the Clojurians slack

### License

Copyright © Michael Bruce. Distributed under the same terms as Vim itself. See `:help license`.

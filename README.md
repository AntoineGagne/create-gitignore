# `create-ignore`

This is a short program to generate `.gitignore` files from the [`gitignore.io`](https://www.gitignore.io/) API.

## Installation

### Prerequisite

To install this program, you will need [`stack`](https://docs.haskellstack.org/en/stable/README/). 
The dependencies will be taken care of by `stack`.

### Installing

Assuming you have `stack`, you can simply run:

```sh
stack install
```

Then, you can call the program by calling `create-gitignore`.

### Auto-completion

You can enable auto-completion by adding the following line to your `.bashrc`:

```sh
eval "$(create-gitignore --bash-completion-script create-gitignore)"
```

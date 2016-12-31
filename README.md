# `create-ignore`

This is a short program to generate `.gitignore` files from the `gitignore.io` API.

## Prerequisite

To install this program, you will need [`stack`](https://docs.haskellstack.org/en/stable/README/).

## Installation

Assuming you have `stack`, you can simply run:

```sh
stack install
```

Then, you can call the program by calling its name `create-gitignore`.

## Auto-completion

You can enable auto-completion by adding the following lines in your `.bashrc`:

```sh
eval "$(create-gitignore --bash-completion-script create-gitignore)"
```

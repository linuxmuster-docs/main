<!-- logo -->
![linuxmuster-logo](https://raw.githubusercontent.com/linuxmuster/linuxmuster-artwork/master/logo/lmn-full-logo.svg)

# linuxmuster.net documentation

The project publishes the full documentation of linuxmuster.net.

[![build-badge]][build-url]
[![docs-badge]][docs-url]
[![issues-badge]][issues-url]

## Installation

Clone the repository "main" using git

```sh
   ~$ git clone https://github.com/linuxmuster-docs/main.git  # if you have no ssh-key within github
   ~$ git clone git@github.com:linuxmuster-docs/main.git # if you have a ssh-key within github
```

Install sphinx, e.g. using Ubuntu 22.04, do

```sh
   ~$  sudo apt install git python3-sphinx texlive texlive-latex-extra texlive-lang-german
```

Make a local copy of your documentation using

```sh
   ~$ cd main
   ~/main$ make clean
   ~/main$ make html
```

Later, if you work again on the repository, update it with

```sh

   ~/main$ git pull

```

## Contribute to the documentation

Fork the repository "main" within the [github-webinterface](https://github.com/linuxmuster-docs/main).

* Clone your fork

  ```sh
     ~$ git clone https://github.com/mein-github-konto/main.git docs
     ~$ cd docs
     ~/docs$ make html
  ``` 

* Make changes in your fork
* Commit your changes to your fork

  ```sh
     ~/docs$ git commit -a -m"bugfix for bug in ticket #314 ..."
  ```
  
* Push your changes to your fork on github

  ```sh
     ~/docs$ git push
  ```
  
* Create a new pull-request on github
* If you are done and the pull-request was merged, you can delete your fork and create a new one.

## Update your fork

Instead of deleting and creating a new fork you can bring your own fork up-to-date the following way:

* Any changes you made you have to stash away for a while:

  ```sh
     ~/docs$ git stash
  ```
  
* Add a remote tracking branch once:

  ```sh
     ~/docs$ git remote add upstream https://github.com/linuxmuster-docs/main.git
  ```
  
* Fetch and merge the remote master

 ```sh
     ~/docs$ git fetch upstream
     ~/docs$ git merge upstream/master
 ```

* (If the merge does not end in an fast-forward result, you better delete and refork.) Push your changes into your fork.

```sh
     ~/docs$ git push
```

* Now you can get your stashed away changes:

  ```sh
     ~/docs$ git stash pop
  ```

## Guidelines for documentation

The structure guide and style guide provide information on the design of our documentation. 

See our

- [Guidelines linuxmuster.net](https://docs.linuxmuster.net/de/latest/appendix/contribute/guidelines.html)
  

## Translation

We use 

- [Transifex](https://www.transifex.com/linuxmusternet/official-documentation/dashboard/)

to translate the documentation. Get started there!

## Build documentation in English

First you have to install ``sphinx-intl`` and the ``transifex-client``.

 ```sh
   $ pip install sphinx-intl
   $ pip install transifex-client
```

Make sure that ``sphinx-intl`` and ``transifex-client`` are in your PATH!

Then run to following commands (inside the document root):

 ```sh
   $ make gettext
   $ tx init
   $ sphinx-intl update -p build/locale -l en
   $ sphinx-intl update-txconfig-resources --pot-dir build/locale --transifex-project-name official-documentation
   $ tx pull -l en
   $ make -e SPHINXOPTS="-D language='en'" html
```
Read the 

- [Internationalization chapter in Sphinx-Docs](http://www.sphinx-doc.org/en/stable/intl.html)

for more details.

## Release History

* latest - v7.2
    * CHANGE: Updated docs according to current release status of linuxmuster.net
* 7.1
    * STATUS: Documentation reflects status v7.1 of linuxmuster.net
* 6.2
    * STATUS: Old documentation of the old version of linuxmuster.net
    * version with an english translation (EN)
 
## License for linuxmuster.net documentation

![GitHub License](https://img.shields.io/github/license/linuxmuster-docs/main)


<!-- Markdown link & img dfn's -->
[build-badge]: https://github.com/linuxmuster-docs/main/workflows/VerifyDocs/badge.svg
[build-url]: https://github.com/linuxmuster-docs/main/workflows/VerifyDocs/badge.svg
[docs-badge]: https://readthedocs.org/projects/linuxmuster/badge/?version=latest
[docs-url]: https://docs.linuxmuster.net/de/latest/?badge=latest
[issues-badge]: https://img.shields.io/github/issues/linuxmuster-docs/main
[issues-url]: https://img.shields.io/github/issues/linuxmuster-docs/main


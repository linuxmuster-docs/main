# linuxmuster.net documentation

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/linuxmuster-docs/">
    <img src="[https://www.linuxmuster.net/wp-content/uploads/2017/01/logo_homepage-1.png]" alt="Logo" width="80" height="80">
  </a>
</div>
The full documentation of linuxmuster.net.

image:: 
    :target: 
    :alt: Documentation Build Status


.. image:: http://readthedocs.org/projects/linuxmuster/badge/?version=latest
    :target: http://docs.linuxmuster.net/de/latest/?badge=latest
    :alt: Documentation Status

[![linuxmuster_docs][linuxmuster-image]][linuxmuster-url]
[![Build Status][travis-image]][travis-url]
[![Forks][forks-shield]][forks-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]


## Installation

Clone the repository "main" using git

```sh
   ~$ git clone https://github.com/linuxmuster-docs/main.git  # if you have no ssh-key within github
   ~$ git clone git@github.com:linuxmuster-docs/main.git # if you have a ssh-key within github
```

Install sphinx, e.g. under Ubuntu 22.04, do

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

Fork the repository "main" within the github-webinterface_

.. _github-webinterface: https://github.com/linuxmuster-docs/main

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
++++++++++++++++++++++++++++

The structure guide and style guide provide information on the design of our documentation. See our Guidelines

https://docs.linuxmuster.net/de/latest/appendix/contribute/guidelines.html.

## Translation

We use `Transifex <https://www.transifex.com/linuxmusternet/official-documentation/dashboard/>`__ to translate the documentation. Get started there!

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
## Release History

* latest [v7.2]
    * CHANGE: Updated docs according to release status
* 7.1
    * STATUS: Documentation reflects status of v7.1 of linuxmuster.net
* 6.2
    * STATUS: Old documentation of the old version of linuxmuster.net

Read the `Internationalization chapter <http://www.sphinx-doc.org/en/stable/intl.html>`__ in the offical sphinx documentation for a more detailed description.

<!-- Markdown link & img dfn's -->
[linuxmuster_docs]: https://img.shields.io/badge/:linuxmuster-docs
[linuxuster-image]: [https://github.com/linuxmuster-docs/main/workflows/VerifyDocs/badge.svg?style=for-the-badge](https://github.com/linuxmuster-docs/main/workflows/VerifyDocs/badge.svg)
[linuxmuster-url]: https://github.com/linuxmuster-docs/main/workflows/VerifyDocs/badge.svg
[issues-shield]: https://img.shields.io/github/issues/linuxmuster-docs/badge.svg?style=for-the-badge
[issues-url]: https://github.com/othneildrew/Best-README-Template/issues
[license-shield]: https://img.shields.io/github/license/linuxmuster-doc/slate.svg?style=for-the-badge
[license-url]: https://github.com/linuxmuster-docs/blob/master/LICENSE.txt

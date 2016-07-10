linuxmuster.net documentation
#############################

::

  All of me, why take not all of me.
                   -- Seymour Simons

Die gesamte Dokumentation zu linuxmuster.net.
Bindet die einzelnen Howtos und Leitfäden über subrepos ein.

The full documentation of linuxmuster.net.
Pulls in the separate howtos and guidelines via subrepos.

Installation
++++++++++++
Clone the repository "all-of-me" using git and later use ''git pull'' to update it

.. code:: bash

   ~$ git clone git@github.com:linuxmuster-docs/all-of-me.git
   ~$ git pull

Make a local copy of your documentation using 

.. code:: bash

   ~$ cd all-of-me
   ~/all-of-me$ make html


Changing the documentation
++++++++++++++++++++++++++

Install "git-subrepo"
---------------------

For this repository "all-of-me" to be changed, you need to "install" the tool git-subrepo (see https://github.com/ingydotnet/git-subrepo) in a local directory:

.. code:: bash

   ~$ git clone https://github.com/ingydotnet/git-subrepo /path/to/git-subrepo
   ~$ echo 'source /path/to/git-subrepo/.rc' >> ~/.bashrc
   ~$ source ~/.bashrc
   
Change in the upstream repos
----------------------------

Documentation can either be changed in the respective repository, commited locally there, pushed to the remote repository. (I call this "upstream" now). Now the repository "all-of-me" needs to update the respective subrepos, e.g. to update all subrepos at once

.. code:: bash

   ~/all-of-me$ git subrepo pull --all

This does several steps in one, you are ending up with the upstream changes merged and commited locally. Now push those changes also to the "all-of-me"-repository.

.. code:: bash

   ~/all-of-me$ git push

Change within the "all-of-me" repo
----------------------------------

Or you can change the documentation in the all-of-me repo altogether and later commit the changes back to upstream the following way:

1. Make sure the "all-of-me"-repository is up-to-date with upstream documentation

   .. code:: bash

      ~/all-of-me$ git subrepo pull --all
      Subrepo ... is up to date
      ...
      ~/all-of-me$ git pull 

   and, if necessary, commit and push the changes:
   
   .. code:: bash
   
      ~/all-of-me$ git push

2. Make your local changes to the files within the subrepo subdirectories, commit them and push the changes to the "all-of-me" repository

   .. code:: bash
   
      ~/all-of-me$ vi source/howtos/howto_printer/source/index.rst
      ~/all-of-me$ git status
      ~/all-of-me$ git commit -a "fix typo in printer docu"
   
   now push the changes within the subrepo to upstream, and pull immediatly back in
   
   .. code:: bash
   
      ~/all-of-me$ git subrepo push source/howtos/howto_printer 
      Subrepo 'source/howtos/howto_printer' pushed to 'git@github.com:linuxmuster-docs/howto_printer.git' (master).
      ~/all-of-me$ git subrepo pull source/howtos/howto_printer 
      Subrepo 'source/howtos/howto_printer' pulled from 'git@github.com:linuxmuster-docs/howto_printer.git' (master).

   now push the "all-of-me"-repository
   
   .. code:: bash
   
      ~/all-of-me$ git push

Adding new subrepos
+++++++++++++++++++

If a new howto is to be added, it is assumed the documentation of the howto is already in a repository. Now add it as a subrepo, optionally amend the commit, push it in the "all-of-me"-repo

.. code:: bash
 
   ~/all-of-me$ git subrepo clone git@github.com:linuxmuster-docs/howto_leoclient2.git source/howtos/howto_leoclient2
   ~/all-of-me$ git commit --amend
   ~/all-of-me$ git push


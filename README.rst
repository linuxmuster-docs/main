linuxmuster.net documentation - the full monty
##############################################

The full Monty - Die gesamte Dokumentation.
Bindet über git subtree die anderen benötigten Repositorien ein.

Installation
++++++++++++
Clone the repository using git

.. code::

   $ git clone git@github.com:linuxmuster-docs/the-full-monty.git

Update the remote branches using the shell script

.. code::

   $ cd the-full-monty
   $ ./update_repos.sh

Changing the documentation
++++++++++++++++++++++++++

Not done here. Change the documentation in the respective repository (e.g. change linuxmuster-docs/system_clients_linux using git clone; git commit, git push). Now come back here and update the repository manually:

.. code::

   $ git pull -s subtree system_clients_linux master

There should be no merging conflicts, if you have not altered the files here.

Updating
++++++++

Update the main repository using git

.. code::

   $ git pull

New upstream versions of the single chapters have to be merged, this can be done for each chapter manually, if many conflicts arise.

.. code::

   $ git pull -s subtree <name_of_subtree> master

Or pull all the updates from upstream using the shell script.

.. code::

   $ ./update_repos.sh

.. admonition:: Problem with updates

   Beim mergen kann die index.rst aus verschiedensten Verzeichnissen herangenommen werden. Da muss man noch ne Lösung finden. Außerdem ist mir nicht bekannt, wie ich feststelle ob ich die identische Version wie upstream habe...


Adding new subtrees
+++++++++++++++++++

If a new chapter is to be added,

1. adapt ``update_repos.sh`` accordingly.

2. follow the guide https://help.github.com/articles/about-git-subtree-merges/ to add the new git-project, the subdirectory will be the argument to the ``--prefix`` parameter

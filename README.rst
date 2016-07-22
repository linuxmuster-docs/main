linuxmuster.net documentation
#############################

::

  All of me, why take not all of me.
                   -- Seymour Simons

Die gesamte Dokumentation zu linuxmuster.net.

The full documentation of linuxmuster.net.

Installation
++++++++++++
Clone the repository "all-of-me" using git 

.. code:: bash

   ~$ git clone https://github.com/linuxmuster-docs/all-of-me.git  # if you have no ssh-key within github
   ~$ git clone git@github.com:linuxmuster-docs/all-of-me.git  # if you have a ssh-key within github
   ~$ git pull

Install sphinx, e.g. under Ubuntu 16.04, do

.. code:: bash

   ~$  sudo aptitude -R install git python3-sphinx texlive texlive-latex-extra texlive-lang-german

Make a local copy of your documentation using 

.. code:: bash

   ~$ cd all-of-me
   ~/all-of-me$ make clean
   ~/all-of-me$ make html

Later, if you work again on the repository, update it with

.. code:: bash

   ~/all-of-me$ git pull



Contribute to the documentation
+++++++++++++++++++++++++++++++

Fork the repository "all-of-me" within the github-webinterface_

.. _github-webinterface: https://github.com/linuxmuster-docs/all-of-me

* Clone your fork

  .. code:: bash

     ~$ git clone https://github.com/mein-github-konto/all-of-me.git all-of-me-fork
     ~$ cd all-of-me-fork
     ~/all-of-me-fork$ make html

* Make changes in your fork
* Commit your changes to your fork
* Push your changes to your fork on github
* Create a new pull-request on github
* If you are done and the pull-request was merged, you can delete your fork.

Further reading
+++++++++++++++

See the documentation on linuxmuster.net_.

.. _linuxmuster.net: http://www.linuxmuster.net/wiki/dokumentation:sphinx

linuxmuster.net documentation
#############################

::

  All of me, why take not all of me.
                   -- Seymour Simons

Die gesamte Dokumentation zu linuxmuster.net.

The full documentation of linuxmuster.net.

Installation
++++++++++++
Clone the repository "all-of-me" using git and later use ''git pull'' to update it

.. code:: bash

   ~$ git clone git@github.com:linuxmuster-docs/all-of-me.git
   ~$ git pull

Make a local copy of your documentation using 

.. code:: bash

   ~$ cd all-of-me
   ~/all-of-me$ make clean
   ~/all-of-me$ make html


Contribute to the documentation
+++++++++++++++++++++++++++++++

Fork the repository "all-of-me" within the github-webinterface.

* Clone your fork
  .. code:: bash

     ~$ git clone https://github.com/mein-github-konto/all-of-me.git all-of-me-fork
     ~$ cd all-of-me-fork
     ~/all-of-me-fork$ make html

* Make your changes in your fork
* Commit your changes to your fork
* Push your changes to your fork on github
* Create a new pull-request on github
* If you are done and the pull-request was merged, you can delete your fork.

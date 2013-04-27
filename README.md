Norman's Ark============Max Goldstein, Kelly Moran, Jason Jacob  Final Project for [COMP 150VIZ](http://www.cs.tufts.edu/comp/150VIZ/) at Tufts UniversityA visualization of test results for programming assignments, implemented inProcessing and available [online](http://www.eecs.tufts.edu/~mgolds07/nark/).This repo contains the following documentation:* This **README** describes how to get the visualization running on your machine.* The **TUTORIAL** file describes how the visualization is designed and how to use it.* The **SCENARIO** file provides a brief description of some patterns we found using the visualization.* The **EXTENDING** file describes what limited changes can be done to this codebase, and what lessons should be taken to another attempt to visualize this data.Run It Locally--------------The main file is `main.pde`. Processing requires that all `.pde` files beenclosed in a directory called `main`. You will need the [ProcessingIDE](http://processing.org/download/).Run It Online-------------A sample `index.html` and `style.css` are provided. The code itself is poweredby [processing.js](http://processingjs.org/download/). The layout requires[Twitter Bootstap](http://twitter.github.io/bootstrap/), which is probablyoverkill for this project but oh well. You will need local copies of bothscripts and to change `index.html` to point to them. You can modify the buttonsat the top to create a website of different test suite results. You will needto set permissions correctly; be aware that `git pull`ing sometimes resetsthese.We recommend users who have access to the non-anonymized data set up passwordsfor their website at the apache level.Data and Preprocessing----------------------Both local and online setups require the data files. Anonymized versions are currently available from the course webpage.The project's biggest strength and biggest weakness is the preprocessor. Thisscript, written in Python, incorporates all domain knowledge known about thedata (specifically the witnesses). Currently it works only for the `unit` and`additional` (uML) data sets, but is easy to extend. The Processing codeexpects the data file to be called `data.csv`, so use:`python preprocess.py path/to/data.outcomes.anon > data.csv`Note that on the Halligan machines you will need to specify `python2.7`.
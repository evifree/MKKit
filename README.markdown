## MKKit ##

The MKKit is an open source project that has several objects the help build apps easier and faster. The framework also includes
several specialty view controllers, views, controls, and table cells.

## Installing ##

Download or clone the MKKit source files. Open the project and build all the targets. Add the framework by dragging the project file
into your project or work space.  Do not copy the files to the project folder. Command click on the libMKKit.a file and select 'Show in Finder',
and than drag that file into your projects Frameworks folder.

Go into the build settings of your projects target. Find the Header Search Paths field and enter the full path to the MKKit folder. 

In you applications Prefix.pch file add ``#import <MKKit/MKKit.h>``

## Using Objects Resources ##

Some objects have other resources with them. Object resources come in separate bundles for the object. Just add the resource bundles to 
your project for the ones that you need to use. 

Documentation

To view the documentation open the 'Documentation' folder and double click on index.html or hierarchy.html. The documentation will open
in Safari.
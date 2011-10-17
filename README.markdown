## MKKit ##

The MKKit is an open source project that has several objects the help build apps easier and faster. The framework also includes
several specialty view controllers, views, controls, table cells, and specialty libraries.

## Installing ##

Download or clone the MKKit source files. Open the project and build all the targets. Add the framework by dragging the project file
into your project or work space.  Do not copy the files to the project folder. Command click on the libMKKit.a file and select 'Show in Finder',
and than drag that file into your projects Frameworks folder.

Go into the build settings of your projects target. Find the Header Search Paths field and enter the full path to the MKKit folder. You also
need to do this for each of the targets of the kit.

In you applications Prefix.pch file add ``#import <MKKit/MKKit.h>``

Visit the MKKit Blog <http://matt62king.blogspot.com/search/label/MKKit> for more detailed information on installing MKKit.

## Versioning ##

All new version of MKKit are taged. Starting with version 0.8 methods and properties will be marked with a depreciation attribute in 
the code. Depreciated methods and properties will remain for two version cycles and will be removed completely. 

## Documentation ##

To view the documentation open the 'Documentation' folder and double click on index.html or hierarchy.html. The documentation will open
in internet browser.

One of the goals of MKKit is to provide detailed documentation. All of the functional classes will have basic documentation at a minimum.
Continual work is done to make the documentation more detailed.

## Additional Libraries ##

MKKit has additional libraries that can be added to your projects. These are libraries that preform a specific function. To use on these
libraries add it to your project the same way you would add the MKKit.

## Detailed Information ##

Visit the wiki <https://github.com/matt62king/MKKit/wiki> for more detailed information about MKKit. The wiki includes additional documentation,
and version notes of MKKit.
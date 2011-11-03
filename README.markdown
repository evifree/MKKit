## MKKit ##

The MKKit is an open source project that has several objects the help build apps easier and faster. The framework also includes
several specialty view controllers, views, controls, table cells, and specialty libraries. 

The goal of MKKit is to provide a framework that makes creating apps a faster process. MKKit focuses on custom contols, custom views 
and commom controllers. 

## Installing ##

Download or clone the MKKit source files. Open the project and build all the targets. Add the framework by dragging the project file
into your project or work space.  Do not copy the files to the project folder. Command click on the libMKKit.a file and select 'Show in Finder',
and than drag that file into your projects Frameworks folder. Repeat this process for each one of the libraries you wish to use.

Go into the build settings of your projects target. Find the **Header Search Paths** field and enter the full path to the MKKit folder. You also
need to do this for each on the targets of the kit.

In the build settings of your projects target find the **Other Linker Flags** and the -ObjC.

You need to link your project to the required frameworks and libraries used in MKKit. See the Wiki for a list of required frameworks and libraies
<https://github.com/matt62king/MKKit/wiki/Required-Binary-Library-Links>.

* Use ``#import <MKKit/MKKit.h>`` to use MKKit classes.
* Use ``#import <MKKit/MKFeed.h>`` to use MKFeeds classes.
* Use ``#import <MKKit/MKGraphs.h>`` to use MKGraphs classes.

Visit the MKKit Blog <http://matt62king.blogspot.com/search/label/MKKit> for more detailed information on installing MKKit.

## Contributing ##

I am always looking for contributers to the MKKit project. If you would like to contribute contact me via email: matt62king@gmail.com.

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

Each addtional library can function with out the MKKit library, however they will use some classes if they are availible. In each of 
the libraies availiblity header files there is are macros that can be used to toggle the availiblity of other libraries. 

## Detailed Information ##

Visit the wiki <https://github.com/matt62king/MKKit/wiki> for more detailed information about MKKit. The wiki includes additional documentation,
and version notes of MKKit.
//
//  MKTableCellFeed.h
//  MKKit
//
//  Created by Matthew King on 12/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MKKit/MKKit/MKTableCells/MKTableCell.h>

@class MKTableCell;

typedef enum {
    MKTableCellFeedTypeDynamic,
	MKTableCellFeedTypePlainText,
	MKTableCellFeedTypeHTML,
} MKTableCellFeedType;

#define DYNAMIC_CELL_CONTENT_WIDTH_LANDSCAPE        480.0
#define DYNAMIC_CELL_CONTENT_WIDTH_PORTRAIT         320.0
#define DYNAMIC_CELL_CONTENT_MARGIN                 10.0

/**-----------------------------------------------------------------------------------------------------
 The MKTableCellFeed provieds a display designed to accept data from an RSS feed. This class can accept differnt
 kinds of feeds by setting `MKTableCellFeedType`. This can be set to one of two values.
 
 * `MKTableCellFeedTypeDynamic` : Use this type for cell that adjust hieght to the content.
 * `MKTableCellFeedTypePlainText` : Use this type if the feeds content is given in plain text.
 * `MKTableCellFeedTypeHTML` : Use this type if the feeds content is given in HTML.
 
 The following Macros are defined in this Class:
 
 * `DYNAMIC_CELL_CONTENT_WIDTH_LANDSCAPE        480.0`
 * `DYNAMIC_CELL_CONTENT_WIDTH_PORTRAIT         320.0`
 * `DYNAMIC_CELL_CONTENT_MARGIN                 10.0`
 
 @warning *Note* Default height for this cell is 130.0.
-------------------------------------------------------------------------------------------------------*/

@interface MKTableCellFeed : MKTableCell {
	MKTableCellFeedType mFeedType;
	
    NSString *mContentText;
	UITextView *mTheTextView;
	UIWebView *mTheWebView;
	
	NSString *mFeedUrl;
	NSString *mHTMLString;
}

///------------------------------------------------------
/// @name Cell Elements
///------------------------------------------------------

/** A String that give the content for MKTableCellFeedTypeDynamic */
@property (nonatomic, retain) NSString *contentText;

/** A text view that displays the elememts content. */
@property (nonatomic, retain) UITextView *theTextView;

/** A web view that displays the elements HTML content. */
@property (nonatomic, retain) UIWebView *theWebView;

///-----------------------------------------------------
/// @name Feed Types
///-----------------------------------------------------

/** The type of feed to display in the cell. This can be set to one of three values.
 
 * `MKTableCellFeedTypeDynamic` : Use this type for cell that adjust hieght to the content.
 * `MKTableCellFeedTypePlainText` : Use this type if the feeds content is given in plain text.
 * `MKTableCellFeedTypeHTML` : Use this type if the feeds content is given in HTML.
*/
@property (nonatomic, assign) MKTableCellFeedType feedType;

///-----------------------------------------------------
/// @name Feed Data
///-----------------------------------------------------

/** The URL that the feed element links to. */
@property (nonatomic, retain) NSString *feedUrl;

//** The HTML content of the feed. Use only when feed type is `MKTableCellFeedTypeHTML` */
@property (nonatomic, retain) NSString *HTMLString;	

@end

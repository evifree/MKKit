//
//  MKTableCellFeed.m
//  MKKit
//
//  Created by Matthew King on 12/23/10.
//  Copyright 2010 Matt King. All rights reserved.
//

#import "MKTableCellFeed.h"

@implementation MKTableCellFeed

@synthesize feedType=mFeedType;

@synthesize contentText=mContentText, theTextView=mTheTextView, theWebView=mTheWebView;

@synthesize feedUrl=mFeedUrl, HTMLString=mHTMLString;

#pragma mark -
#pragma mark Initalizer

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithType:MKTableCellTypeNone reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect labelRect = CGRectMake(10.0, 5.0, 300.0, 21.0);
		
		mTheLabel = [[UILabel alloc] initWithFrame:labelRect];
		mTheLabel.textAlignment = UITextAlignmentLeft;
		mTheLabel.adjustsFontSizeToFitWidth = NO;
		mTheLabel.minimumFontSize = 10.0;
        mTheLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
		
		[self.contentView addSubview:mTheLabel];
		[mTheLabel release];
    }
    return self;
}

#pragma mark -
#pragma mark Accessor Methods

- (void)setFeedType:(MKTableCellFeedType)aType {
    mFeedType = aType;
	CGRect feedRect = CGRectMake(2.0, 32.0, 299.0, 103.0);
    
    if (aType == MKTableCellFeedTypeDynamic) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.lineBreakMode = UILineBreakModeWordWrap;
        label.minimumFontSize = 14.0;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:14.0];
        label.tag = 1;
        
        [self.contentView addSubview:label];
        [label release];
    }
    
	if (aType == MKTableCellFeedTypePlainText) {
		mTheTextView = [[UITextView alloc] initWithFrame:feedRect];
		mTheTextView.editable = NO;
		mTheTextView.scrollEnabled = NO;
		mTheTextView.userInteractionEnabled = NO;
		[mTheTextView resignFirstResponder];
		
		[self.contentView addSubview:mTheTextView];
		[mTheTextView release];
	}
	if (aType == MKTableCellFeedTypeHTML) {
		mTheWebView = [[UIWebView alloc] initWithFrame:feedRect];
		
		[self.contentView addSubview:mTheWebView];
		[mTheWebView release];		
	}
}

- (void)setMFeedUrl:(NSString *)url {
	mFeedUrl = [url retain];
	[mFeedUrl release];
}

- (void)setHTMLString:(NSString *)HTML {
	mHTMLString = [HTML retain];
	[mHTMLString release];
}

- (void)setContentText:(NSString *)contentText {
    CGFloat width = 320.0;
    
    if (DEVICE_ORIENTATION_IS_LANDSCAPED) {
        width = DYNAMIC_CELL_CONTENT_WIDTH_LANDSCAPE;
    }
    if (DEVICE_ORIENTATION_IS_PORTRAIT) {
        width = DYNAMIC_CELL_CONTENT_WIDTH_PORTRAIT;
    }
    
    CGSize constraint = CGSizeMake(width - (DYNAMIC_CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [contentText sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    if (mFeedType == MKTableCellFeedTypeDynamic) {
        UILabel *label = (UILabel*)[self viewWithTag:1];
    
        [label setText:contentText];
        [label setFrame:CGRectMake(DYNAMIC_CELL_CONTENT_MARGIN, (DYNAMIC_CELL_CONTENT_MARGIN + 17.0), width - (DYNAMIC_CELL_CONTENT_MARGIN * 2), MAX(size.height, 44.0f))];
    }
}

#pragma mark -
#pragma mark Cell Behavior

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
    [super dealloc];
}


@end

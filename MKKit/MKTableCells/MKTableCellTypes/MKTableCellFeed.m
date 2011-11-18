//
//  MKTableCellFeed.m
//  MKKit
//
//  Created by Matthew King on 12/23/10.
//  Copyright 2010-2011 Matt King. All rights reserved.
//

#import "MKTableCellFeed.h"

@implementation MKTableCellFeed

@synthesize feedType=mFeedType;

@synthesize contentText=mContentText, theTextView=mTheTextView, theWebView=mTheWebView, contentLabel, detailLabel;

@synthesize feedUrl=mFeedUrl, HTMLString=mHTMLString, detailText;

#pragma mark -
#pragma mark Initalizer

- (id)initWithType:(MKTableCellType)cellType reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithType:MKTableCellTypeNone reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect labelRect = CGRectMake(10.0, 5.0, 300.0, 21.0);
		
		mTheLabel = [[UILabel alloc] initWithFrame:labelRect];
        mTheLabel.backgroundColor = CLEAR;
		mTheLabel.textAlignment = UITextAlignmentLeft;
		mTheLabel.adjustsFontSizeToFitWidth = NO;
        mTheLabel.font = SYSTEM_BOLD(14.0);
		mTheLabel.minimumFontSize = 12.0;
        mTheLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
		
		[self.contentView addSubview:mTheLabel];
		[mTheLabel release];
    }
    return self;
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
    self.contentText = nil;
    self.theWebView = nil;
    self.theTextView = nil;
    self.feedUrl = nil;
    self.HTMLString = nil;
    self.contentLabel = nil;
    self.detailLabel = nil;
    self.contentLabel = nil;
    
    [super dealloc];
}

#pragma mark - Accessor Methods
#pragma mark Getters

- (UILabel *)detailLabel {
    return (UILabel *)[self.contentLabel viewWithTag:kDescriptionViewTag];
}

- (UILabel *)contentLabel {
    return (UILabel *)[self.contentLabel viewWithTag:kFeedContentViewTag];
}

#pragma mark Setters

- (void)setDetailText:(NSString *)text {
    UIView *contentView = (UIView *)[self.contentView viewWithTag:kFeedContentViewTag];
    UIView *detailView = (UIView *)[self.contentView viewWithTag:kDescriptionViewTag];
    CGFloat y = 0.0;
    
    if (detailView) {
        [detailView removeFromSuperview];
    }
    
    if (contentView) {
        y = (CGRectGetMaxY(contentView.frame) + 5.0);
    }
    else {
        y = 32.0;
    }
    
    CGRect labelRect = CGRectMake(10.0, y, 300.0, 21.0);
    
    UILabel *label = [[UILabel alloc] initWithFrame:labelRect];
    label.backgroundColor = CLEAR;
    label.minimumFontSize = 12.0;
    label.font = SYSTEM(12.0);
    label.textColor = LIGHT_GRAY;
    label.textAlignment = UITextAlignmentLeft;
    label.tag = kDescriptionViewTag;
    label.text = text;
    
    [self.contentView addSubview:label];
    [label release];
}

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
        label.tag = kFeedContentViewTag;
        
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
    CGFloat width = 300.0;
    
    if (DEVICE_ORIENTATION_IS_LANDSCAPED) {
        width = DYNAMIC_CELL_CONTENT_WIDTH_LANDSCAPE;
    }
    if (DEVICE_ORIENTATION_IS_PORTRAIT) {
        width = DYNAMIC_CELL_CONTENT_WIDTH_PORTRAIT;
    }
    
    CGSize constraint = CGSizeMake(width - (DYNAMIC_CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [contentText sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    UILabel *label = (UILabel*)[self viewWithTag:kFeedContentViewTag];
    
    [label setText:contentText];
    [label setFrame:CGRectMake(DYNAMIC_CELL_CONTENT_MARGIN, (DYNAMIC_CELL_CONTENT_MARGIN + 17.0), width - (DYNAMIC_CELL_CONTENT_MARGIN * 2), MAX(size.height, 0.0f))];

    UIView *adetailLabel = (UIView *)[self.contentView viewWithTag:kDescriptionViewTag];
    
    if (adetailLabel) {
        CGFloat y = (CGRectGetMaxY(label.frame) + 3.0);
        adetailLabel.frame = CGRectMake(detailLabel.frame.origin.x, y, detailLabel.frame.size.width, detailLabel.frame.size.height);
    }
}

#pragma mark -
#pragma mark Cell Behavior

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

@end

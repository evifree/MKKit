//
//  MKTableCellTextView.h
//  MKKit
//
//  Created by Matthew King on 11/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MKKit/MKKit/MKTableCells/MKTableCell.h>

@class MKTableCell;

// Cell Height is 73.0

@interface MKTableCellTextView : MKTableCell <UITextViewDelegate> {
	UITextView *_theTextView;
}

@property (nonatomic, retain) UITextView *theTextView;

- (void)clearTextView:(id)sender;
- (void)resignTextView:(id)sender;

@end

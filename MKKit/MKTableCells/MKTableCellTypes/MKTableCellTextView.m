//
//  MKTableCellTextView.m
//  MKKit
//
//  Created by Matthew King on 11/6/10.
//  Copyright 2010 Matt King. All rights reserved.
//

#import "MKTableCellTextView.h"

@implementation MKTableCellTextView

@synthesize theTextView=_theTextView;

#pragma mark -
#pragma mark Initalize

- (id)initWithType:(MKTableCellType)cellType reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithType:MKTableCellTypeNone reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect textViewFrame = CGRectMake(5.0, 6.0, 285.0, 73.0);
		
		_theTextView = [[UITextView alloc] initWithFrame:textViewFrame];
		_theTextView.editable = YES;
		_theTextView.delegate = self;
        _theTextView.backgroundColor = CLEAR;
		_theTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
		
		[self.contentView addSubview:_theTextView];
		[_theTextView release];
    }
    return self;
}

#pragma mark -
#pragma mark Cell Behavior

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -
#pragma mark TextView Methods

- (void)clearTextView:(id)sender {
	self.theTextView.text = @"";
}

- (void)resignTextView:(id)sender {
	if ([delegate respondsToSelector:@selector(valueDidChange:forKey:)]) {
		[delegate valueDidChange:self.theTextView.text forKey:self.key];
	}
	
	[self.theTextView resignFirstResponder];
}

#pragma mark -
#pragma mark Delegates

#pragma mark TextView 

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
	UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 50.0)];
	toolBar.barStyle = UIBarStyleBlackOpaque;
	
	UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleBordered target:self action:@selector(clearTextView:)];
	UIBarButtonItem *doneTabButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(resignTextView:)];
	
	NSArray *items = [[NSArray alloc] initWithObjects:space, clearButton, doneTabButton, nil];
	
	[toolBar setItems:items animated:NO];
	
	[space release];
	[clearButton release];
	[doneTabButton release];
	
	[items release];
	
	textView.inputAccessoryView = toolBar;
	
	[toolBar release];
	return YES;
}

#pragma mark -
#pragma mark Memory Managment

- (void)dealloc {
    [super dealloc];
}


@end

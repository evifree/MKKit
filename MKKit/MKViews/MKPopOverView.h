//
//  MKPopOverView.h
//  MKKit
//
//  Created by Matthew King on 10/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MKView.h"

@class MKView;

@interface MKPopOverView : MKView <UITableViewDelegate, UITableViewDataSource> {	
	UITableView *_theTableView;
	NSArray *_tableArray;
	UILabel *_title;
}

@property (nonatomic, assign) NSInteger selected;					//Row index of the Selected Cell

@property (nonatomic, retain) UITableView *theTableView;			//Instance of a UITableView
@property (nonatomic, retain) NSArray *tableArray;					//An array of NSString objects to fill the table
@property (nonatomic, retain) UILabel *title;						//String to display in the title Lable

//** Removes the view with no action taken
- (void)cancelView:(id)sender;

@end

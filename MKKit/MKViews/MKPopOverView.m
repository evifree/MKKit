//
//  MKPopOverView.m
//  MKKit
//
//  Created by Matthew King on 10/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MKPopOverView.h"


@implementation MKPopOverView

@synthesize selected;

@synthesize theTableView=_theTableView, tableArray=_tableArray, title=_title;

#pragma mark -
#pragma mark Initalization

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor clearColor];
		self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		self.autoresizesSubviews = YES;
		
		UIImageView *bgView = [[UIImageView alloc] initWithFrame:frame];
		bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		
		NSString *path = [[NSBundle mainBundle] pathForResource:@"popViewBackGround" ofType:@"png"];
		UIImage *bgImage = [[UIImage alloc] initWithContentsOfFile:path];
		
		bgView.image = bgImage;
		
		[bgImage release];
		[self addSubview:bgView];
		[bgView release];
		
		_title = [[UILabel alloc] initWithFrame:CGRectMake(28.0, 27.0, 228.0, 30.0)];
		_title.textAlignment = UITextAlignmentCenter;
		_title.font = [UIFont fontWithName:@"Verdana-Bold" size:22.0];
		_title.textColor = [UIColor whiteColor];
		_title.backgroundColor = [UIColor clearColor];
		_title.adjustsFontSizeToFitWidth = YES;
		_title.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
		
		[self addSubview:_title];
		[_title release];
		
		_theTableView = [[UITableView alloc] initWithFrame:CGRectMake(27.0, 59.0, 228.0, 271.0) style:UITableViewStylePlain];
		_theTableView.delegate = self;
		_theTableView.dataSource = self;
		_theTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		
		[self addSubview:_theTableView];
		[_theTableView release];
		
		UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
		cancelButton.frame = CGRectMake(28.0, 345.0, 228.0, 37.0);
		cancelButton.titleLabel.textColor = [UIColor whiteColor];
		cancelButton.titleLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:18.0];
		cancelButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
		
		NSString *buttonPath = [[NSBundle mainBundle] pathForResource:@"cancelButtonUp" ofType:@"png"];
		UIImage *buttonUp = [[UIImage alloc] initWithContentsOfFile:buttonPath];
		
		[cancelButton setBackgroundImage:buttonUp forState:UIControlStateNormal];
		[cancelButton setBackgroundImage:buttonUp forState:UIControlStateSelected];
		[cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
		
		[cancelButton addTarget:self action:@selector(cancelView:) forControlEvents:UIControlEventTouchUpInside];
		
		[self addSubview:cancelButton];
		
		[buttonUp release];
	}
	return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setTableArray:(NSArray *)array {
	_tableArray = [[NSArray arrayWithArray:array] retain];
	
	[self.tableArray retain];
	[self.theTableView reloadData];
	
	[_tableArray release];
}

#pragma mark - 
#pragma mark Actions

- (void)cancelView:(id)sender {
	[UIView animateWithDuration:0.25
					 animations: ^ { self.alpha = 0.0; }
					 completion: ^ (BOOL finished) { [self removeFromSuperview]; }];
}

#pragma mark -
#pragma mark DataSources

#pragma mark TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.tableArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
    
	cell.textLabel.text = [self.tableArray objectAtIndex:indexPath.row];
	cell.textLabel.adjustsFontSizeToFitWidth = YES;
	
	if (indexPath.row == selected) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
	else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}

	
    return cell;
}

#pragma mark -
#pragma mark Delegates

#pragma mark Table View

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([self.delegate respondsToSelector:@selector(popOverView:selectedCellAtIndex:)]) {
		[self.delegate popOverView:self selectedCellAtIndex:indexPath.row];
	}
	if ([self.delegate respondsToSelector:@selector(shouldRemoveView:)]) {
		if ([self.delegate shouldRemoveView:self]) {
			[self cancelView:nil];
		}
	}
}


#pragma mark -
#pragma mark Memory Managment

- (void)dealloc {
    [_tableArray release];
    
	[super dealloc];
}

@end

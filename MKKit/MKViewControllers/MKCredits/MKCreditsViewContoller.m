//
//  MKCreditsViewContoller.m
//  MKKit
//
//  Created by Matthew King on 11/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MKCreditsViewContoller.h"

@interface MKCreditsViewContoller ()

- (void)buildEmail:(id)sender;

@end

#pragma mark -
#pragma mark MKCreditsViewContoller

@implementation MKCreditsViewContoller

@synthesize footerView=_footerView, activeTitle=_activeTitle, creditsArray=_creditsArray;

@synthesize popViewTitle;

#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style {
	if ((self = [super initWithStyle:style])) {
		NSString *path = [[NSBundle mainBundle] pathForResource:@"CreditNames" ofType:@"plist"];
		_creditsArray = [[[NSArray alloc] initWithContentsOfFile:path] copy];

		[_creditsArray release];
	}
	return self;
}

#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	selectedTopic = 0; 
	
	NSDictionary *firstCredit = (NSDictionary *)[self.creditsArray objectAtIndex:0];
	
	_footerView = [[MKCreditsFooterView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 280.0)];
	_footerView.titleLabel.text = [firstCredit objectForKey:@"Title"];
	_footerView.descriptionText.text =  [firstCredit objectForKey:@"Credit"];
	_footerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
	[_footerView removeButton];
	
	self.tableView.tableFooterView = _footerView;
	[_footerView release];
	
	self.tableView.scrollEnabled = NO;
	
	self.title = @"About";
	
	_activeTitle = [[firstCredit objectForKey:@"Title"] retain];
	[_activeTitle release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

#pragma mark Instance Methods

- (UIButton *)buttonTitled:(NSString *)buttonTitle {
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button setTitle:buttonTitle forState:UIControlStateNormal];
	[button addTarget:self action:@selector(buildEmail:) forControlEvents:UIControlEventTouchUpInside];
	
	return button;
}

#pragma mark Actions

- (void)buildEmail:(id)sender {
	if ([MFMailComposeViewController canSendMail]) {
		MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
		[mailController setSubject:[sender titleForState:UIControlStateNormal]];
		[mailController setToRecipients:[NSArray arrayWithObjects:@"matt62king@gmail.com", nil]];
		mailController.mailComposeDelegate = self;
		mailController.view.frame = CGRectMake(0.0, 0.0, 320.0, 430.0);
		mailController.view.alpha = 0.0;
		
		[self.navigationController setNavigationBarHidden:YES animated:YES];
		[self.view addSubview:mailController.view];
		
		[UIView animateWithDuration:0.25
						 animations: ^ { mailController.view.alpha = 1.0; }];
	}
	
}

#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	}
    
    cell.textLabel.text = self.activeTitle;
    
    return cell;
}

#pragma mark Delegates

#pragma mark Table View

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	NSMutableArray *tableArray = [[NSMutableArray alloc] initWithCapacity:1];
	NSInteger count = [self.creditsArray count];
	
	for (int i = 0; i < count; i++) {
		NSDictionary *credit = (NSDictionary *)[self.creditsArray objectAtIndex:i];
		[tableArray addObject:[credit objectForKey:@"Title"]];
	}
	
	MKPopOverView *popView = [[MKPopOverView alloc] initWithFrame:CGRectMake(0.0, 0.0, 285.0, 410.0)];
	popView.controller = self;
	popView.clipsToBounds = YES;
	popView.tableArray = tableArray;
	popView.delegate = self;
	popView.title.text = self.popViewTitle;
	popView.selected = selectedTopic;
	[popView showWithAnimationType:MKViewAnimationTypeFadeIn];
	
	[popView release];
	[tableArray release];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark PopOverView

- (void)popOverView:(MKView *)view selectedCellAtIndex:(NSInteger)index {
	NSDictionary *credit = (NSDictionary *)[self.creditsArray objectAtIndex:index];
	
	self.activeTitle = [credit objectForKey:@"Title"]; 
	self.footerView.titleLabel.text = [credit objectForKey:@"Title"];
	self.footerView.descriptionText.text =  [credit objectForKey:@"Credit"];
	[self.footerView removeButton];
	selectedTopic = index;
		 
	[self.tableView reloadData];
	
	[UIView animateWithDuration:0.25 
					 animations: ^ { view.alpha = 0.0; }
					 completion: ^ (BOOL finished) { [view removeFromSuperview]; }];
}

#pragma mark Mail Contoller

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	if (error) {
		MKErrorHandeling *anError = [[MKErrorHandeling alloc] init];
		[anError applicationDidError:error];
		[anError release];
	}
	
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	
	[UIView animateWithDuration:0.25
					 animations: ^ { controller.view.alpha = 0.0; }
					 completion: ^ (BOOL finished) { [controller.view removeFromSuperview]; [controller release]; }];
}

#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [_creditsArray release];
    
    [super dealloc];
}


@end

//----------------------------------------------------------------------------------------------------------------
//MKCreditsFooterView

#pragma mark -
#pragma mark MKCreditsFooterView

@implementation MKCreditsFooterView

@synthesize titleLabel=_titleLabel, descriptionText=_descriptionText, actionButton=_actionButton;

BOOL buttonVis = NO;

#pragma mark Initalizer

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 25.0, 320.0, 346.0)];
		backView.backgroundColor = [UIColor whiteColor];
		backView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
		
        NSString *path = [[NSBundle mainBundle] pathForResource:@"pointer" ofType:@"png"];
		
		UIImage *pointer = [[UIImage alloc] initWithContentsOfFile:path];
		UIImageView *pointerView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 25.0)];
		pointerView.image = pointer;
		pointerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
		[pointer release];
		
		[self addSubview:pointerView];
		[self addSubview:backView];
		
		NSString *iconPath = [[NSBundle mainBundle] pathForResource:@"icon" ofType:@"png"];
		
		UIImage *iconImage = [[UIImage alloc] initWithContentsOfFile:iconPath];
		UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20.0, 20.0, 57.0, 57.0)];
		iconImageView.image = iconImage;
		[iconImage release];
		
		[backView addSubview:iconImageView];
		[iconImageView release];
		
		_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(95.0, 28.0, 205.0, 41.0)];
		_titleLabel.font = [UIFont systemFontOfSize:32.0];
		_titleLabel.adjustsFontSizeToFitWidth = YES;
		
		[backView addSubview:_titleLabel];
		[_titleLabel release];
		
		_descriptionText = [[UITextView alloc] initWithFrame:CGRectMake(15.0, 85.0, 285.0, 227.0)];
		_descriptionText.font = [UIFont systemFontOfSize:16.0];
		_descriptionText.scrollEnabled = YES;
		_descriptionText.editable = NO;
		_descriptionText.dataDetectorTypes = UIDataDetectorTypeLink;
		_descriptionText.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
		
		[backView addSubview:_descriptionText];
		[_descriptionText release];
		
		[pointerView release];
		[backView release];
		
		buttonVis = NO;
    }
    return self;
}

#pragma mark Accessor Methods

- (void)setActionButton:(UIButton *)button {
	if (!buttonVis) {
		_actionButton = [button retain];
		
		_actionButton.frame = CGRectMake(20.0, 257.0, 280.0, 37.0);
		[self addSubview:_actionButton];
		
		[_actionButton release];
	}
	if (buttonVis) {
		[self.actionButton setTitle:[button titleForState:UIControlStateNormal] forState:UIControlStateNormal];
	}
	
	buttonVis = YES;
}

- (void)removeButton {
	if (buttonVis) {
		[self.actionButton removeFromSuperview];
		buttonVis = NO;
	}
}

#pragma mark Memory Managment

- (void)dealloc {
    [super dealloc];
}


@end



//
//  MKViewController.m
//  MKKit
//
//  Created by Matthew King on 3/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MKViewController.h"


@implementation MKViewController

@synthesize delegate=mDelegate;

#pragma mark - Initalizers

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (id)initWithDelegate:(id)delegate {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        mDelegate = delegate;
    }
    return self;
}

#pragma mark - View lifecycle

- (void)loadView {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}

#pragma mark - Actions

- (void)done:(id)sender {
    if ([mDelegate respondsToSelector:@selector(viewControllerIsDone:)]) {
        [mDelegate viewControllerIsDone:sender];
    }
}

- (void)action:(id)sender {
    if ([mDelegate respondsToSelector:@selector(viewControllerAction:)]) {
        [mDelegate viewControllerAction:sender];
    }
}

#pragma mark - Mememory Managment

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [super dealloc];
}


@end

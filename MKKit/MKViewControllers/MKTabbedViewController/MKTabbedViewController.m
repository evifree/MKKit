//
//  MKTabbedViewController.m
//  MKKit
//
//  Created by Matthew King on 8/4/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKTabbedViewController.h"

@implementation MKTabbedViewController

@synthesize tabbedView=mTabbedView;

#pragma mark - Initalizer

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

#pragma mark - View lifecycle

- (void)loadView {
    mTabbedView = [[MKTabbedView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 460.0)];
    mTabbedView.dataSource = self;
    mTabbedView.tabbedDelegate = self;
    
    self.view = mTabbedView;
    [mTabbedView release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [mTabbedView setTabs];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark - Data Source

- (NSArray *)tabsForView:(MKTabbedView *)tabbedView {
    return nil;
}

- (UIView *)viewForTabAtIndex:(NSInteger)index {
    //For use by subclass
    return nil;
}

#pragma mark - Delegate

- (void)tabbedView:(MKTabbedView *)tabbedView didSelectTabAtIndex:(NSInteger)index {
    //For use by subclass
}

#pragma mark - Memory Managment

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [super dealloc];
}

@end

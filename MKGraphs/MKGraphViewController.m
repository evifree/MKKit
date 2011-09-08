//
//  MKGraphViewController.m
//  MKKit
//
//  Created by Matthew King on 9/4/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKGraphViewController.h"

@implementation MKGraphViewController

@synthesize graphView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - DataSource

- (NSInteger)numberOfDataSetsForGraphView:(MKGraphView *)graphView {
    return 0;
}

- (MKGraphScale)scaleForGraphView:(MKGraphView *)graphView {
    MKGraphScale scale = MKGraphScaleMake(0.0, 0.0);
    return scale;
}

- (MKGraphDataSet *)graphView:(MKGraphView *)graphview dataSetForIndex:(NSInteger)index {
    return nil;
}


@end

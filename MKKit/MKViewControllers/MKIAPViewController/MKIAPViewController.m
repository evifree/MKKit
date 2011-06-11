//
//  MKIAPViewController.m
//  MKKit
//
//  Created by Matthew King on 5/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MKIAPViewController.h"


@interface MKIAPViewController ()

- (void)onProductsResponse:(NSArray *)items;

@end

@implementation MKIAPViewController

@synthesize items=mItems, observer=mObserver;

- (id)initWithIdentifiers:(NSSet *)identifiers observer:(id<MKIAPObserver>)observer {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        mIdentifiers = [identifiers copy];
        mObserver = observer;
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Store";
    
    [MKIAPController productsRequestWithIdentifiers:mIdentifiers 
                                           response: ^ (SKProductsResponse *response, NSError *error) { 
                                                        if (error == nil) {
                                                            [self onProductsResponse:response.products];
                                                        }
                                                    }];
    
    [mIdentifiers release];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Actions

- (void)onProductsResponse:(NSArray *)items {
    mItems = [items retain];
    mProductsSet = YES;
    [self.tableView reloadData];
    
    if ([mObserver respondsToSelector:@selector(didCompleteEvent:forIdentifiers:)]) {
        NSMutableSet *identifiers = [[NSMutableSet alloc] initWithCapacity:[items count]];
        for (SKProduct *product in items) {
            [identifiers addObject:product.productIdentifier];
        }
        [mObserver didCompleteEvent:MKIAPEventRequestComplete forIdentifiers:identifiers];
        [identifiers release];
    }
}

- (void)didRecieveResponse:(SKProductsResponse *)response {
    //mItems = [response.products retain];
    //mProductsSet = YES;
    //[self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 1;
    
    if (mProductsSet) {
        rows = [mItems count];
    }
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKTableCell *cell = nil;
    
    static NSString *LoadingCell = @"LoadingCell";
    static NSString *PurchaseCell = @"PurchaseCell";
    
    if (!mProductsSet) {
        cell = (MKTableCell *)[tableView dequeueReusableCellWithIdentifier:LoadingCell];
        if (cell == nil) {
            cell = [[[MKTableCellLoading alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LoadingCell] autorelease];
        }
    }
    
    if (mProductsSet) {
        SKProduct *product = (SKProduct *)[mItems objectAtIndex:indexPath.row];
        MKStrings *string = [[MKStrings alloc] init];
        
        cell = (MKTableCell *)[tableView dequeueReusableCellWithIdentifier:PurchaseCell];
        if (cell == nil) {
            cell = [[[MKTableCellIAP alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PurchaseCell] autorelease];
            ((MKTableCellIAP *)cell).observer = mObserver;
        }
        cell.theLabel.text = product.localizedTitle;
        cell.key = product.productIdentifier;
        ((MKTableCellIAP *)cell).IAPIdentifier = product.productIdentifier;
        ((MKTableCellIAP *)cell).price = [string localCurencyFromNumber:product.price];
    }
    
    return cell;
}

#pragma mark - Delegates
#pragma mark UITableView

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [mItems release];
    [super dealloc];
}

@end
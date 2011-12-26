//
//  MKPullTableViewController.m
//  MKKit
//
//  Created by Matthew King on 12/23/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKPullTableViewController.h"


@implementation MKPullTableViewController

@dynamic pullDownView, working;

#pragma mark - Creation

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    self.pullDownView = nil;
    
    [super dealloc];
}

#pragma mark - Accessor Methods
#pragma mark Setters

- (void)setPullDownView:(UIView *)_pullDownView {
    mPullDownView = [_pullDownView retain];
    mContentHeight = mPullDownView.frame.size.height;
    
    mPullDownView.frame = CGRectMake(0.0, (0.0 - mContentHeight), mPullDownView.frame.size.width, mPullDownView.frame.size.height);
    [self.tableView addSubview:mPullDownView];
    
    [mPullDownView release];
}

#pragma mark Getters

- (UIView *)pullDownView {
    return mPullDownView;
}

- (BOOL)working {
    return MKPullTableViewControllerFlags.isWorking;
}

#pragma mark - Actions

- (void)didPullDownPullDownView {
    //For use by subclasses
}

- (void)didPushUpPullDownView {
    //For use by subclasses
}

- (void)didReleasePullDownView {
    MKPullTableViewControllerFlags.isWorking = YES;
    
    [UIView animateWithDuration:0.3 animations: ^ {
        self.tableView.contentInset = UIEdgeInsetsMake(mContentHeight, 0.0, 0.0, 0.0); 
    }];
}

- (void)pullDownOperationsCompleted {
   
}

#pragma mark - Notifications

- (void)shouldReturnPullDownView {
    MKPullTableViewControllerFlags.isWorking = NO;
    
    [UIView animateWithDuration:0.3
                     animations: ^ { self.tableView.contentInset = UIEdgeInsetsZero; }
                     completion: ^ (BOOL finished) {
                         [self pullDownOperationsCompleted];
                         self.tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
                     }];
}

#pragma mark - Delegates
#pragma ScrollView

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (MKPullTableViewControllerFlags.isWorking) {
        return;
    }
    MKPullTableViewControllerFlags.isDraging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (MKPullTableViewControllerFlags.isWorking) {
        if (scrollView.contentOffset.y > 0) {
            self.tableView.contentInset = UIEdgeInsetsZero;
        }
        else if (scrollView.contentOffset.y >= -mContentHeight) {
            self.tableView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        }
    } 
    else if (MKPullTableViewControllerFlags.isDraging && scrollView.contentOffset.y < 0) {
        if (scrollView.contentOffset.y < -mContentHeight) {
            [self didPullDownPullDownView];
        } 
        else { 
            [self didPushUpPullDownView];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (MKPullTableViewControllerFlags.isWorking) {
        return;
    }
    
    MKPullTableViewControllerFlags.isDraging = NO;
    
    if (scrollView.contentOffset.y <= -mContentHeight) {
        [self didReleasePullDownView];
    }
}

@end
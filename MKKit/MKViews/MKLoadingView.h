//
//  MKViewLoading.h
//  MKKit
//
//  Created by Matthew King on 7/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MKView.h"

@interface MKLoadingView : MKView {
	UILabel *_statusLabel;
}

@property (nonatomic, retain) UILabel *statusLabel;

//** Called to display the loading View
- (void)removeLoadingView;

- (void)completedAnimation;

@end


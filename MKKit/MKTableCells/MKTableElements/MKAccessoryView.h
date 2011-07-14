//
//  MKAccessoryView.h
//  MKKit
//
//  Created by Matthew King on 7/9/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import <MKKit/MKKit/MKTableCells/MKTableCell.h>

@class MKTableCell;

@interface MKAccessoryView : MKControl {
    int mType;
}

- (id)initWithType:(int)type;

- (id)initWithImage:(UIImage *)image;

@end

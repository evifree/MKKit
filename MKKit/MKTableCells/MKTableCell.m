//
//  MKTableCell.m
//  MKKit
//
//  Created by Matthew King on 3/19/10.
//  Copyright 2010 Matt King. All rights reserved.
//

#import "MKTableCell.h"

#import "MKTableElements/MKTableCellBadgeView.h"

@interface MKTableCell ()

- (void)accessoryButton:(id)sender;
- (void)onSwipe:(UISwipeGestureRecognizer *)sender;
- (void)onLongPress:(UILongPressGestureRecognizer *)sender;

@end

@implementation MKTableCell

@synthesize delegate, type, theLabel=mTheLabel, smallLabel=mSmallLabel, key, accessoryViewType, 
            validationType=mValidationType, validating=mValidating, validator, icon,
            iconMask, validatorTestStringLength=mValidatorTestStringLength, accessoryIcon, 
            recognizeLeftToRightSwipe, recognizeRightToLeftSwipe, recognizeLongPress, indexPath,
            primaryViewTrim;

#pragma mark - Initalizer

- (id)initWithType:(MKTableCellType)cellType reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.type = cellType;
        [self.textLabel removeFromSuperview];
        
        if (type != MKTableCellTypeNone) {
            mCellView = [[MKView alloc] initWithCell:self];
            mCellView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
            [self.contentView addSubview:mCellView];
            [mCellView release];
        }
        
        if (type == MKTableCellTypeLabel) {
            mTheLabel = [[UILabel alloc] initWithFrame:CGRectZero];
			mTheLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:16.0];
			mTheLabel.textAlignment = UITextAlignmentLeft;
			mTheLabel.adjustsFontSizeToFitWidth = NO;
            mTheLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
            
            [mCellView addPrimaryElement:mTheLabel];
            [mTheLabel release];
		}
		
		if (type == MKTableCellTypeDescription) {
            mTheLabel = [[UILabel alloc] initWithFrame:CGRectZero];
			mTheLabel.textAlignment = UITextAlignmentLeft;
            mTheLabel.backgroundColor = RED;
			
            [mCellView addPrimaryElement:mTheLabel];
            [mTheLabel release];
            
			mSmallLabel = [[UILabel alloc] initWithFrame:CGRectZero];
			mSmallLabel.textAlignment = UITextAlignmentRight;
			mSmallLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
			mSmallLabel.adjustsFontSizeToFitWidth = YES;
			mSmallLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
            mSmallLabel.backgroundColor = GRAY;
			
			[mCellView addSecondaryElement:mSmallLabel];
			[mSmallLabel release];
		}
                    
		if (type == MKTableCellTypeScore) {
            mTheLabel = [[UILabel alloc] initWithFrame:CGRectZero];
			mTheLabel.textAlignment = UITextAlignmentLeft;
            
            [mCellView addPrimaryElement:mTheLabel];
            [mTheLabel release];
			
			mSmallLabel = [[UILabel alloc] initWithFrame:CGRectZero];
			mSmallLabel.textAlignment = UITextAlignmentRight;
			mSmallLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
			mSmallLabel.adjustsFontSizeToFitWidth = YES;
			mSmallLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
			
			[mCellView addSecondaryElement:mSmallLabel];
            [mSmallLabel release];
			
			self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
		
		if (type == MKTableCellTypeAction) {
            mTheLabel = [[UILabel alloc] initWithFrame:CGRectZero];
			mTheLabel.textAlignment = UITextAlignmentLeft;
			mTheLabel.adjustsFontSizeToFitWidth = YES;
			mTheLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
			mTheLabel.backgroundColor = [UIColor clearColor];
			
            [mCellView addPrimaryElement:mTheLabel];
            [mTheLabel release];
		}
        
		[self.contentView setAutoresizesSubviews:YES];
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
	return self;
}
	
#pragma mark - Accessor Methods

- (void)setAccessoryViewType:(MKTableCellAccessoryViewType)aType {
	if (aType == MKTableCellAccessoryNone) {
		self.accessoryView = nil;
	}
	if (aType == MKTableCellAccessoryInfoButton) {
		UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoDark];
		[button addTarget:self action:@selector(accessoryButton:) forControlEvents:UIControlEventTouchUpInside];
		self.accessoryView = button;
	}
	if (aType == MKTableCellAccessoryWarningIcon) {
        MKControl *iconImage = [[MKControl alloc] initWithType:MKTableCellAccessoryWarningIcon];
        self.accessoryView = iconImage;
		[iconImage release];
	}
    if (aType == MKTableCellAccessoryActivity) {
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [activityIndicator startAnimating];
        
        self.accessoryView = activityIndicator;
        [activityIndicator release];
    }
}

- (void)setAccessoryIcon:(UIImage *)lIcon {
    MKControl *iconView = [[MKControl alloc] initWithImage:lIcon];
    [iconView completedAction: ^ (MKAction action) {
        if (action == MKActionTouchDown) {
            [self accessoryButton:iconView];
        }
    }];
    self.accessoryView = iconView;
    [iconView release];
}

- (void)setValidationType:(MKValidationType)valType {
	mValidationType = valType;
	
	if (valType == MKValidationNone) {
		mValidating = NO;
		validator = nil;
	}
	else {
		mValidating = YES;
		validator = [[MKValidator alloc] init];
	}
}

- (void)setValidatorTestStringLength:(NSInteger)length {
    mValidatorTestStringLength = length;
    
    if (mValidating) {
        ((MKValidator *)validator).stringLength = length;
    }
}

- (void)setIcon:(UIImage *)anImage {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.image = anImage;
    
    [mCellView addIconElement:imageView];
    [imageView release];
}

- (void)setIconMask:(UIImage *)lIconMask {
    MKMaskIconView *iconView = [[MKMaskIconView alloc] initWithImage:lIconMask];
    [mCellView addIconElement:iconView];
    [iconView release];
}

- (void)setPrimaryViewTrim:(CGFloat)trim {
    MKElementAccentView *view = (MKElementAccentView *)[self.contentView viewWithTag:kAccentViewTag];
    view.frame = CGRectMake(view.x, view.y, (view.width - trim), view.height);
    
    UIView *textView = [mCellView viewWithTag:kPrimaryViewTag];
    textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, (textView.frame.size.width - trim), textView.frame.size.height);
}

#pragma mark Gestures

- (void)setRecognizeRightToLeftSwipe:(BOOL)recognize {
    if (recognize) {
        mRightToLeftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipe:)];
        mRightToLeftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
        
        [self addGestureRecognizer:mRightToLeftSwipe];
        [mRightToLeftSwipe release];
    }
    else {
        if (mRightToLeftSwipe) {
            [self removeGestureRecognizer:mRightToLeftSwipe];
            mRightToLeftSwipe = nil;
        }
    }
}

- (void)setRecognizeLeftToRightSwipe:(BOOL)recognize {
    if (recognize) {
        mLeftToRightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipe:)];
        mLeftToRightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
        
        [self addGestureRecognizer:mLeftToRightSwipe];
        [mLeftToRightSwipe release];
    }
    else {
        if (mLeftToRightSwipe) {
            [self removeGestureRecognizer:mLeftToRightSwipe];
            mLeftToRightSwipe = nil;
        }
    }
}

- (void)setRecognizeLongPress:(BOOL)recognize {
    if (recognize) {
        mLongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPress:)];
        
        [self addGestureRecognizer:mLongPress];
        [mLongPress release];
    }
    else {
        if (mLongPress) {
            [self removeGestureRecognizer:mLongPress];
            mLongPress = nil;
        }
    }
}

#pragma mark - Cell behavior

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        if ([delegate respondsToSelector:@selector(didSelectCell:forKey:)]) {
            [delegate didSelectCell:self forKey:self.key];
        }
    }
	
}

#pragma mark - Elements

- (void)addBadgeWithText:(NSString *)text color:(UIColor *)color rect:(CGRect)rect {
    MKTableCellBadgeView *badge = [[MKTableCellBadgeView alloc] initWithFrame:rect];
    badge.badgeText = text;
    badge.badgeColor = color;
    
    [mCellView addSubview:badge];
    [badge release];
}

#pragma mark - Appearance

- (void)accentPrimaryViewForCellAtPosition:(MKTableCellPosition)position {
    UIView *view = [mCellView viewWithTag:1];
    
    MKElementAccentView *accentView = [[MKElementAccentView alloc] initWithFrame:CGRectMake(0.0, 0.0, (view.frame.size.width + 3.0), self.frame.size.height) position:position];
    [self.contentView addSubview:accentView];
    [self.contentView sendSubviewToBack:accentView];
    accentView.tag = kAccentViewTag;
    [accentView release];
    
    if (mTheLabel) {
        mTheLabel.font = VERDANA_BOLD(14.0);
        mTheLabel.adjustsFontSizeToFitWidth = YES;
        mTheLabel.textColor = DARK_GRAY;
        mTheLabel.shadowColor = WHITE;
        mTheLabel.shadowOffset = CGSizeMake(0.0, 1.0);
        mTheLabel.textAlignment = UITextAlignmentCenter;
    }
}

- (void)accentPrimaryViewForCellAtPosition:(MKTableCellPosition)position trim:(CGFloat)trim {
    [self accentPrimaryViewForCellAtPosition:position];
    self.primaryViewTrim = trim;
}

#pragma mark - Validation Methods

- (void)validateWithType:(MKValidationType)aType {
	//Impelmented by suclasses
}

#pragma mark - Actions

- (void)accessoryButton:(id)sender {
	if ([self.delegate respondsToSelector:@selector(didTapAccessoryForKey:)]) {
		[self.delegate didTapAccessoryForKey:self.key];
	}
}

#pragma mark - Gesture Actions

- (void)onSwipe:(UISwipeGestureRecognizer *)sender {
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if ([delegate respondsToSelector:@selector(didSwipeRightToLeftForKey:indexPath:)]) {
            [delegate didSwipeRightToLeftForKey:self.key indexPath:self.indexPath];
        }
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        if ([delegate respondsToSelector:@selector(didSwipeLeftToRightForKey:indexPath:)]) {
            [delegate didSwipeLeftToRightForKey:self.key indexPath:self.indexPath];
        }
    }
}

- (void)onLongPress:(UILongPressGestureRecognizer *)sender {
    if ([delegate respondsToSelector:@selector(didLongPressForKey:indexPath:)]) {
        [delegate didLongPressForKey:self.key indexPath:self.indexPath];
    }
}

#pragma mark - Memory Management

- (void)dealloc {
    if (mValidating) {
        [validator release];
    }
    
    [super dealloc];
	
}

@end



@implementation MKControl (MKTableCell)

void drawWarningIcon(CGContextRef context, CGRect rect);

MKTableCellAccessoryViewType mType = MKTableCellAccessoryNone;

#pragma mark - Initalizer

- (id)initWithType:(MKTableCellAccessoryViewType)type {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.0, 0.0, 30.0, 30.0);
        self.backgroundColor = CLEAR;
        self.opaque = NO;
        
        mType = type;
        
        if (mType == MKTableCellAccessoryWarningIcon) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 5.0, 30.0, 25.0)];
            label.textAlignment = UITextAlignmentCenter;
            label.backgroundColor = CLEAR;
            label.textColor = WHITE;
            label.shadowColor = RED;
            label.shadowOffset = CGSizeMake(0.0, -1.0);
            label.font = SYSTEM_BOLD(24.0);
            label.text = @"!";
            
            [self addSubview:label];
            [label release];
        }
    }
    return self;
}

- (id)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.0, 0.0, 30.0, 30.0);
        self.backgroundColor = CLEAR;
        self.opaque = NO;
        
        mType = MKTableCellAccessoryNone;
        
        UIImageView *view = [[UIImageView alloc] initWithImage:image];
        view.frame = self.frame;
        [self addSubview:view];
        [view release];
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    if (mType == MKTableCellAccessoryWarningIcon) {
        drawWarningIcon(context, rect);
    }
}

#pragma mark Warning Icon

void drawWarningIcon(CGContextRef context, CGRect rect) {
    CGColorRef redColor = RED.CGColor;
    
    CGPoint p1 = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint p2 = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGPoint p3 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, p1.x, p1.y);
    CGPathAddLineToPoint(path, NULL, p2.x, p2.y);
    CGPathAddLineToPoint(path, NULL, p3.x, p3.y);
    CGPathAddLineToPoint(path, NULL, p1.x, p1.y);
    
    CGPathCloseSubpath(path);
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, redColor);
    CGContextAddPath(context, path);
    CGContextClip(context);
    drawGlossAndLinearGradient(context, rect, redColor, redColor);
    CGContextSaveGState(context);
    
    CFRelease(path);
}

@end

@implementation MKView (MKTableCell)

@dynamic pinnedSecondaryElement;

static bool mPinnedSecondaryElement = NO;

#pragma mark - Initalizer

- (id)initWithCell:(MKTableCell *)cell {
    self = [super initWithFrame:cell.contentView.frame];
    if (self) {
        self.backgroundColor = CLEAR;
        self.opaque = NO;
        self.autoresizesSubviews = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
        self.pinnedSecondaryElement = NO;
        
        mShouldRemoveView = NO;
    }
    return self;
}

#pragma mark - Layout

- (void)layoutCell {
    UIView *primaryElement = [self viewWithTag:kPrimaryViewTag];
    UIView *secondaryElement = [self viewWithTag:kSecondaryViewTag];
    UIView *iconElement = [self viewWithTag:kIconViewTag];
    
    if (primaryElement) {
        primaryElement.frame = CGRectMake(kCellPrimaryElementX, kCellPrimaryElementY, kCellPrimaryElementyWidth, kCellSecondaryElementHeight);
    }
    
    if (secondaryElement) {
        if (!self.pinnedSecondaryElement) {
            secondaryElement.frame = CGRectMake(kCellSecondaryElementX, kCellSecondaryElementY, kCellSecondaryElementWidth, kCellSecondaryElementHeight);
        }
        
        if (primaryElement) {
            primaryElement.frame = CGRectMake(primaryElement.frame.origin.x, primaryElement.frame.origin.y, (CGRectGetMinX(secondaryElement.frame) - CGRectGetMinX(primaryElement.frame) - 5.0), primaryElement.frame.size.height);
        }
    }
    
    if (iconElement) {
        iconElement.frame = CGRectMake(kCellIconRectX, kCellIconRectY, kCellIconRectWidth, kCellIconRectHeight);
        
        if (primaryElement) {
            primaryElement.frame = CGRectMake((primaryElement.frame.origin.x + 44.0), primaryElement.frame.origin.y, (primaryElement.frame.size.width - 44.0), primaryElement.frame.size.height);
        }
    }
}

#pragma mark - Accessory Methods
#pragma mark Setters

- (void)setPinnedSecondaryElement:(BOOL)pinned {
    mPinnedSecondaryElement = pinned;
}

#pragma mark Getters

- (BOOL)pinnedSecondaryElement {
    return mPinnedSecondaryElement;
}

#pragma mark - Adding Elements

- (void)addPrimaryElement:(UIView *)element {
    element.tag = kPrimaryViewTag;
    element.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    
    [self addSubview:element];
    [self layoutCell];
}

- (void)addSecondaryElement:(UIView *)element {
    element.tag = kSecondaryViewTag;
    element.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    
    [self addSubview:element];
    [self layoutCell];
}

- (void)addSecondaryElement:(UIView *)element inRect:(CGRect)rect {
    self.pinnedSecondaryElement = YES;
    
    element.tag = kSecondaryViewTag;
    element.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    
    [self addSubview:element];
    [self layoutCell];
}

- (void)addIconElement:(UIView *)element {
    element.tag = kIconViewTag;
    element.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    
    [self addSubview:element];
    [self layoutCell];
}

@end

@implementation MKPopOutView (MKTableCell)

@dynamic aIndexPath;

NSIndexPath *mIndexPath = nil;

#pragma mark - Accessor Methods

- (void)setAIndexPath:(NSIndexPath *)path {
    mIndexPath = [path retain];
}

- (NSIndexPath *)aIndexPath {
    return mIndexPath;
}

#pragma mark - Displaying

- (void)showFromCell:(MKTableCell *)cell onView:(UITableView *)tableView {
    CGRect cellRect = [tableView rectForRowAtIndexPath:cell.indexPath];
    mAnimationType = MKViewAnimationTypeFadeIn;
    self.aIndexPath = [cell.indexPath retain];
    
    if (mType != MKPopOutAuto) {
        mAutoType = mType;
    }
    else {
        if (CGRectGetMaxY(cellRect) < (tableView.bounds.size.height - (mView.frame.size.height + 50.0))) {
            mAutoType = MKPopOutBelow;
        }
        else {
            mAutoType = MKPopOutAbove;
        }
    }
    
    if (mAutoType == MKPopOutBelow) {
        self.frame = CGRectMake(cellRect.origin.x, (cellRect.origin.y + cellRect.size.height), self.width, self.height);
        mView.frame = CGRectMake(10.0, 10.0, kPopOutViewWidth, mView.frame.size.height);
    }
    else if (mAutoType == MKPopOutAbove) {
        self.frame = CGRectMake(cellRect.origin.x, (cellRect.origin.y - self.frame.size.height), self.width, self.height);
        mView.frame = CGRectMake(0.0, 0.0, kPopOutViewWidth, mView.frame.size.height);
        
        [tableView scrollRectToVisible:self.frame animated:YES];
    }
    
    [self setNeedsDisplay];
    
    [tableView addSubview:self];
    [tableView scrollRectToVisible:self.frame animated:YES];
    
    [UIView animateWithDuration:0.25 
                     animations: ^ { self.alpha = 1.0; } ];
}

#pragma mark - Elements

- (void)setDisclosureButtonWithTarget:(id)target selector:(SEL)selector {
    mView.frame = CGRectMake(mView.frame.origin.x, mView.frame.origin.y, (mView.frame.size.width - 33.0), mView.frame.size.height);
    
    MKButton *button = [[MKButton alloc] initWithType:MKButtonTypeDisclosure];
    button.center = CGPointMake((CGRectGetMaxX(self.frame) - 25.0), CGRectGetMidY(mView.frame));
    
    [button completedAction: ^ (MKAction action) {
        if (action == MKActionTouchUp) {
            [target performSelector:selector withObject:self.aIndexPath];
        }
    }];
    
    [self addSubview:button];
    [button release];
}

- (void)dealloc {
    [mIndexPath release];
    mIndexPath = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MK_POP_OUT_VIEW_SHOULD_REMOVE_NOTIFICATION object:nil];
    
    [super dealloc];
}

@end


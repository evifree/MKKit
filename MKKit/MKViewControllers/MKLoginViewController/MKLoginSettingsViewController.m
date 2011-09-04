//
//  MKLoginSettingsViewController.m
//  MKKit
//
//  Created by Matthew King on 5/19/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKLoginSettingsViewController.h"

#define CURRENT_PIN         @"currentPin"
#define NEW_PIN             @"newPin"
#define CONFIRM_PIN         @"confirmPin"

@implementation MKLoginSettingsViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"PIN Settings";
    self.tableView.backgroundColor = LIGHT_GRAY;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PICKER_SHOULD_DISMISS_NOTIFICATION object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    
    switch (section) {
        case 0:
            rows = 3;
            break;
        case 1:
            rows = 2;
            break;
        default:
            break;
    }
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKTableCell *cell = nil;
    
    static NSString *TextIdentifier = @"TextCell";
    static NSString *PickerIdentifier = @"PickerCell";
    
    if (indexPath.section == 0) {
        cell = (MKTableCellTextEntry *)[tableView dequeueReusableCellWithIdentifier:TextIdentifier];
        if (cell == nil) {
            cell = [[[MKTableCellTextEntry alloc] initWithType:MKTextEntryCellTypeStandard reuseIdentifier:TextIdentifier] autorelease];
            ((MKTableCellTextEntry *)cell).theTextField.keyboardType = UIKeyboardTypeNumberPad;
            ((MKTableCellTextEntry *)cell).theTextField.keyboardAppearance =UIKeyboardAppearanceDefault;
            ((MKTableCellTextEntry *)cell).theTextField.accessoryType = MKInputAccessoryTypeDone;
            cell.delegate = self;
        }
        
        if (indexPath.row == 0) {
            cell.key = CURRENT_PIN;
            ((MKTableCellTextEntry *)cell).theTextField.placeholder = @"Current PIN";
            cell.theLabel.text = @"Current";
            cell.validationType = MKValidateIsaSetLength;
            cell.validatorTestStringLength = 4;
            [cell accentPrimaryViewForCellAtPosition:MKTableCellPositionTop];
        }
        if (indexPath.row == 1) {
            cell.key = NEW_PIN;
            ((MKTableCellTextEntry *)cell).theTextField.placeholder = @"New PIN";
            cell.theLabel.text = @"New";
            cell.validationType = MKValidateIsaSetLength;
            cell.validatorTestStringLength = 4;
            [cell accentPrimaryViewForCellAtPosition:MKTableCellPositionMiddle];
        }
        if (indexPath.row == 2) {
            cell.key = CONFIRM_PIN;
            ((MKTableCellTextEntry *)cell).theTextField.placeholder = @"Confirm PIN";
            cell.theLabel.text = @"Confirm";
            cell.validationType = MKValidateIsaSetLength;
            cell.validatorTestStringLength = 4;
            [cell accentPrimaryViewForCellAtPosition:MKTableCellPositionBottom];
        }
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell = (MKTableCellPickerControlled *)[tableView dequeueReusableCellWithIdentifier:PickerIdentifier];
            if (cell == nil) {
                cell = [[[MKTableCellPickerControlled alloc] initWithType:MKTableCellTypeNone reuseIdentifier:PickerIdentifier] autorelease];
                cell.delegate = self;
                ((MKTableCellPickerControlled *)cell).pickerType = MKTableCellPickerTypeStandard;
                ((MKTableCellPickerControlled *)cell).pickerArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Questions" ofType:@"plist"]];
            }
            cell.theLabel.text = @"Question";
            cell.key = CHALLENGE_QUESTION;
            [cell accentPrimaryViewForCellAtPosition:MKTableCellPositionTop];
        }
        if (indexPath.row == 1) {
            cell = (MKTableCellTextEntry *)[tableView dequeueReusableCellWithIdentifier:TextIdentifier];
            if (cell == nil) {
                cell = [[[MKTableCellTextEntry alloc] initWithType:MKTextEntryCellTypeStandard reuseIdentifier:TextIdentifier] autorelease];
                cell.delegate = self;
            }
            cell.key = CHALLENGE_ANSWER;
            cell.validationType = MKValidateHasLength;
            cell.theLabel.text = @"Answer";
            
            ((MKTableCellTextEntry *)cell).theTextField.placeholder = @"Answer"; 
            [cell accentPrimaryViewForCellAtPosition:MKTableCellPositionBottom];
        }
    }
    
    return cell;
}

#pragma mark - Delegates
#pragma mark Table View

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKView *view = nil;
    
    switch (section) {
        case 0:
            view = [MKView headerViewWithTitle:@"Change PIN" type:MKTableHeaderTypeGrouped];
            break;
        case 1:
            view = [MKView headerViewWithTitle:@"Challenge Question" type:MKTableHeaderTypeGrouped];
        default:
            break;
    }
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 32.0;
}

#pragma mark MKTableCell

- (void)valueDidChange:(id)value forKey:(NSString *)aKey {    
    NSString *text = (NSString *)value;
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:aKey];
    
    if ([aKey isEqualToString:CHALLENGE_QUESTION]) {
         [[NSUserDefaults standardUserDefaults] setObject:value forKey:aKey];
    }
    
    if ([aKey isEqualToString:CHALLENGE_ANSWER] && [text length] > 0) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:CHALLENGE_SET];
        [[NSUserDefaults standardUserDefaults] setObject:text forKey:CHALLENGE_ANSWER];
    }
    
    if ([aKey isEqualToString:CURRENT_PIN] && [text length] == 4) {
        if ([text integerValue] != [[NSUserDefaults standardUserDefaults] integerForKey:PIN]) {
            [MKPromptView promptWithType:MKPromptTypeAmber title:@"PIN Mismatch" message:@"The PIN you entered does not match the PIN on file." duration:3.5];
        }
    }
    
    if ([aKey isEqualToString:CONFIRM_PIN] && [value length] == 4) {
        if ([[NSUserDefaults standardUserDefaults] integerForKey:PIN] == [[[NSUserDefaults standardUserDefaults] objectForKey:CURRENT_PIN] integerValue]) {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:NEW_PIN] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:CONFIRM_PIN]]) {
                
                [MKPromptView promptWithType:MKPromptTypeGreen title:@"New PIN" message:@"Your PIN has been changed." duration:3.0];
                [[NSUserDefaults standardUserDefaults] setInteger:[text integerValue] forKey:PIN];
            }
            else {
                [MKPromptView promptWithType:MKPromptTypeAmber title:@"PIN Mismatch" message:@"Your new PIN and PIN Confimation do not match." duration:3.5];
            }
        }
    }
        
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end

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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSString *title = nil;
	
	switch (section) {
		case 0:
			title = @"Change Pin";
			break;
		case 1:
			title = @"Challenge Question";
			break;
        default:
			break;
	}
	return title;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 41.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKTableCell *cell = nil;
    
    static NSString *TextIdentifier = @"TextCell";
    static NSString *PickerIdentifier = @"PickerCell";
    
    if (indexPath.section == 0) {
        cell = (MKTableCellTextEntry *)[tableView dequeueReusableCellWithIdentifier:TextIdentifier];
        if (cell == nil) {
            cell = [[[MKTableCellTextEntry alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TextIdentifier] autorelease];
            ((MKTableCellTextEntry *)cell).theTextField.keyboardType = UIKeyboardTypeNumberPad;
            ((MKTableCellTextEntry *)cell).theTextField.keyboardAppearance =UIKeyboardAppearanceDefault;
            ((MKTableCellTextEntry *)cell).theTextField.useInputAccessoryView = YES;
            cell.delegate = self;
        }
        
        if (indexPath.row == 0) {
            cell.key = CURRENT_PIN;
            ((MKTableCellTextEntry *)cell).theTextField.placeholder = @"Current PIN";
        }
        if (indexPath.row == 1) {
            cell.key = NEW_PIN;
            ((MKTableCellTextEntry *)cell).theTextField.placeholder = @"New PIN";
        }
        if (indexPath.row == 2) {
            cell.key = CONFIRM_PIN;
            ((MKTableCellTextEntry *)cell).theTextField.placeholder = @"Confirm PIN";
        }
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell = (MKTableCellPickerControlled *)[tableView dequeueReusableCellWithIdentifier:PickerIdentifier];
            if (cell == nil) {
                cell = [[[MKTableCellPickerControlled alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PickerIdentifier] autorelease];
                cell.delegate = self;
                ((MKTableCellPickerControlled *)cell).pickerType = MKTableCellPickerTypeStandard;
                ((MKTableCellPickerControlled *)cell).pickerArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Questions" ofType:@"plist"]];
            }
            cell.theLabel.text = @"Question:";
            cell.key = CHALLENGE_QUESTION;
        }
        if (indexPath.row == 1) {
            cell = (MKTableCellTextEntry *)[tableView dequeueReusableCellWithIdentifier:TextIdentifier];
            if (cell == nil) {
                cell = [[[MKTableCellTextEntry alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TextIdentifier] autorelease];
                cell.delegate = self;
            }
            cell.key = CHALLENGE_ANSWER;
            cell.validationType = MKValidateHasLength;
            
            ((MKTableCellTextEntry *)cell).theTextField.placeholder = @"Answer";
        }
    }
    
    return cell;
}

#pragma mark - Delegates
#pragma mark Table View

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

#pragma mark MKTableCell

- (void)valueDidChange:(id)value forKey:(NSString *)aKey {    
    NSString *text = (NSString *)value;
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:aKey];
    
    if ([aKey isEqualToString:CHALLENGE_ANSWER] && [text length] > 0) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:CHALLENGE_SET];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:CHALLENGE_SET];
    }
    
    if ([aKey isEqualToString:CONFIRM_PIN]) {
        if ([[NSUserDefaults standardUserDefaults] integerForKey:PIN] == [[[NSUserDefaults standardUserDefaults] objectForKey:CURRENT_PIN] integerValue]) {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:NEW_PIN] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:CONFIRM_PIN]]) {
                [[NSUserDefaults standardUserDefaults] setInteger:[text integerValue] forKey:PIN];
                
                [MKPromptView promptWithType:MKPromptTypeGreen title:@"New PIN" message:@"Your PIN has been changed." duration:3.0];
            }
        }
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end

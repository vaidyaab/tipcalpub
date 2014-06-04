//
//  TipViewController.m
//  TipCalculator
//
//  Created by Abhijeet Vaidya on 5/31/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipPercentage;
- (IBAction)outsideTap:(id)sender;
- (void) updateValues;
@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    [self setDefaultTipInUI];
    [self updateValues];
}

- (void) setDefaultTipInUI {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    long selectedDefault = [defaults integerForKey:@"DEFAULT_TIP"];
 
    NSLog(@"got the default tip index as %ld from user defaults", selectedDefault);
    
    self.tipPercentage.selectedSegmentIndex = selectedDefault;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)outsideTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void) updateValues {
    
    float billAmount = [self.billTextField.text floatValue];
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    
    float tipAmount = billAmount * [tipValues[self.tipPercentage.selectedSegmentIndex] floatValue];
    
    float totalAmount = billAmount + tipAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
    
}

- (void) onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void) viewDidAppear:(BOOL)animated {
    NSLog(@"view did appear");
    [self setDefaultTipInUI];
    [self updateValues];
}

@end

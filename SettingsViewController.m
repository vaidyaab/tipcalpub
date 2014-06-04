//
//  SettingsViewController.m
//  TipCalculator
//
//  Created by Abhijeet Vaidya on 6/1/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (strong, nonatomic) IBOutlet UILabel *ddText;
@property (strong, nonatomic) IBOutlet UIView *ddMenu;
@property (strong, nonatomic) IBOutlet UIButton *ddMenuShowButton;
- (IBAction)ddMenuShow:(UIButton *)sender;
- (IBAction)ddMenuSelectionMade:(UIButton *)sender;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator Settings";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setddTextToDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ddMenuShow:(UIButton *)sender {
    
    if (sender.tag == 0) {
        sender.tag = 1;
        self.ddMenu.hidden = NO;
        [sender setTitle:@"🔼" forState:UIControlStateNormal];
    } else {
        sender.tag = 0;
        self.ddMenu.hidden = YES;
        [sender setTitle:@"🔽" forState:UIControlStateNormal];
    }
}

- (IBAction) ddMenuSelectionMade:(UIButton *)sender {
    
    self.ddText.text = sender.titleLabel.text;
    [self.ddMenuShowButton setTitle:@"🔽" forState:UIControlStateNormal];
    self.ddMenuShowButton.tag = 0;
    self.ddMenu.hidden = YES;
    
    if(sender.tag > 0){
        [self setDefaultTip:(sender.tag - 1)];
    }

//    switch (sender.tag) {
//            
//        case 1:
//            NSLog(@"set default to 10");
//            [self setDefaultTip:0];
//            break;
//        
//        case 2:
//            NSLog(@"set default to 15");
//            [self setDefaultTip:1];
//            break;
//            
//        case 3:
//            NSLog(@"set default to 20");
//            [self setDefaultTip:2];
//            break;
//            
//        default:
//            break;
//    }
}

- (void) setDefaultTip:(long) defaultTip {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:defaultTip forKey:@"DEFAULT_TIP"];
    [defaults synchronize];
}

- (void) setddTextToDefault {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger selectedDefault = [defaults integerForKey:@"DEFAULT_TIP"];
    
    NSLog(@"got default in settings as %ld", (long)selectedDefault);
    
    switch (selectedDefault) {
            
        case 0:
            self.ddText.text = @"10%";
            break;
            
        case 1:
            self.ddText.text = @"15%";
            break;
            
        case 2:
            self.ddText.text = @"20%";
            break;
            
        default:
            break;
    }

    
}

@end

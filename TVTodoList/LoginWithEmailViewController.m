//
//  LoginWithEmailViewController.m
//  ToDoList
//
//  Created by Cathy Oun on 5/10/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "LoginWithEmailViewController.h"

@interface LoginWithEmailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextfield;

@end

@implementation LoginWithEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)doneButtonPressed:(id)sender {
    if (![self.emailTextfield.text isEqualToString:@""]) {
            [[NSUserDefaults standardUserDefaults] setObject:self.emailTextfield.text forKey:@"kUserEmailDefaultsKey"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end

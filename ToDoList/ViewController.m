//
//  ViewController.m
//  ToDoList
//
//  Created by Cathy Oun on 5/8/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
@import FirebaseAuth;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self checkUserStatus];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self checkUserStatus];
}

- (void)checkUserStatus
{
    if (![[FIRAuth auth] currentUser]) {
        // Show LoginVC
        LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        
        [self presentViewController:loginVC animated:YES completion:nil];
    }
}

@end

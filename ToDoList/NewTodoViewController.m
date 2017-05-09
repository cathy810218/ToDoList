//
//  NewTodoViewController.m
//  ToDoList
//
//  Created by Cathy Oun on 5/8/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "NewTodoViewController.h"
@import Firebase;
@import FirebaseAuth;

@interface NewTodoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextfield;
@property (weak, nonatomic) IBOutlet UITextField *contentTextfield;

@end

@implementation NewTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)doneButtonPressed:(id)sender
{
    FIRDatabaseReference *databaseRef = [[FIRDatabase database] reference];
    FIRUser *currentUser = [[FIRAuth auth] currentUser];
    
    FIRDatabaseReference *userRef = [[databaseRef child:@"users"] child:currentUser.uid];
    FIRDatabaseReference *newTodoRef = [[userRef child:@"todos"] childByAutoId];
    [[newTodoRef child:@"title"] setValue:self.titleTextfield.text];
    [[newTodoRef child:@"content"] setValue:self.contentTextfield.text];
}


@end

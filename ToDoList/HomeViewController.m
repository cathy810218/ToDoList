//
//  HomeViewController.m
//  ToDoList
//
//  Created by Cathy Oun on 5/8/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "NewTodoViewController.h"
#import "TodoCell.h"
#import "Todo.h"
@import UIKit;
@import FirebaseAuth;
@import Firebase;

@interface HomeViewController () <UITableViewDataSource>

@property (strong, nonatomic) FIRDatabaseReference *userReference;
@property (strong, nonatomic) FIRUser *currentUser;
@property (nonatomic) FIRDatabaseHandle allToDoLists;
@property (strong, nonatomic) NewTodoViewController *myTodoVC;
@property (strong, nonatomic) NSMutableArray *allTodos;
@property (nonatomic) BOOL isAddNewTodoPresent;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentTopConstraint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTableViewConstraint;

@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.contentTopConstraint.constant = -214;
    self.topTableViewConstraint.constant = 64;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isAddNewTodoPresent = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"TodoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TodoCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
    self.tableView.dataSource = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.myTodoVC =  self.childViewControllers.firstObject;
    [self checkUserStatus];
}

- (void)checkUserStatus
{
    if (![[FIRAuth auth] currentUser]) {
        LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        
        [self presentViewController:loginVC animated:YES completion:nil];
    } else {
        [self setupFirebase];
        [self startMonitoringTodoUpdates];
    }
}
- (IBAction)logoutButtonPressed:(id)sender {
    NSError *signoutError;
    [[FIRAuth auth] signOut:&signoutError];
    [self checkUserStatus];
}

- (void)setupFirebase
{
    FIRDatabaseReference *databaseRef = [[FIRDatabase database] reference];
    self.currentUser = [[FIRAuth auth] currentUser];
    self.userReference = [[databaseRef child:@"users"] child:self.currentUser.uid];
    NSLog(@"user ref: %@", self.userReference);
}

- (void)startMonitoringTodoUpdates
{
    self.allToDoLists = [[self.userReference child:@"todos"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        self.allTodos = [[NSMutableArray alloc] init];
        for (FIRDataSnapshot *child in snapshot.children) {
            NSDictionary *todoData = child.value;
            NSString *todoTitle = todoData[@"title"];
            NSString *todoContent = todoData[@"content"];
            Todo *todo = [[Todo alloc] initWithTodoTitle:todoTitle andContent:todoContent];
            [self.allTodos addObject:todo];
            [self.tableView reloadData];

            NSLog(@"Todo title: %@ - Content: %@", todoTitle, todoContent);
        }
   }];

}

- (IBAction)addButtonPressed:(id)sender
{
    if (self.isAddNewTodoPresent) {
        [self hideChildViewController];
    } else {
        [self showChildViewController];
    }
}

- (void)showChildViewController
{
    self.isAddNewTodoPresent = YES;
    self.contentTopConstraint.constant = 0;
    self.topTableViewConstraint.constant = 0;
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)hideChildViewController
{
    self.isAddNewTodoPresent = NO;
    self.contentTopConstraint.constant = -214;
    self.topTableViewConstraint.constant = 64;
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allTodos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TodoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoCell" forIndexPath:indexPath];
    Todo *todo = self.allTodos[indexPath.row];
    cell.todoTitleLabel.text = todo.title;
    cell.todoContentLabel.text = todo.content;
    return cell;
}

@end

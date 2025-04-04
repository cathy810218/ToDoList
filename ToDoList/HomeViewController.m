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

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) FIRDatabaseReference *userReference;
@property (strong, nonatomic) FIRUser *currentUser;
@property (nonatomic) FIRDatabaseHandle allToDoLists;
@property (strong, nonatomic) NewTodoViewController *myTodoVC;
@property (strong, nonatomic) NSMutableArray *allTodos;
@property (strong, nonatomic) NSMutableArray *allCompletedTodos;

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

    self.tableView.estimatedRowHeight = 70;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"TodoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TodoCell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsMultipleSelection = YES;
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
    self.allTodos = nil;
    [self.tableView reloadData];
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
            Todo *todo = [[Todo alloc] initWithTodoDictionary:todoData];
            todo.uniqueKey = child.key;
            [self.allTodos addObject:todo];
            if ([todo.isDone isEqualToNumber:@1]) {
                [self.allCompletedTodos addObject:todo];
            }
            [self.tableView reloadData];
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
    cell.todo = todo;
    cell.accessoryType = [todo.isDone isEqual: @1] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TodoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    Todo *todo = self.allTodos[indexPath.row];
    FIRDatabaseReference *todoRef = [[self.userReference child:@"todos"] child:todo.uniqueKey];
    [todoRef updateChildValues:@{@"isDone":@1}];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TodoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    Todo *todo = self.allTodos[indexPath.row];
    FIRDatabaseReference *todoRef = [[self.userReference child:@"todos"] child:todo.uniqueKey];
    [todoRef updateChildValues:@{@"isDone":@0}];
}


@end

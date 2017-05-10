//
//  AllTodosViewController.m
//  ToDoList
//
//  Created by Cathy Oun on 5/9/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "CompletedTodosViewController.h"
#import "Todo.h"
#import "TodoCell.h"
@import Firebase;
@import FirebaseAuth;

@interface CompletedTodosViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) FIRDatabaseReference *userReference;
@property (strong, nonatomic) FIRUser *currentUser;
@property (nonatomic) FIRDatabaseHandle allToDoLists;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *allCompletedTodos;

@end

@implementation CompletedTodosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self startMonitoringTodoUpdates];
}

- (void)setupTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:@"TodoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TodoCell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsMultipleSelection = YES;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 70;
}

- (void)startMonitoringTodoUpdates
{
    FIRDatabaseReference *databaseRef = [[FIRDatabase database] reference];
    self.currentUser = [[FIRAuth auth] currentUser];
    self.userReference = [[databaseRef child:@"users"] child:self.currentUser.uid];
    
    self.allToDoLists = [[self.userReference child:@"todos"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        self.allCompletedTodos = [[NSMutableArray alloc] init];
        for (FIRDataSnapshot *child in snapshot.children) {
            NSDictionary *todoData = child.value;
            Todo *todo = [[Todo alloc] initWithTodoDictionary:todoData];
            todo.uniqueKey = child.key;
            if ([todo.isDone isEqualToNumber:@1]) {
                [self.allCompletedTodos addObject:todo];
            }
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allCompletedTodos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TodoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoCell" forIndexPath:indexPath];
    cell.todo = self.allCompletedTodos[indexPath.row];
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        Todo *todo = self.allCompletedTodos[indexPath.row];
        [[[self.userReference child:@"todos"] child:todo.uniqueKey] removeValue];
    }
}

@end

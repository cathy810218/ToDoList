//
//  TVViewController.m
//  ToDoList
//
//  Created by Cathy Oun on 5/9/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "TVViewController.h"
#import "DetailTodoViewController.h"
#import "LoginWithEmailViewController.h"
#import "Todo.h"
#import "FirebaseAPI.h"

@interface TVViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<Todo *> *allTodos;
@end

@implementation TVViewController

- (void)checkUserStatus
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"kUserEmailDefaultsKey"]) {
            [FirebaseAPI fetchAllTodosWithCompletionHandler:^(NSArray<Todo *> *allTodos) {
                self.allTodos = [allTodos copy];
                [self.tableView reloadData];
            }];
    } else {
        LoginWithEmailViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginWithEmailViewController"];
        
        [self presentViewController:loginVC animated:YES completion:nil];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self checkUserStatus];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.allTodos = [[NSMutableArray alloc] init];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DetailTodoViewController"] &&
        [sender isKindOfClass:[NSIndexPath class]]) {
        NSIndexPath *index = (NSIndexPath *)sender;
        DetailTodoViewController *detailVC = segue.destinationViewController;
        detailVC.todo = self.allTodos[index.row];

    }
}
- (IBAction)logoutButtonPressed:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kUserEmailDefaultsKey"];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.allTodos = nil;
        [self.tableView reloadData];
        [self checkUserStatus];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allTodos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.allTodos[indexPath.row].title;
    cell.detailTextLabel.text = self.allTodos[indexPath.row].content;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"DetailTodoViewController" sender:indexPath];
}

@end

//
//  TVViewController.m
//  ToDoList
//
//  Created by Cathy Oun on 5/9/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "TVViewController.h"
#import "DetailTodoViewController.h"
#import "Todo.h"

@interface TVViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<Todo *> *allTodos;
@end

@implementation TVViewController

- (NSArray<Todo *> *)allTodos
{
    Todo *firstTodo = [[Todo alloc] init];
    firstTodo.title = @"First todo";
    firstTodo.content = @"This is content";
    
    Todo *secondTodo = [[Todo alloc] init];
    secondTodo.title = @"Second todo";
    secondTodo.content = @"This is content";
    
    Todo *thirdTodo = [[Todo alloc] init];
    thirdTodo.title = @"Third todo";
    thirdTodo.content = @"This is content";
    
    return @[firstTodo, secondTodo, thirdTodo];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // Do any additional setup after loading the view.
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

//
//  InterfaceController.m
//  WatchToDoList Extension
//
//  Created by Cathy Oun on 5/9/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "InterfaceController.h"
#import "Todo.h"
#import "TodoRow.h"
#import "DetailTodoInterfaceController.h"

@interface InterfaceController ()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *table;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *numberLabel;
@property (strong, nonatomic) NSArray<Todo *> *allTodos;// Strongly typed

@end


@implementation InterfaceController

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

- (void)setupTable
{
    [self.table setNumberOfRows:self.allTodos.count withRowType:@"TodoRowController"];
    for (NSInteger i = 0; i < self.allTodos.count; i++) {
        TodoRow *todoRow = [self.table rowControllerAtIndex:i];
        [todoRow.todoLabel setText:self.allTodos[i].title];
        [todoRow.contentLabel setText:self.allTodos[i].content];
    }
}

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex
{
    NSLog(@"did select: %i", rowIndex);
    Todo *todo = self.allTodos[rowIndex];
    [self pushControllerWithName:@"DetailTodoInterfaceController" context:todo];
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    [self setupTable];
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
- (IBAction)addNewButtonPressed {
    [self presentTextInputControllerWithSuggestions:@[@"Call John", @"Buy food", @"Pick up Fafy"] allowedInputMode:WKTextInputModePlain completion:^(NSArray * _Nullable results) {
        NSLog(@"%@", results);
    }];
}

@end




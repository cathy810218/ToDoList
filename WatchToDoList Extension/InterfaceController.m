//
//  InterfaceController.m
//  WatchToDoList Extension
//
//  Created by Cathy Oun on 5/9/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "InterfaceController.h"
#import "Todo.h"

@interface InterfaceController ()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *table;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *numberLabel;
@property (strong, nonatomic) NSArray<Todo *> *allTodos;// Strongly typed

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

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

@end




//
//  DetailTodoInterfaceController.m
//  ToDoList
//
//  Created by Cathy Oun on 5/9/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "DetailTodoInterfaceController.h"

@interface DetailTodoInterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *titleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *contentLabel;
@property (strong, nonatomic) Todo *todo;

@end

@implementation DetailTodoInterfaceController

-(void)awakeWithContext:(id)context
{
    [super awakeWithContext:context];
    self.todo = (Todo *)context;
    [self.titleLabel setText:self.todo.title];
    [self.contentLabel setText:self.todo.content];
}
@end

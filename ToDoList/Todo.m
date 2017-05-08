//
//  Todo.m
//  ToDoList
//
//  Created by Cathy Oun on 5/8/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "Todo.h"

@implementation Todo

- (instancetype)initWithTodoTitle:(NSString *)title andContent:(NSString *)content
{
    self = [super init];
    if (self) {
        _title = title;
        _content = content;
    }
    return self;
}
@end

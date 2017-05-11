//
//  Todo.m
//  ToDoList
//
//  Created by Cathy Oun on 5/8/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "Todo.h"

@implementation Todo

- (instancetype)initWithTodoDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        _title = dict[@"title"];
        _content = dict[@"content"];
        _isDone = dict[@"isDone"];
        _email = dict[@"email"];
    }
    return self;
}
@end

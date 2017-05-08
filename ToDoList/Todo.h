//
//  Todo.h
//  ToDoList
//
//  Created by Cathy Oun on 5/8/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Todo : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;

- (instancetype)initWithTodoTitle:(NSString *)title andContent:(NSString *)content;

@end

//
//  FirebaseAPI.h
//  ToDoList
//
//  Created by Cathy Oun on 5/10/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Todo.h"

@interface FirebaseAPI : NSObject

+ (void)fetchAllTodosWithCompletionHandler:(void (^)(NSArray<Todo *> *allTodos))completionHandler;
@end

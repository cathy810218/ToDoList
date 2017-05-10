//
//  FIRManager.h
//  ToDoList
//
//  Created by Cathy Oun on 5/9/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FIRManager : NSObject

+ (instancetype)shared;
- (void)startMonitoringTodoUpdatesWithCompletionHandler:(void (^)(NSArray *todo, NSArray *todid))completionHandler;
@end

//
//  FirebaseAPI.m
//  ToDoList
//
//  Created by Cathy Oun on 5/10/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "FirebaseAPI.h"
#import "Credentials.h"

@implementation FirebaseAPI

+ (void)fetchAllTodosWithCompletionHandler:(void (^)(NSArray<Todo *> *allTodos))completionHandler
{
    NSString *urlString = [NSString stringWithFormat:@"https://todolist-aee7c.firebaseio.com/users.json?auth=%@", APP_KEY]; // users -> endpoint
    NSURL *databaseURL = [NSURL URLWithString:urlString];
    
    //ephemeral wont cached
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    [[session dataTaskWithURL:databaseURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        if (error) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        NSError *serialzedError;
        NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&serialzedError];
        
        NSMutableArray *allTodos = [[NSMutableArray alloc] init];
//        NSLog(@"All values: %@",rootObject.allValues);
//        NSLog(@"All key: %@",rootObject.allKeys);
        
        // Get current user's todos
        // Firebase doesn't support tvOS, so we have no way to varify user's id
        // Fetch all user's todo
        for (NSDictionary *userDictionary in rootObject.allValues) {
            NSArray *userTodosKey = [userDictionary[@"todos"] allKeys];
            NSDictionary *todosDict = userDictionary[@"todos"];
            for (NSString *key in userTodosKey) {
                NSDictionary *todoDict = todosDict[key];
                Todo *newTodo = [[Todo alloc] initWithTodoDictionary:todoDict];
                newTodo.uniqueKey = key;
                [allTodos addObject:newTodo];
            }
        }
        completionHandler(allTodos);
        
    }] resume];
}

@end

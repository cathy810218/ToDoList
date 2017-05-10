//
//  FIRManager.m
//  ToDoList
//
//  Created by Cathy Oun on 5/9/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "FIRManager.h"
#import "Todo.h"
@import FirebaseAuth;
@import Firebase;

@interface FIRManager ()

@property (strong, nonatomic) FIRDatabaseReference *userReference;
@property (strong, nonatomic) FIRUser *currentUser;
@property (nonatomic) FIRDatabaseHandle allToDoLists;
@property (strong, nonatomic) NSMutableArray *allTodos;
@property (strong, nonatomic) NSMutableArray *allCompletedTodos;

@end

@implementation FIRManager

+ (instancetype)shared
{
    static FIRManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupFirebase];
    }
    return self;
}

- (void)setupFirebase
{
    FIRDatabaseReference *databaseRef = [[FIRDatabase database] reference];
    self.currentUser = [[FIRAuth auth] currentUser];
    self.userReference = [[databaseRef child:@"users"] child:self.currentUser.uid];
}

- (void)startMonitoringTodoUpdatesWithCompletionHandler:(void (^)(NSArray *todo, NSArray *todid))completionHandler
{
    self.allToDoLists = [[self.userReference child:@"todos"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        self.allTodos = [[NSMutableArray alloc] init];
        self.allCompletedTodos = [[NSMutableArray alloc] init];
        for (FIRDataSnapshot *child in snapshot.children) {
            NSDictionary *todoData = child.value;
            Todo *todo = [[Todo alloc] initWithTodoDictionary:todoData];
            todo.uniqueKey = child.key;
            [self.allTodos addObject:todo];
            if ([todo.isDone isEqualToNumber:@1]) {
                [self.allCompletedTodos addObject:todo];
            }
        }
        completionHandler(self.allTodos, self.allCompletedTodos);
    }];
}

@end

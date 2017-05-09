//
//  TodoRowController.h
//  ToDoList
//
//  Created by Cathy Oun on 5/9/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import <Foundation/Foundation.h>
@import WatchKit;

@interface TodoRowController : NSObject

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *todoLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *contentLabel;

@end

//
//  DetailTodoViewController.m
//  ToDoList
//
//  Created by Cathy Oun on 5/9/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "DetailTodoViewController.h"

@interface DetailTodoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation DetailTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.todo.title;
    self.contentLabel.text = self.todo.content;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

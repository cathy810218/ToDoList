//
//  TodoCell.m
//  ToDoList
//
//  Created by Cathy Oun on 5/8/17.
//  Copyright © 2017 cathyoun. All rights reserved.
//

#import "TodoCell.h"
@interface TodoCell ()
@property (weak, nonatomic) IBOutlet UILabel *todoTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *todoContentLabel;

@end

@implementation TodoCell

-(void)setTodo:(Todo *)todo
{
    self.todoTitleLabel.text = todo.title;
    self.todoContentLabel.text = todo.content;
}

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

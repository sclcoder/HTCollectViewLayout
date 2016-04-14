//
//  HTCollectionViewCellX.m
//  collectionView
//
//  Created by sunchunlei on 16/4/14.
//  Copyright © 2016年 womai. All rights reserved.
//

#import "HTCollectionViewCellX.h"

@interface HTCollectionViewCellX ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation HTCollectionViewCellX

- (void)awakeFromNib {
    // Initialization code
    self.textLabel.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0  blue:arc4random_uniform(255)/255.0  alpha:1.0];
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    
}

- (void)setTextName:(NSString *)textName{

    _textName = [textName copy];
    _textLabel.text = _textName;

}

@end

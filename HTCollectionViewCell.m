//
//  HTCollectionViewCell.m
//  collectionView
//
//  Created by sunchunlei on 15/8/13.
//  Copyright (c) 2015年 womai. All rights reserved.
//

#import "HTCollectionViewCell.h"

@interface HTCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation HTCollectionViewCell


- (void)awakeFromNib{
    
    self.contentView.layer.borderWidth = 4;
    self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.contentView.layer.cornerRadius = 25;
    self.contentView.layer.masksToBounds = YES;
}


- (void)setImageName:(NSString *)imageName{
    // 小技巧  代替 _imageName = imageName
    [_imageName copy];
    self.imageView.image = [UIImage imageNamed:imageName];
}

@end

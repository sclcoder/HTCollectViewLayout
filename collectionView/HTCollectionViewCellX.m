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
    
    
}

- (void)setTextName:(NSString *)textName{

    _textName = [textName copy];
    _textLabel.text = _textName;

}

@end

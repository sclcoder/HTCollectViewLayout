//
//  HTStack.m
//  collectionView
//
//  Created by sunchunlei on 15/8/13.
//  Copyright (c) 2015年 womai. All rights reserved.
//

#import "HTStack.h"

@interface HTStack ()

@property (nonatomic, assign) NSInteger cellCount;

@property (nonatomic, assign) CGPoint center;


@end

@implementation HTStack


// Tells the layout object to update the current layout.
- (void)prepareLayout{

    [super prepareLayout];
    CGSize size = self.collectionView.frame.size;
    self.cellCount = [self.collectionView numberOfItemsInSection:0];
    self.center = CGPointMake(size.width * 0.5, size.height * 0.5);
}

//整个collectionView的内容大小就是collectionView的大小（没有滚动）
-(CGSize)collectionViewContentSize
{
    return [self collectionView].frame.size;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{

    return YES;
}

// 获取attributes的方法

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"layoutAttributesForItemAtIndexPath");

    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
        // 设置attribute
        attribute.size = CGSizeMake(100, 100);
        
        CGPoint tempCenter;
        tempCenter.x  = arc4random_uniform(400);
        tempCenter.y  = arc4random_uniform(200);
        attribute.center =  tempCenter;
    
        attribute.transform = CGAffineTransformMakeRotation(arc4random_uniform(20));
        
        // zIndex越大,就越在上面
        attribute.zIndex = self.cellCount - indexPath.item;
//
//        return attribute;
    
    NSArray *angle = @[@(-1),@(-0.2),@0,@(0.2),@1];
    
    if (indexPath.item >= 5) {
        
        attribute.hidden = YES;
        
    }else {
        // 设置attribute
        
        attribute.size = CGSizeMake(100, 100);
        
        CGPoint tempCenter;
        tempCenter.x  = self.center.x + arc4random_uniform(100);
        tempCenter.y  = self.center.y + arc4random_uniform(50);
        attribute.center =  tempCenter;
        
        
        attribute.center = self.center;
        
        attribute.transform = CGAffineTransformMakeRotation([angle[indexPath.item] floatValue]);
        
        // zIndex越大,就越在上面
        attribute.zIndex = self.cellCount - indexPath.item;
    }
    return attribute;
}



// 设置attributes

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{

    NSMutableArray *array = [NSMutableArray array];
    
    for (NSInteger i = 0; i < self.cellCount; i++) {
        
        // 生成indexPath
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        [self layoutAttributesForItemAtIndexPath:indexPath];
        
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [array addObject:attribute];
    }
    
    return array;
}

@end

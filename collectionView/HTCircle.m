//
//  HTCircle.m
//  collectionView
//
//  Created by sunchunlei on 15/8/13.
//  Copyright (c) 2015年 womai. All rights reserved.
//

#import "HTCircle.h"


@interface HTCircle ()

@property (nonatomic, assign) CGFloat radius;

@property (nonatomic, assign) NSInteger cellCount;

@property (nonatomic, assign) CGPoint center;

@end

@implementation HTCircle

- (instancetype)init{
    
    if (self = [super init]) {
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    return YES;
}

- (void)prepareLayout{
    
    self.cellCount = [self.collectionView numberOfItemsInSection:0];
    
    CGSize size = self.collectionView.frame.size;
    
    self.radius = MIN(size.width, size.height) * 0.25;

    self.center = CGPointMake(size.width * 0.5,  size.height * 0.5);
}

- (CGSize)collectionViewContentSize{

    return self.collectionView.frame.size;

}


// 获取item的attribute
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
 
    NSMutableArray *attributes = [NSMutableArray array];
    
    // 生成indexPath
    for (NSInteger i = 0; i < self.cellCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];

        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [attributes addObject:attribute];
    }
    
    return attributes;
}


// 设置attributes
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // cricleLayout
    
    // 计算间隔角度
    CGFloat angel = M_PI * 2 / self.cellCount;

    // 计算每个item的坐标

    attribute.size = CGSizeMake(50, 50);
    CGFloat x = self.center.x + self.radius * cosf(angel * indexPath.item);
    CGFloat y = self.center.y + self.radius * sinf(angel * indexPath.item);
    attribute.center = CGPointMake(x, y);
    
    attribute.zIndex = self.cellCount - indexPath.item;
    
    return attribute;

}

@end

//
//  HTLineLayout.m
//  collectionView
//
//  Created by sunchunlei on 15/8/13.
//  Copyright (c) 2015年 womai. All rights reserved.
//

#import "HTLineLayout.h"

static const CGFloat HTItemHW = 100;


/**
    核心方法:  1.实现cell的放大--即改变cell的layoutAttributes 在layoutAttributesForElementsInRect方法中实现
              2.指定某个cell居中显示--即控制contentView的contentOffset通过layoutAttributesForElementsInRect方法中返回的cells微调contentOffset(类似分页)
 */
@implementation HTLineLayout

- (instancetype)init{

    if (self = [super init]) {
    }
    return self;
}

// 当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息即更新layout
/**
 *  另外，在需要更新layout时，需要给当前layout发送 -invalidateLayout，该消息会立即返回，并且预约在下一个loop的时候刷新当前layout，这一点和UIView的 setNeedsLayout方法十分类似。在-invalidateLayout后的下一个collectionView的刷新loop中，又会从 prepareLayout开始，依次再调用-collectionViewContentSize和 -layoutAttributesForElementsInRect来生成更新后的布局。
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{

//    NSLog(@"%@",NSStringFromCGRect(newBounds));
    return YES;
}

/**
 *  控制collectionView停止滚动时所停留的最终位置
 *
 *  @param proposedContentOffset 默认情况下collectionView停止滚动 contenoffset的值
 *  @param velocity              速度
 *
 *  @return collectionView停止滚动时最终contentoffset的值
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    
    NSLog(@"targetContentOffsetForProposedContentOffset");

    // 1.计算collectionView最后停留的位置
    CGRect lastRect ;
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.frame.size;
    
    // 计算contentView在屏幕中间的X
    CGFloat centerX;
    centerX = lastRect.origin.x + self.collectionView.frame.size.width * 0.5;
    
    // 找出“最终”显示的item的attribute 与centerX对比
    // [super layoutAttributesForElementsInRect] 这里调用super的方法即可 如果self 会多算一遍
    NSArray *visibleArray = [super layoutAttributesForElementsInRect:lastRect];

    CGFloat adjustOffsetx = CGFLOAT_MAX;
    
    for (UICollectionViewLayoutAttributes *attribute in visibleArray) {
//        NSLog(@"%@",attribute);
        // 找出距离最近的Item
        if (ABS(attribute.center.x - centerX) < ABS(adjustOffsetx)) {
            adjustOffsetx = attribute.center.x - centerX;
        }
    }
    // 调整contentOffset
    return CGPointMake(proposedContentOffset.x + adjustOffsetx, proposedContentOffset.y);

}


/**
 *  设置collectionView 所有元素的布局参数
 *
 *  @param rect 系统默认调用该方法时rect时预估值 比屏幕要大一些（预估用户会左右上下滑动等）
 *
 *  @return 存放布局参数的数组
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
//    NSLog(@"%@",NSStringFromCGRect(rect));
    // 利用父类返回的Attributes数组数据  修改数据让其放大
    
    NSArray *array =  [super layoutAttributesForElementsInRect:rect];
   
    // 因为默认的rect会比较大 这里放大处理可以只处理显示的cell
    // 1.计算显示的的区域
    CGRect visibleRect ;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.frame.size;
    
    // 2.计算中轴线
    CGFloat centerX;
    centerX = visibleRect.origin.x + visibleRect.size.width * 0.5;
    
    // 3.找出显示的item的attribute
    
    for (UICollectionViewLayoutAttributes *attribute in array) {

        // 如果不在屏幕上直接跳过
        if (!CGRectIntersectsRect(visibleRect, attribute.frame)) continue;
        
        // 放大
        // 设置放大比例

        CGFloat scale = 1 + 0.5 * (1 - ABS(attribute.center.x - centerX)/(self.collectionView.frame.size.width * 0.5));
        
        attribute.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return array;
}


/**
 *  只要布局刷新首先调用该方法
 */
- (void)prepareLayout{

    [super prepareLayout];
    
    self.itemSize = CGSizeMake(HTItemHW, HTItemHW);
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 在layout类的init设置不准确原因  init方法中collectionView的frame还没设置
    CGFloat inset = self.collectionView.frame.size.width / 2 - HTItemHW / 2;
    // 使用self.sectionInset 而不是 collectionViewInset设置间距 这样会保留colleectionView之前的inset
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    
    self.minimumLineSpacing =  HTItemHW / 2;

}



@end

//
//  BSCollectionViewHorizontalLayout.m
//  Emoticon
//
//  Created by wangyusong on 2023/1/13.
//

#import "BSCollectionViewHorizontalLayout.h"

@implementation BSCollectionViewHorizontalLayout
- (void)prepareLayout
{
    [super prepareLayout];
    
//    self.rowCount = 3;
//    self.itemCountPerRow = 7;
    self.allAttributes = [NSMutableArray array];
    
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSUInteger i = 0; i<count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.allAttributes addObject:attributes];
    }
}

- (CGSize)collectionViewContentSize
{
    return [super collectionViewContentSize];

//    int width = (int)ceil(self.allAttributes.count/(self.rowCount * self.itemCountPerRow * 1.0)) * self.collectionViewContentWidth;
//    return CGSizeMake(width, 0);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger item = indexPath.item;
    NSUInteger x;
    NSUInteger y;
    [self targetPositionWithItem:item resultX:&x resultY:&y];
    NSUInteger item2 = [self originItemAtX:x y:y];
    NSIndexPath *theNewIndexPath = [NSIndexPath indexPathForItem:item2 inSection:indexPath.section];
    
    UICollectionViewLayoutAttributes *theNewAttr = [super layoutAttributesForItemAtIndexPath:theNewIndexPath];
    theNewAttr.indexPath = indexPath;
    return theNewAttr;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *tmp = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attr in attributes) {
        for (UICollectionViewLayoutAttributes *attr2 in self.allAttributes) {
            if (attr.indexPath.item == attr2.indexPath.item) {
                [tmp addObject:attr2];
                break;
            }
        }
    }
    return tmp;
}

// 根据 item 计算目标item的位置
// x 横向偏移  y 竖向偏移
- (void)targetPositionWithItem:(NSUInteger)item
                resultX:(NSUInteger *)x
                resultY:(NSUInteger *)y
{
    NSUInteger page = item/(self.itemCountPerRow*self.rowCount);
    
    NSUInteger theX = item % self.itemCountPerRow + page * self.itemCountPerRow;
    NSUInteger theY = item / self.itemCountPerRow - page * self.rowCount;
    if (x != NULL) {
        *x = theX;
    }
    if (y != NULL) {
        *y = theY;
    }
}

// 根据偏移量计算item
- (NSUInteger)originItemAtX:(NSUInteger)x
y:(NSUInteger)y
{
    NSUInteger item = x * self.rowCount + y;
    return item;
}
@end

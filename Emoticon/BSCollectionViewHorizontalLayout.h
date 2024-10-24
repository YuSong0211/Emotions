//
//  BSCollectionViewHorizontalLayout.h
//  Emoticon
//
//  Created by wangyusong on 2023/1/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSCollectionViewHorizontalLayout : UICollectionViewFlowLayout
@property (nonatomic) NSUInteger itemCountPerRow;
// 一页显示多少行
@property (nonatomic) NSUInteger rowCount;

@property (strong, nonatomic) NSMutableArray *allAttributes;
@end

NS_ASSUME_NONNULL_END

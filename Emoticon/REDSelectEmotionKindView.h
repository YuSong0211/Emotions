//
//  REDSelectEmotionKindView.h
//  Emoticon
//
//  Created by wangyusong on 2023/2/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface REDSelectEmotionKindView : UIView
@property(nonatomic, assign,readonly) NSUInteger pageCount;
@property (nonatomic, copy) void (^pageControlBlock)(NSInteger intPage);
@property (nonatomic, strong,readonly) UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END

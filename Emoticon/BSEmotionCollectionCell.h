//
//  BSEmotionCollectionCell.h
//  Emoticon
//
//  Created by wangyusong on 2023/1/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSEmotionCollectionCell : UICollectionViewCell
@property (nonatomic, strong,readonly) UIView *coverView;
@property (nonatomic, strong,readonly) UIImageView *imageView;
@end

NS_ASSUME_NONNULL_END

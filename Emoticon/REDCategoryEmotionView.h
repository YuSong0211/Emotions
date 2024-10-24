//
//  REDCategoryEmotionView.h
//  Emoticon
//
//  Created by wangyusong on 2023/2/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,REDCategoryEmotionKind){
    REDCategoryEmotionKindKeyboard,
    REDCategoryEmotionKindHot,
};

@interface REDCategoryEmotionView : UIView
@property (nonatomic, copy) void(^categoryEmotionBlock)(REDCategoryEmotionKind kind);

-(void)switchEmotionKeyboard:(REDCategoryEmotionKind)kind;
@end

NS_ASSUME_NONNULL_END

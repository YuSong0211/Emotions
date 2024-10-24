//
//  BSEmotionCollectionCell.m
//  Emoticon
//
//  Created by wangyusong on 2023/1/13.
//

#import "BSEmotionCollectionCell.h"
@interface BSEmotionCollectionCell()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *coverView;
@end
@implementation BSEmotionCollectionCell{
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.coverView];
 
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat hw = self.frame.size.width - 10;
    self.imageView.frame = CGRectMake(5, 5, hw, hw);
    self.coverView.frame = CGRectMake(5, 5, hw, hw);
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.image = [UIImage imageNamed:@"common_item_choco_icon_big"];
    }
    return _imageView;
}

-(UIView *)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc]init];
        _coverView.backgroundColor = [UIColor whiteColor];
    }
    return _coverView;
}
@end

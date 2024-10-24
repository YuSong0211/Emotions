//
//  ViewController.m
//  Emoticon
//
//  Created by wangyusong on 2023/1/13.
//

#import "ViewController.h"
#import "BSEmotionView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) BSEmotionView *v;
@end
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BSEmotionView *v = [[BSEmotionView alloc]init];
    v.frame = CGRectMake(0, kScreenHeight - 300,kScreenWidth , 300);
    v.backgroundColor = [UIColor grayColor];
    self.v = v;
    [self.view addSubview:v];
    
}
- (IBAction)responder:(id)sender {
    [self.textField resignFirstResponder];
}
- (IBAction)cancelnputView:(id)sender {
    self.textField.inputView = nil;
    [self.textField reloadInputViews];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    BSEmotionView *v = [[BSEmotionView alloc]init];
    v.frame = CGRectMake(0, 0,kScreenWidth , 300);
    v.backgroundColor = [UIColor grayColor];
    self.textField.inputView = v;
    [self.textField reloadInputViews];
}
@end

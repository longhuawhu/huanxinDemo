//
//  ViewController.m
//  huanxinDemo
//
//  Created by lh on 15/7/22.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "ViewController.h"
#import "EaseMob.h"
#import "ImMainViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *pwdTf;
- (IBAction)loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *RegisterBtn;
- (IBAction)RegisteBtnAction;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginBtn {
    NSString *name = self.nameTf.text;
    NSString *pwd = self.pwdTf.text;
    
    if ([name length] == 0 || [pwd length] == 0) {
        return;
    }
    
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:name password:pwd completion:^(NSDictionary *loginInfo, EMError *error) {
        if (!error) {
            // 设置自动登录
            [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
            ImMainViewController *mainVc = [[ImMainViewController alloc] init];
            [self presentViewController:mainVc animated:YES
                             completion:nil];
        }
        else{
            NSLog(@"%@", error);
        }
    } onQueue:nil];

}
- (IBAction)RegisteBtnAction {
    
    NSString *name = self.nameTf.text;
    NSString *pwd = self.pwdTf.text;
    
    if ([name length] == 0 || [pwd length] == 0) {
        return;
    }
    
    EMError *error = nil;
    BOOL isSuccess = [[EaseMob sharedInstance].chatManager registerNewAccount:name password:pwd error:&error];
    if (isSuccess) {
        NSLog(@"注册成功");
    }
}
@end

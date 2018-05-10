//
//  ViewController.m
//  2017FaceBook
//
//  Created by 張揚法 on 2018/2/23.
//  Copyright © 2018年 張揚法. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ViewController ()

@end

@implementation ViewController


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    FriendArrayLabel = [[NSMutableArray alloc] init];
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
    loginButton.delegate = self;
    loginButton.frame = CGRectMake(self.view.frame.size.width/2 - 75, 320, 150, 30);
    loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    [self.view addSubview:loginButton];
    
    
    
    //開啟app檢查登入狀況,之前已登過就會進入
    if ([FBSDKAccessToken currentAccessToken]) {
        NSLog(@"Login6666");
        // User is logged in, do work such as go to next view controller.
        
        //FB大頭照
        FBSDKProfilePictureView *profilePictureview = [[FBSDKProfilePictureView alloc]initWithFrame:_imageview.frame];
        profilePictureview.frame = CGRectMake(self.view.frame.size.width/2 - 75, self.view.frame.size.height/2 - 180, 150, 150);
        [self.view addSubview:profilePictureview];
        
        
        //獲取FB資料
        FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                      initWithGraphPath:@"me?fields=id,name,email,friends"
                                      parameters:nil
                                      HTTPMethod:@"GET"];
        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            // Insert your code here
            
            NSLog(@"result : %@",result);
            NSLog(@"id : %@",[result objectForKey:@"id"]);
            NSLog(@"name : %@",[result objectForKey:@"name"]);
            self.NameLabel.text = [result objectForKey:@"name"];
            NSLog(@"email : %@",[result objectForKey:@"email"]);
            self.EmailLabel.text = [result objectForKey:@"email"];
            
            NSLog(@"friends : %@",[[result objectForKey:@"friends"] objectForKey:@"data"]);
            
            //測試帳號：
            //帳號lisa_bntvyke_test@tfbnw.net
            //密碼Lisa1234
            
            //FB回傳朋友json格式
            /*
             
             (
                {
                    id = 135581310603448;
                    name = "Open Graph Test User";
                },
                {
                    id = 113330569502387;
                    name = "Dave Albdgfcccecei Qinberg";
                }
             )

             */
            
            
            //資料轉成Array
            NSArray *friendsArray = [[result objectForKey:@"friends"] objectForKey:@"data"];
            
            
            //解析第二層
            for (NSDictionary *p in friendsArray) {
                
                NSString *FriendID = [p objectForKey:@"id"];
                NSString *FriendName = [p objectForKey:@"name"];
                [FriendArrayLabel addObject:FriendName];
                
                NSLog(@"FriendID：%@",FriendID);
                NSLog(@"FriendName：%@",FriendName);
                
            }
           
            NSString *String = @"";
            
            for (int i = 0; i<FriendArrayLabel.count; i++) {
                
                
                NSString *line = [NSString stringWithFormat:@"\n%@",[FriendArrayLabel objectAtIndex:i]];
                    
                String = [String stringByAppendingString:line];
                NSLog(@"FriendArray : %@",[FriendArrayLabel objectAtIndex:i]);
                
                self.FriendsLabel.text = String;
                
            }
            
        }];
    }
    
    
   
    
    
    
}


//登入後動作 獲取資料
- (void)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
              error:(NSError *)error{
    
    NSLog(@"999999999");
    
    //FB大頭照
    FBSDKProfilePictureView *profilePictureview = [[FBSDKProfilePictureView alloc]initWithFrame:_imageview.frame];
    profilePictureview.frame = CGRectMake(self.view.frame.size.width/2 - 75, self.view.frame.size.height/2 - 180, 150, 150);
    [self.view addSubview:profilePictureview];
    
    
    //獲取FB資料   me?fields=id,name,email
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:@"me?fields=id,name,email,friends"
                                  parameters:nil
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        // Insert your code here
        
        NSLog(@"result : %@",result);
        NSLog(@"id : %@",[result objectForKey:@"id"]);
        NSLog(@"name : %@",[result objectForKey:@"name"]);
        self.NameLabel.text = [result objectForKey:@"name"];
        NSLog(@"email : %@",[result objectForKey:@"email"]);
        self.EmailLabel.text = [result objectForKey:@"email"];
        NSLog(@"friends : %@",[[result objectForKey:@"friends"]objectForKey:@"data"]);
        
       
        //資料轉成Array
        NSArray *friendsArray = [[result objectForKey:@"friends"] objectForKey:@"data"];
        
        //解析第二層
        for (NSDictionary *p in friendsArray) {
            
            NSString *FriendID = [p objectForKey:@"id"];
            NSString *FriendName = [p objectForKey:@"name"];
            NSLog(@"FriendID：%@",FriendID);
            NSLog(@"FriendName：%@",FriendName);
            
        }
        
        
        NSString *String = @"";
        
        for (int i = 0; i<FriendArrayLabel.count; i++) {
            
            
            NSString *line = [NSString stringWithFormat:@"\n%@",[FriendArrayLabel objectAtIndex:i]];
            
            String = [String stringByAppendingString:line];
            
            
            self.FriendsLabel.text = String;
            
        }
        
        
        
    }];
    
    
}



//登出
- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{

    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
        [login logOut];
        NSLog(@"Logout");
    
    self.NameLabel.text = @"";
    self.EmailLabel.text = @"";
    self.FriendsLabel.text = @"";
    
}







@end

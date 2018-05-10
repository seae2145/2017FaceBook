//
//  ViewController.h
//  2017FaceBook
//
//  Created by 張揚法 on 2018/2/23.
//  Copyright © 2018年 張揚法. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ViewController : UIViewController<FBSDKLoginButtonDelegate>{
    
    NSMutableArray *FriendArrayLabel;
    
}


@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *EmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *FriendsLabel;

@end


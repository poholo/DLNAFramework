//
//  DetailViewController.h
//  DLNASample
//
//  Created by 健司 古山 on 12/05/06.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CyberLink/CGUpnpAvServer.h>
#import <CyberLink/CGUpnpAvRenderer.h>

/**
 *  @brief 詳細画面
 */
@interface DetailViewController : UIViewController <CGUpnpAvServerDelegate>

@property (nonatomic, strong) CGUpnpAvRenderer * render;

@property (strong, nonatomic) id detailItem;
@property (nonatomic, retain) UILabel *ipAddressLable;
@end

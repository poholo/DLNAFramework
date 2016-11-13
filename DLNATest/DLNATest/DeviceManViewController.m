
//
//  DeviceManViewController.m
//  DLNATest
//
//  Created by majiancheng on 16/11/10.
//  Copyright © 2016年 mjc. All rights reserved.
//

#import "DeviceManViewController.h"

@interface DeviceManViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray * dataArr;

@end

@implementation DeviceManViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //TODO:: action
    switch (indexPath.row) {
        case 0: {
            if(![self.render setAVTransportURI:@"http://vssauth.waqu.com/uh33m875ctkrky7g/normal_wm.mp4?auth_key=1478861485-0-0-2f95a9ee61ddb4d1f04a3b3aae61cf3f"]) {
                NSLog(@"投屏失败");
            }
        }
            break;
        case 1: {
            if (![self.render pause]) {
                NSLog(@"暂停失败");
            }
        }
            break;
        case 2: {
            if(![self.render play]) {
                NSLog(@"播放失败");
            }
        }
            break;
        case 3: {
            if(1) {
            
            }
        }
            break;
        case 4: {
        }
            break;
        case 5: {
            if(![self.render stop]) {
                NSLog(@"停止播放失败");
            }
        }
            break;
        default:
            break;
    }
}


- (NSArray *)dataArr {
    if(_dataArr == nil) {
        NSMutableArray * data = [[NSMutableArray alloc] init];
        [data addObject:@"投屏"];
        [data addObject:@"暂停"];
        [data addObject:@"播放"];
        [data addObject:@"音量＋"];
        [data addObject:@"音量1-"];
        [data addObject:@"退出"];
        
        _dataArr = data;
    }
    return _dataArr;
}

@end

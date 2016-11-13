
//
//  DevicesTableViewController.m
//  DLNATest
//
//  Created by majiancheng on 16/11/10.
//  Copyright © 2016年 mjc. All rights reserved.
//

#import "DevicesTableViewController.h"
#import <clickc2/CGUpnpAvController.h>
#import "DeviceManViewController.h"

@interface DevicesTableViewController () <CGUpnpControlPointDelegate>

@property (nonatomic, strong) CGUpnpAvController * phpAVController;
@property (nonatomic, strong) NSArray * findDevices;

@end

@implementation DevicesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.phpAVController = [[CGUpnpAvController alloc] init];
    _phpAVController.delegate = self;
    [_phpAVController search];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.findDevices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    CGUpnpDevice *device  = self.findDevices[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@:%@:%@", device.friendlyName, device.modelName, device.ipaddress];
    [self loadImageView:cell.imageView device:device];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
}

- (void)loadImageView:(UIImageView *)iamgeView device:(CGUpnpDevice *)upnpDevice {
    CGUpnpIcon *smallestIcon = [upnpDevice smallestIconWithMimeType:@"image/png"];
    if (smallestIcon == nil)
        smallestIcon = [upnpDevice smallestIconWithMimeType:@"image/jpeg"];
    if (smallestIcon != nil) {
        NSString *iconUrl = [upnpDevice absoluteIconUrl:smallestIcon];
        //NSLog(@"iconUrl = %@", iconUrl);
        if (0 < [iconUrl length]) {
            //NSLog(@"getIconImage = %@" , iconUrl);
            NSURL *url = [NSURL URLWithString:iconUrl];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *iconImage = [[UIImage alloc] initWithData:data];
            if (iconImage != nil) {
                iamgeView.image = iconImage;
            }
                
        }
    }

    
    
}
    

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DeviceManViewController * vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DeviceManViewController"];
    vc.render = self.findDevices[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark delegate

- (void)controlPoint:(CGUpnpControlPoint *)controlPoint deviceAdded:(NSString *)deviceUdn {
    NSLog(@"%s:::%zd::::%@", __func__, __LINE__, deviceUdn);
    CGUpnpAvController * avcontroller = (CGUpnpAvController *)controlPoint;
    if([[avcontroller renderers] count] > 0) {
        self.findDevices = [avcontroller renderers];
        [self.tableView reloadData];
    }
    
    [self log:(CGUpnpAvController *)controlPoint];
    
}

- (void)controlPoint:(CGUpnpControlPoint *)controlPoint deviceUpdated:(NSString *)deviceUdn {
    NSLog(@"%s:::%zd::::%@", __func__, __LINE__, deviceUdn);
    
    [self log:(CGUpnpAvController *)controlPoint];
}

- (void)controlPoint:(CGUpnpControlPoint *)controlPoint deviceRemoved:(NSString *)deviceUdn {
    NSLog(@"%s:::%zd::::%@", __func__, __LINE__, deviceUdn);
    
    [self log:(CGUpnpAvController *)controlPoint];
}

- (void)controlPoint:(CGUpnpControlPoint *)controlPoint deviceInvalid:(NSString *)deviceUdn {
    NSLog(@"%s:::%zd::::%@", __func__, __LINE__, deviceUdn);

    
    [self log:(CGUpnpAvController *)controlPoint];
}

- (void)log:(CGUpnpAvController *)controller {
    NSLog(@"///////////////////////");
    NSLog(@"%@", controller.renderers);
    NSLog(@"-------------next----------");
}

@end

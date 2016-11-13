//
//  DetailViewController.m
//  DLNASample
//
//  Created by 健司 古山 on 12/05/06.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import <Clinkc/CGUpnpDevice.h>

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize detailItem = _detailItem;
@synthesize render = _render;
@synthesize ipAddressLable = ipAddressLabel_;
- (void)dealloc
{
    [_detailItem release];
    [_render release];
    [super dealloc];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [_detailItem release]; 
        _detailItem = [newDetailItem retain]; 

        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        //self.detailDescriptionLabel.text = [self.detailItem description];
        [(CGUpnpDevice*)(self.detailItem) friendlyName];
        self.ipAddressLable.text = [(CGUpnpDevice*)(self.detailItem) ipaddress];
#if 0
        ((CGUpnpAvServer*)self.detailItem).delegate = self;
        [(CGUpnpAvServer*)self.detailItem browse:@"0" browseFlag:@"browseMetaData" options:nil];
#endif
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.ipAddressLable = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x, self.view.center.y -10, 120, 20)];
    [self.view addSubview:self.ipAddressLable];
    [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}
- (void)upnpAvServer:(CGUpnpAvServer *)upnpAvServer browse:(CGUpnpAction *)browseAction avObject:(CGUpnpAvObject *)avObject{
    NSLog(@"Delegate");
}

- (IBAction)startClick:(id)sender {
    [self.render setAVTransportURI:@"http://vssauth.waqu.com/aznzlsgyrtqq56nc/normal.mp4?auth_key=1478769728-0-0-d7665fa51c4fdd276ff6bc5cb7c01630"];
}

- (IBAction)playClick:(id)sender {
    if([self.render play]) {
        
    } else {
    
    }
}

- (IBAction)pauseClick:(id)sender {
    [self.render pause];
}

- (IBAction)seekClick:(id)sender {
    [self.render seek:300000];
}

- (IBAction)stopClick:(id)sender {
    [self.render stop];
}

@end

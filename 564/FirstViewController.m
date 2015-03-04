//
//  FirstViewController.m
//  564
//
//  Created by ivt bqfj on 15/1/5.
//  Copyright (c) 2015年 ivt bqfj. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import "FirstViewController.h"

@interface FirstViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *layer;

@property (nonatomic, strong) AVCaptureSession *session;

@property (nonatomic, strong) AVCaptureDevice *device;


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setUpCamera];
    [self.session startRunning];
}


//- (void)setUpCamere{
//    
//    AVCaptureSession *session = [[AVCaptureSession alloc] init];
//    self.session = session;
//    self.session.sessionPreset = AVCaptureSessionPresetHigh;
//    
//    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    self.device = device;
//    
//    NSError *error = nil;
//    
//    AVCaptureDeviceInput *inPut = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
//    if (error) {
//        NSLog(@"%@",error.description);
//        return;
//    }
//    
//    if ([self.session canAddInput:inPut]) {
//        [self.session addInput:inPut];
//    }
//    
//    self.layer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
//    self.layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
//    self.layer.frame = CGRectMake(20, 150, [UIScreen mainScreen].bounds.size.width - 40, 280);
//    [self.view.layer insertSublayer:self.layer atIndex:0];
//    
//    AVCaptureMetadataOutput *outPut = [[AVCaptureMetadataOutput alloc] init];
//    [outPut setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
//    
//    if ([self.session canAddOutput:outPut]) {
//        [self.session canAddOutput:outPut];
//        outPut.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
//    }
//    
//    [self.session startRunning];
//    
//}

//-(void)setUpCamera{
//    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
//    AVCaptureMetadataOutput *outPut = [[AVCaptureMetadataOutput alloc]init];
//    outPut.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
//    [outPut setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
//    self.session = [[AVCaptureSession alloc]init];
//    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
//    if ([self.session canAddInput:input])
//    {
//        [self.session addInput:input];
//    }
//    if ([self.session canAddOutput:outPut])
//    {
//        [self.session addOutput:outPut];
//    }
//    self.layer =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
//    self.layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
//    self.layer.frame =CGRectMake(20,110,280,280);
//    [self.view.layer insertSublayer:self.layer atIndex:0];
//    [self.session startRunning];
//}
-(void)setUpCamera{
    
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    AVCaptureMetadataOutput *outPut = [[AVCaptureMetadataOutput alloc]init];
    // self.outPut.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    // self.outPut.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    [outPut setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    self.session = [[AVCaptureSession alloc]init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([self.session canAddInput:input])
    {
        [self.session addInput:input];
    }
    if ([self.session canAddOutput:outPut])
    {
        [self.session addOutput:outPut];
    }
    outPut.metadataObjectTypes = [NSArray arrayWithObject:AVMetadataObjectTypeQRCode];
    self.layer =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.layer.frame =CGRectMake(20,110,280,280);
    [self.view.layer insertSublayer:self.layer atIndex:0];
    [self.session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    NSString *stringValue = nil;
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects[0];
        stringValue = metadataObject.stringValue;
    }
    
    [self.session stopRunning];
    NSLog(@"%@",stringValue);
    NSString *str = [NSString stringWithFormat:@"扫到的二维码为：%@",stringValue];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"二维码" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}


@end

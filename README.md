# -(void)setUpCamera{
    
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

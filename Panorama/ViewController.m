//
//  ViewController.m
//  Panorama
//
//  Created by Chen on 8/24/13.
//  Copyright (c) 2017 Chen Zhaiyu. All Rights Reserved.
//
#import "MainController.h"
#import "ViewController.h"
#import "PanoramaView.h"


@interface ViewController (){
	PanoramaView *panoramaView;
}
@end

extern NSInteger sceneSelected;

@implementation ViewController


- (void)viewDidLoad{
	[super viewDidLoad];
    [NSThread sleepForTimeInterval:0.0];
    // [self.navigationController  setToolbarHidden:NO animated:YES];
	panoramaView = [[PanoramaView alloc] init];
    
    // TODO: 设置不同的浏览场景
    switch (sceneSelected){
        case 1:
            [panoramaView setImageWithName:@"building_18.jpg"];
            break;
        case 2:
            [panoramaView setImageWithName:@"park_2048.jpg"];
            break;
        case 3:
            [panoramaView setImageWithName:@"lab.jpg"];
            break;
        case 4:
            [panoramaView setImageWithName:@"cinema.jpg"];
            break;
        default:
            [panoramaView setImageWithName:@"building_18.jpg"];
            break;
    }
    // [self.navigationController  setToolbarHidden:NO animated:YES];
    [panoramaView setOrientToDevice:YES];
	[panoramaView setTouchToPan:YES];
	[panoramaView setPinchToZoom:YES];
	[panoramaView setShowTouches:YES];
	[panoramaView setVRMode:NO];
	[self setView:panoramaView];
    
    // button不显示的原因可能是backgroundColoe设置为clearColor且未setTitle
    /*
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(90, 90, 51, 24);
    [self.view addSubview:button];
    */
    
    // 创建button
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(15, 15, 100, 40);     // GCRectMake参数：x坐标，y坐标，宽度，高度
    btn.backgroundColor=[UIColor lightGrayColor];
    [btn setTitle:@"back test" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonClicked:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    // self->labeltest.text = @"indicator";
    // [self.view addSubview:self->labeltest];
}

// button响应函数
-(void) buttonClicked:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"test message" message:@"back button clicked" delegate:self cancelButtonTitle:@"test OK" otherButtonTitles: nil];
    [alert show];
    
    // 实现界面跳转
    /*
    MainController *mainController = [[MainController alloc] init];
    [self presentModalViewController:mainController animated:YES];
    ViewController *viewController = [[ViewController alloc] init];
    [self presentModalViewController:viewController animated:YES];
     */
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) glkView:(GLKView *)view drawInRect:(CGRect)rect{
	[panoramaView draw];
}




// uncomment everything below to make a VR-Mode switching button


-(void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	CGFloat PAD = 15.0;
	UIButton *VRButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
	[VRButton setTransform:CGAffineTransformMakeRotation(M_PI*0.5)];
    [VRButton setCenter:CGPointMake(VRButton.frame.size.width*0.5 + PAD,
									self.view.bounds.size.height - VRButton.frame.size.height*0.5 - PAD)];
	[VRButton setImage:[UIImage imageNamed:@"button-screen-double"] forState:UIControlStateNormal];
	[VRButton setAlpha:0.5];
	[VRButton addTarget:self action:@selector(vrButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:VRButton];
}
-(void) vrButtonHandler:(UIButton*)sender{
	[panoramaView setVRMode:!panoramaView.VRMode];
	if(panoramaView.VRMode){
		[sender setImage:[UIImage imageNamed:@"button-screen-single"] forState:UIControlStateNormal];
	}else{
		[sender setImage:[UIImage imageNamed:@"button-screen-double"] forState:UIControlStateNormal];
	}
}


@end

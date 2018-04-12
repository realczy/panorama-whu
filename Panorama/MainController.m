//
//  MainController.m
//  Panorama
//
//  Created by Chen on 16/08/2017.
//  Copyright © 2017 Chen Zhaiyu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MainController.h"
// import delegate to switch views
#import "AppDelegate.h"
#import "ViewController.h"

@interface MainController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong)NSArray *pickerData;
@property (nonatomic, strong) IBOutlet UILabel *label;
@property (nonatomic, strong) IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong) AVAudioPlayer *player;
@end

// isLaunch标致判断MainController是否启动界面
bool isLaunched = FALSE;
NSInteger sceneSelected = 0;
NSInteger count = 1;

@implementation MainController
// write functions here

/*
-(NSArray *)pickerData
{
    if (_pickerData == nil) {
        _pickerData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"picker.plist" ofType:nil]];
    }
    return _pickerData;
}
*/

// 按钮操作
- (IBAction)panoButtonDown:(id)sender {
    // 跳转到pano场景
    // TODO: 每次都会新分配内存?
    ViewController *viewController = [[ViewController alloc] init];
    [self presentModalViewController:viewController animated:YES];
}

- (IBAction)infoButtonDown:(id)sender {
    // 跳转到info场景
    
}

/*
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor cyanColor];
}
*/

- (void)viewDidLoad{
    [super viewDidLoad];
    
    // 获取需要展示的数据
    [self loadData];
    
    // 延时launchscreen
    if (isLaunched == FALSE){
        [NSThread sleepForTimeInterval: 1.5];    // set launchscreen delay time
    }
    isLaunched = TRUE;
    
    // 初始化pickerView
    // self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 400)];
    // [self.view addSubview:self.pickerView];
    
    // 指定数据源和委托
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    // 指定初始label值
    // [self.view addSubview:self.label];
    // self.label.text = self.pickerData[0];
    // UILabel* label=[[UILabel alloc]init];
    // self.label.frame=CGRectMake(100, 50, 200, 100);
    // self.label.text=@"我是label";
    // [self.view addSubview:_label];
    // CGRect rect = CGRectMake(100, 200, 50, 50);
    // self.label = [[UILabel alloc] initWithFrame:rect];
    // [self.view addSubview:self.label];
    self.label.text = @"I am an indicator🤦🏻‍♂️";
}

// 加载数据
-(void)loadData
{
    // 需要展示的数据以数组的形式保存
    // TODO: 读取图像文件名会更灵活
    self.pickerData = @[@"scene-1st",@"scene-2nd",@"scene-3rd",@"scene-4th"];
}

// 数据源方法
// 指定pickView表盘数目
// 返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    // return self.pickerData.count;
    return 1;
}

// 返回多少行，指定每个表盘上有几行数据
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger rows = 0;
    rows = self.pickerData.count;
    return rows;
}

// 代理方法
// 返回每行的标题，指定每行如何显示数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = nil;
    title = self.pickerData[row];
    // self.label.text = title;
    return title;
}

// 选中的行显示在label上，保存选中行到变量sceneSelected
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSArray *items = self.pickerData;
    self.label.text = items[row];
    sceneSelected = row + 1;
    
}

-(AVAudioPlayer *)player{
    if (!_player) {
        //1.创建音乐路径
        NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:@"Iwillstandbyyou" ofType:@"mp3"];
        NSURL *musicURL = [[NSURL alloc]initFileURLWithPath:musicFilePath];
        
        //2.创建播放器
        _player = [[AVAudioPlayer alloc]initWithContentsOfURL:musicURL error:nil];
        
    }
    return _player;
}

// TODO: 开闭变量没有加进去，加count就报错
- (IBAction)playSwitch:(id)sender {
    count++;
    if (count % 2 == 0){
    //预播放
    [self.player prepareToPlay];
    //设置播放次数.-1为循环播放
    self.player.numberOfLoops = -1;
    //开始播放
    [self.player play];
    }
    
    if(count%2 == 1){
        [self.player stop];
    }
    
}


/*下面有count的编译通不过
- (IBAction)playMusic:(UISwitch *)sender {
    count ++;
    if (count % 2 == 0){
        //3.预播放
        [self.player prepareToPlay];
        //4.设置播放次数.-1为循环播放
        self.player.numberOfLoops = -1;
        //5.开始播放
        [self.player play];
    }
    if(count%2 == 1){
        [self.player stop];
    }
}
*/

@end




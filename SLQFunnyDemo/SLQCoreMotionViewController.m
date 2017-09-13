//
//  SLQCoreMotionViewController.m
//  SLQFunnyDemo
//
//  Created by song on 2017/7/20.
//  Copyright © 2017年 song. All rights reserved.
//

#import "SLQCoreMotionViewController.h"
#import <CoreMotion/CoreMotion.h>  
#import "SLQPrecompile.h"
#import <CoreLocation/CoreLocation.h>
@interface SLQCoreMotionViewController ()<CLLocationManagerDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)CLLocationManager *locMgr;
///
@property (nonatomic, strong) CMMotionManager *motionManager;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextView *textView2;
@property (weak, nonatomic) IBOutlet UITextView *textView3;
/// <#模型数组#>
@property (nonatomic, strong) NSMutableString *address;


@end

@implementation SLQCoreMotionViewController
+ (void )initialize {
    [super initialize];
    NSLog(@"SLQCoreMotionViewController-initialize");
}
+ (void)load {
    [super load];
    NSLog(@"SLQCoreMotionViewController-load");
}
+ (instancetype)alloc {
    
    NSLog(@"SLQCoreMotionViewController-alloc");
    return [super alloc];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.address = [NSMutableString string];
    self.title = @"陀螺仪and加速剂";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.motionManager = [[CMMotionManager alloc]init];
    self.motionManager.deviceMotionUpdateInterval = 0.5;
    self.motionManager.gyroUpdateInterval = 0.2;
    self.motionManager.accelerometerUpdateInterval = 0.2;
    
    __weak typeof (self) weakSelf = self;
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [self.motionManager startDeviceMotionUpdatesToQueue:queue withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
//        NSLog(@"%@",motion);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            weakSelf.textView.text = [NSString stringWithFormat:@"DeviceMotion\n%@",motion];
        });
        // 四元组 Quaternion xyzw
        // 加速剂 UserAccel xyz
        // 旋转速度 RotationRate xyz
        // 磁场 MagneticField xyz
        // MagneticFieldAccuracy 磁场精确度
        
        //         NSLog(@"磁力计：x:%f y:%f z:%f",motion.magneticField.x,motion.magneticField.y,motion.magneticField.z);
    }];
//    [self.motionManager startGyroUpdatesToQueue:queue withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
//       NSLog(@"旋转：x:%f y:%f z:%f",gyroData.rotationRate.x,gyroData.rotationRate.y,gyroData.rotationRate.z);
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            
//            weakSelf.textView2.text = [NSString stringWithFormat:@"旋转\n%@",gyroData];
//        });
//    }];
    
//    [self.motionManager startMagnetometerUpdatesToQueue:queue withHandler:^(CMMagnetometerData * _Nullable magnetometerData, NSError * _Nullable error) {
//         NSLog(@"磁力计：x:%f y:%f z:%f",magnetometerData.magneticField.x,magnetometerData.magneticField.y,magnetometerData.magneticField.z);
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            
//            weakSelf.textView2.text = [NSString stringWithFormat:@"磁力\n%@",magnetometerData];
//        });
//    }];
    [self.motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
//        NSLog(@"加速度：%@",accelerometerData);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            weakSelf.textView3.text = [NSString stringWithFormat:@"加速度\n%@",accelerometerData];
        });
    }];
//

    //判断用户定位服务是否开启
    if ([CLLocationManager locationServicesEnabled]) {
        //开始定位用户的位置
        [self.locMgr startUpdatingLocation];
        //每隔多少米定位一次（这里的设置为任何的移动）
        self.locMgr.distanceFilter=kCLDistanceFilterNone;
        //设置定位的精准度，一般精准度越高，越耗电（这里设置为精准度最高的，适用于导航应用）
        self.locMgr.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
    }else
    {//不能定位用户的位置
        //1.提醒用户检查当前的网络状况
        //2.提醒用户打开定位开关
    }
    
    //测试方法，计算两个位置之间的距离
    [self countDistance];
}
#pragma mark-CLLocationManagerDelegate
/**
 *  当定位到用户的位置时，就会调用（调用的频率比较频繁）
 */
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //locations数组里边存放的是CLLocation对象，一个CLLocation对象就代表着一个位置
    CLLocation *loc = [locations firstObject];
    
    //维度：loc.coordinate.latitude
    //经度：loc.coordinate.longitude

    __weak typeof (self) weakSelf = self;

//    // 经纬度写入文件
//    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
//    // 取得文件的全路径
//    NSString *filePath1 = [cachePath stringByAppendingPathComponent:@"address.txt"];
//    NSString *result = [NSString stringWithFormat:@"%f,%f",loc.coordinate.latitude,loc.coordinate.longitude];
//    [self.address appendFormat:@"%@;\n%@", result,self.address];
//    
//    if (![self.address writeToFile:filePath1 atomically:YES]) {
//        NSLog(@"写入失败");
//    }else {
//        NSLog(@"写入成功");
//    }
    self.address = [NSString stringWithFormat:@"纬度=%f\n经度=%f\n速度=%f\n朝向=%f",loc.coordinate.latitude,loc.coordinate.longitude,loc.speed,loc.course];
    NSLog(@"%@",self.address);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        weakSelf.textView2.text = self.address;
    });
    
}

- (void)saveList
{
    NSMutableDictionary *temp = [NSMutableDictionary dictionary];
    // 获取cache路径
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    // 取得文件的全路径
    NSString *filePath1 = [cachePath stringByAppendingPathComponent:@"11.txt"];
    [temp writeToFile:filePath1 atomically:YES];
}

//计算两个位置之间的距离
-(void)countDistance
{
    //根据经纬度创建两个位置对象
    CLLocation *loc1=[[CLLocation alloc]initWithLatitude:40 longitude:116];
    CLLocation *loc2=[[CLLocation alloc]initWithLatitude:41 longitude:116];
    //计算两个位置之间的距离
    CLLocationDistance distance=[loc1 distanceFromLocation:loc2];
    NSLog(@"(%@)和(%@)的距离=%fM",loc1,loc2,distance);
}

#pragma mark-懒加载
-(CLLocationManager *)locMgr
{
    if (_locMgr==nil) {
        //1.创建位置管理器（定位用户的位置）
        self.locMgr=[[CLLocationManager alloc]init];
        //2.设置代理
        self.locMgr.delegate=self;
    }
    return _locMgr;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

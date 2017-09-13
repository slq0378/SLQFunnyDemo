//
//  SLQAddressViewController.m
//  SLQFunnyDemo
//
//  Created by song on 2017/8/18.
//  Copyright © 2017年 song. All rights reserved.
//

#import "SLQAddressViewController.h"
#import "SLQPrecompile.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface SLQAddressViewController ()<CLLocationManagerDelegate>
@property(nonatomic,strong)CLLocationManager *locMgr;
/// 上一次位置
@property (nonatomic, strong) CLLocation *preLocation;
@property (nonatomic, assign) double preSpeed;

//@property(nonatomic,strong)MKMapView *mapView;
///
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation SLQAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    //判断用户定位服务是否开启
    if ([CLLocationManager locationServicesEnabled]) {
        //开始定位用户的位置
        self.locMgr = [[CLLocationManager alloc] init];
        self.locMgr.delegate = self;
        [self.locMgr startUpdatingHeading];
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
    
//    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.textView.frame), ScreenWidth, ScreenHeight - CGRectGetMaxY(self.textView.frame))];
//    [self.view addSubview:self.mapView];

}

#pragma mark-CLLocationManagerDelegate
// 当用户位置发生改变时，触发这个方法
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    if (self.preLocation && newLocation) {
        NSLog(@"Pre:%f,%f,Now:%f,%f",self.preLocation.coordinate.longitude,self.preLocation.coordinate.latitude,newLocation.coordinate.longitude,newLocation.coordinate.latitude);
        // 1计算距离
        CLLocationDistance distance = [self.preLocation distanceFromLocation:newLocation];
        NSLog(@"distence:%lfm",distance);
        // 2计算时间间隔
        NSTimeInterval time = [newLocation.timestamp timeIntervalSinceDate:self.preLocation.timestamp];
        NSLog(@"time:%Lfs",fabsl(time));
        // 3计算速度
        double speed = (distance) / (fabsl(time));
        NSLog(@"speed:%lf m/s",speed);
        if(self.preSpeed < 0.0000001) { // 第一次进入
            if (speed > 100) { // 一开始速度不可能是100m/s
                self.preSpeed = 0.0;
            }else {
                self.preSpeed = speed;
            }
        }
        else { // 第二次进入
            // 判断当前speed是不是和上一次速度preSpeed差距过大，如果差距过大，则认为当前速度无效
            if((self.preSpeed * 10 < speed) || self.preSpeed / 10 > speed) {

            }else {
                self.preSpeed = speed;
            }
        }
        self.textView.text = [NSString stringWithFormat:@"Pre  :%f,%f\nNow:%f,%f\n距离：%lf m\n时间：%Lf s\n速度：%lf m/s\n",self.preLocation.coordinate.longitude,self.preLocation.coordinate.latitude,newLocation.coordinate.longitude,newLocation.coordinate.latitude,distance,fabsl(time),self.preSpeed];
    }
    self.preLocation = newLocation;
    
    
}
/**
 *  当定位到用户的位置时，就会调用（调用的频率比较频繁）
 */
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //locations数组里边存放的是CLLocation对象，一个CLLocation对象就代表着一个位置
    CLLocation *loc = [locations lastObject];
    
    //维度：loc.coordinate.latitude
    //经度：loc.coordinate.longitude
    NSLog(@"纬度=%f，经度=%f,速度=%f",loc.coordinate.latitude,loc.coordinate.longitude,loc.speed);
    NSLog(@"%lu",(unsigned long)locations.count);
    __weak typeof (self) weakSelf = self;
    if (self.preLocation && loc) {
        NSLog(@"Pre:%f,%f,Now:%f,%f",self.preLocation.coordinate.longitude,self.preLocation.coordinate.latitude,loc.coordinate.longitude,loc.coordinate.latitude);
        // 1计算距离
        CLLocationDistance distance = [self.preLocation distanceFromLocation:loc];
        NSLog(@"distence:%lfm",distance);
        // 2计算时间间隔
        NSTimeInterval time = [loc.timestamp timeIntervalSinceDate:self.preLocation.timestamp];
        NSLog(@"time:%Lfs",fabsl(time));
        // 3计算速度
        double speed = (distance) / (fabsl(time));
        NSLog(@"speed:%lf m/s",speed);
        self.textView.text = [NSString stringWithFormat:@"Pre  :%f,%f\nNow:%f,%f\n距离：%lf m\n时间：%Lf s\n速度：%lf m/s\n",self.preLocation.coordinate.longitude,self.preLocation.coordinate.latitude,loc.coordinate.longitude,loc.coordinate.latitude,distance,fabsl(time),speed];
    }
    self.preLocation = loc;
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
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        weakSelf.textView.text = [NSString stringWithFormat:@"纬度=%f，经度=%f,速度=%f",loc.coordinate.latitude,loc.coordinate.longitude,loc.speed];
//        [weakSelf.textView scrollRectToVisible:CGRectMake(0, weakSelf.textView.contentSize.height-15, weakSelf.textView.contentSize.width, 10) animated:YES];
//    });
    //停止更新位置（如果定位服务不需要实时更新的话，那么应该停止位置的更新）
    //    [self.locMgr stopUpdatingLocation];
    
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

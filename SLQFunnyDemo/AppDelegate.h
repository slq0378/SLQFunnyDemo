//
//  AppDelegate.h
//  SLQFunnyDemo
//
//  Created by MrSong on 17/3/3.
//  Copyright © 2017年 song. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end


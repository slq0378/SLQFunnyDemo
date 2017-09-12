//
//  SLQPrecompile.h
//
//
//  Created by MrSong on 17/2/24.
//  Copyright © 2017年 Xiao. All rights reserved.

#ifndef SLQPrecompile_h
#define SLQPrecompile_h

#define WEAKSELF __weak typeof (self)weakSelf = self;

#pragma mark - 布局
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define KHeightScale (ScreenHeight/667.)
#define KWidthScale (ScreenWidth/375.)

#define FooterViewH 50
#define CellHeight 50
#define SearchViewHeight 40
#define Margin 5
#define NavigationBarHeight 64

#define DatePickerHeight 200

#define HeaderViewHeight 60

#define ViewMargin 13

#define kNHAlertViewAnimationInterval (0.01)
#define ChatAndSearchCellHeight 70  //聊天和搜索列表的cell的高度
#define RowHeight 50
#define CheckCellHeight 66

/*************颜色**************/
#define RGB_(a,b,c) [UIColor colorWithRed:a/255.0f green:b/255.0f blue:c/255.0f alpha:1]
#define RGBHEX_(a) [PublicMethod RGBColor:@#a]
#define COLOR_WHITE_ [UIColor whiteColor]
#define COLOR_BLACK_ [UIColor blackColor]
#define COLOR_CLEAR_ [UIColor clearColor]
#define BaseViewColor RGB_(242, 242, 242)
#define NaviColor RGBHEX_(#296580)
#define mainBackColor RGB_(238, 237, 237)

/*************字体**************/
#define SysFont_(a) [UIFont systemFontOfSize:a]

/*************系统版本**************/
#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define SystemVersion [[UIDevice currentDevice].systemVersion floatValue]

/*************屏幕尺寸**************/
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define STATUSHEIGHT  (IOS7_OR_LATER?20:0)
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
//#define START_Y (([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) ? 64 : 44)
#define START_Y (IOS7_OR_LATER?64:44)

/*************TAG**************/
#define tagStart 10000


#pragma mark - 颜色
#define ViewControllerBackgroundColor [UIColor whiteColor]
#ifndef RGBACOLOR
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]
#endif

#ifndef UIColorFromRGB
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#endif

#ifndef UIColorFromRGBA
#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#endif

#ifndef GREENCOLOR
#define GREENCOLOR [UIColor colorWithRed:(37)/255.0f green:(155)/255.0f blue:(36)/255.0f alpha:1]
#endif

//颜色
#ifndef RGBCOLOR
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#endif

#ifndef RGBACOLOR
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]
#endif

#ifndef UIColorFromRGB
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#endif

#ifndef GREENCOLOR
#define GREENCOLOR [UIColor colorWithRed:(37)/255.0f green:(155)/255.0f blue:(36)/255.0f alpha:1]
#endif

#ifndef BLACKCOLOR
#define BLACKCOLOR [UIColor colorWithRed:(33)/255.0f green:(33)/255.0f blue:(33)/255.0f alpha:1]
#endif

#ifndef TextFieldColor
#define TextFieldColor UIColorFromRGB(0x69c113)
#endif
#ifndef TextFieldPlaceHolderColor
#define TextFieldPlaceHolderColor UIColorFromRGB(0x888888)
#endif

#ifndef TextFieldPlaceHolderSelectedColor
#define TextFieldPlaceHolderSelectedColor UIColorFromRGB(0x888888)
#endif

#ifndef TextFieldDisableColor
#define TextFieldDisableColor UIColorFromRGB(0x666666)
#endif

#ifndef TitleColor
#define TitleColor UIColorFromRGB(0x333333)
#endif

#ifndef LineColor
#define LineColor UIColorFromRGB(0xebebeb)
#endif

#ifndef ViewBGColor
#define ViewBGColor [UIColor whiteColor]
#endif

#ifndef NavigationTitleColor
#define NavigationTitleColor UIColorFromRGB(0xffffff)
#endif

#ifndef ButtonGreenColor
#define ButtonGreenColor UIColorFromRGB(0x3CB711)
#endif

#ifndef ButtonHighlightGreenColor
#define ButtonHighlightGreenColor UIColorFromRGB(0x35A10F)
#endif
#ifndef ButtonRedColor
#define ButtonRedColor UIColorFromRGB(0xE04040)
#endif
#ifndef ButtonHighlightRedColor
#define ButtonHighlightRedColor UIColorFromRGB(0xCF3333)
#endif
#ifndef ButtonDisableColor
#define ButtonDisableColor UIColorFromRGB(0xCACACA)
#endif

#pragma mark - 字体
#ifndef TextFieldFontSize
#define TextFieldFontSize (ScreenHeight>=667?16:14)
#endif
#ifndef TextFieldTitleFontSize
#define TextFieldTitleFontSize (ScreenHeight>=667?16:14)
#endif
#ifndef NavigationTitleFontSize
#define NavigationTitleFontSize (ScreenHeight>=667?17:14)
#endif
#ifndef NavigationOtherTitleFontSize
#define NavigationOtherTitleFontSize (ScreenHeight>=667?17:14)
#endif

//字体
#define ButtonFontSize (ScreenHeight>=667?16:14)
#define labelFoneSize (ScreenHeight>=667?16:14)
#define FontSize (ScreenHeight>=667?16:15)
/*************字体**************/
#define SysFont_(a) [UIFont systemFontOfSize:a]
#define GetDefaultFontSize [UIFont systemFontOfSize:14]


#endif /* SLQPrecompile_h */

//
//  UpdateCheckingViewController.m
//  LeXiang100 Agent
//
//  Created by 任魏翔 on 14-7-4.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "UpdateCheckingViewController.h"


#define viewWidth   self.view.frame.size.width
#define viewHeight  self.view.frame.size.height

@interface UpdateCheckingViewController ()

@end
@implementation UpdateCheckingViewController

extern ConnectionAPI * soap;
extern NSNotificationCenter *nc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
        [nc addObserver:self selector:@selector(queryVersionFeedback:) name:@"queryVersionInfo" object:nil];

        self.title = @"检查更新";
        self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        
        //解决ios7界面上移  配色等问题
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars =NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
            self.navigationController.navigationBar.translucent = NO;
            self.view.backgroundColor = [UIColor whiteColor];
        }
        
        UIScrollView *scrollview=[[[UIScrollView alloc] initWithFrame:self.view.frame]autorelease];
        scrollview.contentSize=CGSizeMake(viewWidth, viewHeight*1.1);
        scrollview.showsHorizontalScrollIndicator=FALSE;
        scrollview.showsVerticalScrollIndicator=TRUE;
        UITextView * background = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
        background.editable=NO;
        //[self.view addSubview:background];
        
        
        UIFont *font1 = [UIFont fontWithName:@"Arial" size:viewHeight/47];
        UIFont *font2=[UIFont fontWithName:@"Arial" size:viewHeight/35];
        UIColor *myColorRGB = [ UIColor colorWithRed: 0.75
                                               green: 0.75
                                                blue: 0.75
                                               alpha: 1.0
                               ];
        
        //乐享图标自助办理
        UIImage * Image = [UIImage imageNamed:@"lx100.png"];
        UIImageView * imgView = [[UIImageView alloc]initWithImage:Image];
        imgView.frame = CGRectMake(viewWidth/2-viewWidth/8, viewHeight/10, viewWidth/4, viewWidth/4);
        
        [self.view addSubview:imgView];
        
        //乐享100
        UILabel * Lexiang100 = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/2-viewWidth/10, viewHeight/8, viewWidth/2, viewHeight/20)];
        Lexiang100.text = @"乐享100代理商版";
        Lexiang100.font=font2;
        Lexiang100.center=CGPointMake(viewWidth/2, viewHeight/3.5);
        Lexiang100.backgroundColor = [UIColor clearColor];
        Lexiang100.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:Lexiang100];
        
        //版本号标题
        UILabel * version = [[[UILabel alloc]initWithFrame:CGRectMake(viewWidth/2-viewWidth/7+viewWidth/60, viewHeight/6-viewHeight/80+viewHeight/40, viewWidth/3, viewHeight/20)]autorelease];
        version.text = @"版 本 号：1.0.0";
        version.font=font1;
        version.center=CGPointMake(viewWidth/2, viewHeight/3);
        version.textAlignment = NSTextAlignmentCenter;
        version.backgroundColor = [UIColor clearColor];
        [self.view addSubview:version];
        
        //检查更新按钮
        UIButton *updateButton=[[[UIButton alloc] initWithFrame:CGRectMake(viewWidth/3+viewWidth/70, viewHeight/3, viewWidth/4, viewHeight/20)]autorelease];
        updateButton.backgroundColor=myColorRGB;
        updateButton.center=CGPointMake(viewWidth/2, viewHeight/2.5);
        updateButton.backgroundColor = [UIColor colorWithRed:0.27f green:0.85f blue:0.46f alpha:1.0f];
        [updateButton setTitle:@"检查更新" forState:UIControlStateNormal];
        [updateButton addTarget:self action:@selector(updateCheck:) forControlEvents:UIControlEventTouchUpInside];//添加点击按钮执行的方法
        [self.view addSubview:updateButton];
        
        //乐享版权标题
        UILabel *  copyright= [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/5, viewHeight/4+viewHeight/10, viewWidth/3, viewHeight/20)];
        copyright.text = @"乐享100 版权所有";
        copyright.font=font1;
        copyright.center=CGPointMake(viewWidth/2, viewHeight/2);
        copyright.textAlignment = NSTextAlignmentCenter;
        copyright.backgroundColor = [UIColor clearColor];
        [self.view addSubview:copyright];
        
        //乐享版权
        UILabel *  copyright_c= [[[UILabel alloc]initWithFrame:CGRectMake(viewWidth/5, viewHeight/4+viewHeight/5, viewWidth, viewHeight/20)]autorelease];
        copyright_c.center = CGPointMake(viewWidth/2, viewHeight/1.8);
        copyright_c.text = @"Copyright© 2010 乐享100.All Right Rreserved.";
        copyright_c.font=font1;
        copyright_c.backgroundColor = [UIColor clearColor];
        copyright_c.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:copyright_c];
        
        //设备是iPad时
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
            imgView.frame = CGRectMake(viewWidth/2-viewWidth/12, viewHeight/10, viewWidth/6, viewWidth/6);
        }


    }
    return self;
}
#pragma mark soapFeedback

- (void)queryVersionFeedback:(NSNotification *)note{
    
    NSDictionary * phoneUpdateCfg =[[[note userInfo]objectForKey:@"1"] objectForKey:@"phoneUpdateCfg"];
    NSLog(@"%@",phoneUpdateCfg);
  
    if ([[phoneUpdateCfg objectForKey:@"releaseType"] intValue] == 1) {
        [ConnectionAPI showAlertWithTitle:@"提示信息" AndMessages:@"软件有更新，请到App Store下载最新版本！"];
        
          }
    
    if ([[phoneUpdateCfg objectForKey:@"releaseType"] intValue] == 2) {
      //  [ConnectionAPI showAlertWithTitle:@"提示信息" AndMessages:@"数据有更新，现在是否更新数据信息？"];
        
        [ConnectionAPI showAlertWithTitle:@"提示信息" AndMessages:@"数据更新成功！"];
        
        NSString * dataVersion;
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYYMMddhhmmss"];
        dataVersion = [formatter stringFromDate:[NSDate date]];
        [phoneUpdateCfg setValue:dataVersion forKey:@"dataVersion"];
        
        NSLog(@"%@", dataVersion);
        NSLog(@"%@==", [phoneUpdateCfg objectForKey:@"dataVersion"]);
        NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:phoneUpdateCfg,@"phoneUpdateCfg", nil];
        
        [dic writeToFile:[self documentsPath:@"version.txt"] atomically:YES];
        
        
     

    }
    
}
#pragma mark ButtonClick

-(void)updateCheck:(id)sender {
    NSDictionary * dic = [self readFileDic];
    NSDictionary * phoneUpdateCfg = [dic objectForKey:@"phoneUpdateCfg"];
    NSString * versionCode = [phoneUpdateCfg objectForKey:@"versionCode"];
     NSString * dataVersion = [phoneUpdateCfg objectForKey:@"dataVersion"];
    NSString * appName = [phoneUpdateCfg objectForKey:@"appName"];
    
    NSLog(@"%@===%@===%@",versionCode,dataVersion, appName );
    [soap queryVersionInfoWithInterface:@"queryVersionInfo" Parameter1:@"clientVersion" ClientVersion:versionCode Parameter2:@"dataVersion" DataVersion:dataVersion Parameter3:@"appName" AppName:appName];
    
}

#pragma mark readfile

-(NSDictionary *)readFileDic
{
    NSLog(@"To Read Vsersion Data........\n");
    //filePath 表示程序目录下指定文件
    NSString *filePath = [self documentsPath:@"version.txt"];
    //从filePath 这个指定的文件里读
    NSDictionary * collectBusiArray = [NSDictionary dictionaryWithContentsOfFile:filePath];//[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];//[NSArray arrayWithContentsOfFile:filePath];
    //NSLog(@"%@",[collectBusiArray objectAtIndex:0] );
    return collectBusiArray;
    return collectBusiArray;
}

-(NSString *)documentsPath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateData{

}




@end

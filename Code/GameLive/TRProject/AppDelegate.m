
#import "AppDelegate.h"
#import "NetManager.h"
#import "LanMuCollectionViewController.h"
@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //全局默认配置
    [self setupGlobalConfig];
    
    
    UICollectionViewFlowLayout *lanMuLayout = [UICollectionViewFlowLayout new];
    lanMuLayout.minimumLineSpacing = 10;
    lanMuLayout.minimumInteritemSpacing = 10;
    lanMuLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    lanMuLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat w = lround(([UIScreen mainScreen].bounds.size.width - 40) / 3) - 1;
    //109*150
    CGFloat h = w * 150 / 109 + 30;
    lanMuLayout.itemSize = CGSizeMake(w, h);
    LanMuCollectionViewController *lanMuC = [[LanMuCollectionViewController alloc]initWithCollectionViewLayout:lanMuLayout];
    UINavigationController *naviLanMu = [[UINavigationController alloc]initWithRootViewController:lanMuC];
    
    
    
    [UINavigationBar appearance].barStyle = UIBarStyleBlack;
    [UINavigationBar appearance].barTintColor = [UIColor redColor];
    
    UITabBarController *tabC = [[UITabBarController alloc]init];
    tabC.viewControllers = @[naviLanMu];
    
    self.window.rootViewController = tabC;
    return YES;
}

@end

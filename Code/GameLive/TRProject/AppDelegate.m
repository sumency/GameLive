
#import "AppDelegate.h"
#import "NetManager.h"
#import "LanMuCollectionViewController.h"
#import "DetailLiveCollectionViewController.h"
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
    
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat w2 = lround(([UIScreen mainScreen].bounds.size.width - 30) / 2);
    //    156*100
    CGFloat h2 = w2 * 100 / 156 + 40;
    layout.itemSize = CGSizeMake(w2, h2);
    DetailLiveCollectionViewController *dvc = [[DetailLiveCollectionViewController alloc]initWithCollectionViewLayout:layout];
    UINavigationController *naviZhiBo = [[UINavigationController alloc]initWithRootViewController:dvc];
    
    
    [UINavigationBar appearance].barStyle = UIBarStyleBlack;
    [UINavigationBar appearance].barTintColor = [UIColor redColor];

    UITabBarController *tabC = [[UITabBarController alloc]init];
    tabC.viewControllers = @[naviLanMu,naviZhiBo];
    tabC.tabBar.tintColor = [UIColor colorWithRed:255/255.0 green:76/255.0 blue:52/255.0 alpha:1.0];
    self.window.rootViewController = tabC;
    return YES;
}

@end


#import "VedioViewController.h"
@import AVFoundation;
@import AVKit;
@interface VedioViewController ()

@property (nonatomic) AVPlayer *vedio;
@property (nonatomic) AVPlayerLayer *vediolayer;
@property (nonatomic) UIView *nameView;
@property (nonatomic) UILabel *nameLab;
@property (nonatomic) UILabel *titleLab;
@property (nonatomic) UIImageView *iv;
@property (nonatomic) UIButton *guanzhu;
@property (nonatomic) UIButton *fenxiang;
@property (nonatomic) UILabel *guanzhuLab;
@property (nonatomic) UILabel *fenxiangLab;

@end

@implementation VedioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
        make.height.width.equalTo(30);
    }];
    btn.backgroundColor = [UIColor redColor];
    
    [btn bk_addEventHandler:^(id sender) {
        
        AVPlayerViewController *vc = [AVPlayerViewController new];
        vc.player = [AVPlayer playerWithURL:self.url];
        [vc.player play];
//        [self.vedio pause];
        [self presentViewController:vc animated:YES completion:nil];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    //字符串转MD5:
    //    NSString *md5Str = @"lixi".md5String;
    //    NSLog(@"%@",md5Str);
    
    self.view.backgroundColor = [UIColor whiteColor];
    _vedio = [AVPlayer playerWithURL:self.url];
    _vediolayer = [AVPlayerLayer playerLayerWithPlayer:_vedio];
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    _vediolayer.frame = CGRectMake(0, 64, w, w * 232 / 413.0 );
    _vediolayer.backgroundColor = [UIColor cyanColor].CGColor;
    [self.view.layer addSublayer:_vediolayer];
    
    [_vedio play];
    [self nameView];
    
    [self iv];
    [self nameLab];
    [self titleLab];
    
    [self fenxiang];
    [self guanzhu];
    
    [self guanzhuLab];
    [self fenxiangLab];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (UIView *)nameView {
    if(_nameView == nil) {
        _nameView = [[UIView alloc] init];
        [self.view addSubview:_nameView];
        [_nameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(self.vediolayer.bottom);
            make.height.equalTo(60);
        }];
        //        _nameView.backgroundColor = [UIColor yellowColor];
    }
    return _nameView;
}

- (UILabel *)nameLab {
    if(_nameLab == nil) {
        _nameLab = [[UILabel alloc] init];
        [self.nameView addSubview:_nameLab];
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iv.mas_right).equalTo(5);
            make.top.equalTo(12);
        }];
        _nameLab.text = self.name;
        _nameLab.font = [UIFont systemFontOfSize:14];
    }
    return _nameLab;
}

- (UILabel *)titleLab {
    if(_titleLab == nil) {
        _titleLab = [[UILabel alloc] init];
        [self.nameView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iv.mas_right).equalTo(5);
            make.bottom.equalTo(-12);
        }];
        _titleLab.text = self.titleName;
        _titleLab.font = [UIFont systemFontOfSize:12];
        _titleLab.textColor = [UIColor darkGrayColor];
    }
    return _titleLab;
}

- (UIImageView *)iv {
    if(_iv == nil) {
        _iv = [[UIImageView alloc] init];
        [_nameView addSubview:_iv];
        [_iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(15);
            make.height.width.equalTo(50);
        }];
        _iv.layer.cornerRadius = 25;
        _iv.clipsToBounds = YES;
        [_iv sd_setImageWithURL:self.imgURL];
        _iv.backgroundColor = [UIColor redColor];
        _iv.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iv;
}

- (UIButton *)guanzhu {
    if(_guanzhu == nil) {
        _guanzhu = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.nameView addSubview:_guanzhu];
        [_guanzhu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(8);
            make.right.equalTo(self.fenxiang.mas_left).equalTo(-10);
            make.height.width.equalTo(30);
        }];
        [_guanzhu setImage:[UIImage imageNamed:@"gift_100.png.base.universal.regular.off.horizontal.normal.active.onepartscale.onepart.2543.000.00.@1x"] forState:UIControlStateNormal];
        _guanzhu.layer.cornerRadius = 15;
        _guanzhu.layer.masksToBounds = YES;
    }
    return _guanzhu;
}

- (UIButton *)fenxiang {
    if(_fenxiang == nil) {
        _fenxiang = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.nameView addSubview:_fenxiang];
        [_fenxiang mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(30);
            make.right.equalTo(-8);
            make.top.equalTo(8);
        }];
        UIImage *img = [UIImage imageNamed:@"fenxiang"];
        [_fenxiang setImage:img forState:UIControlStateNormal];
        _fenxiang.layer.cornerRadius = 15;
        _fenxiang.layer.masksToBounds = YES;
    }
    return _fenxiang;
}

- (UILabel *)fenxiangLab {
    if(_fenxiangLab == nil) {
        _fenxiangLab = [[UILabel alloc] init];
        [_nameView addSubview:_fenxiangLab];
        [_fenxiangLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fenxiang.mas_bottom).equalTo(2);
            make.centerX.equalTo(self.fenxiang);
        }];
        _fenxiangLab.text = @"分享";
        _fenxiangLab.textColor = [UIColor darkGrayColor];
        _fenxiangLab.font = [UIFont systemFontOfSize:10];
    }
    return _fenxiangLab;
}

- (UILabel *)guanzhuLab {
    if(_guanzhuLab == nil) {
        _guanzhuLab = [[UILabel alloc] init];
        [_nameView addSubview:_guanzhuLab];
        [_guanzhuLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.guanzhu.mas_bottom).equalTo(2);
            make.centerX.equalTo(self.guanzhu);
        }];
        _guanzhuLab.text = @"关注";
        _guanzhuLab.textColor = [UIColor darkGrayColor];
        _guanzhuLab.font = [UIFont systemFontOfSize:10];
    }
    return _guanzhuLab;
}

@end

//
//  DynamicCell.m
//  CircleFriend
//
//  Created by sishengxiu on 17/3/7.
//  Copyright © 2017年 司胜修. All rights reserved.
//

#import "DynamicCell.h"
#import "Masonry.h"
#import "DyPhotoView.h"
#import "UIImageView+WebCache.h"
@interface DynamicCell()
{
    CGFloat cellContentWidth;//cell内容宽度
    CGFloat dyTextMaxHeight;
    CGFloat dyTextHeight;
}
@property (nonatomic, strong) UIImageView *headIco;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dyText;//动态内容
@property (nonatomic, strong) DyPhotoView *photoView;//动态图片集合
@property (nonatomic, strong) UILabel *timeLabel;//时间文本
@property (nonatomic, strong) UIButton *deleteBtn;//删除按钮
@property (nonatomic, strong) UIButton *transpondBtn;//转发
@property (nonatomic, strong) UIButton *collecteBtn;//收藏
@property (nonatomic, strong) UIButton *commentBtn;//评论
@property (nonatomic, strong) UIButton *moreBtn;//更多

@property (nonatomic, strong) UIView *lineview;

@end
@implementation DynamicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        cellContentWidth = mScreenWidth-80;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self loadSubView];
        
    }
    return self;
}
- (void)loadSubView{
    
    self.headIco = [[UIImageView alloc] init];
    self.headIco.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.headIco];
    
    self.nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLabel];
    
    self.dyText = [[UILabel alloc] init];
    self.dyText.numberOfLines = 0;
    self.dyText.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.dyText];

    self.photoView = [[DyPhotoView alloc] initWithWidth:cellContentWidth];
    [self.contentView addSubview:self.photoView];
    
    self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moreBtn.hidden = YES;
    self.moreBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.moreBtn setTitle:@"全文" forState:UIControlStateNormal];
    [self.moreBtn setTitle:@"收起" forState:UIControlStateSelected];
    [self.moreBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.moreBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [self.moreBtn addTarget:self action:@selector(showMoreText) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.moreBtn];
    
    
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textColor = [UIColor grayColor];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.timeLabel];
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    self.deleteBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.deleteBtn];
    
    self.transpondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.transpondBtn setImage:[UIImage imageNamed:@"workgroup_img_share"] forState:UIControlStateNormal];
    [self.transpondBtn addTarget:self action:@selector(transDyClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.transpondBtn];
    
    self.collecteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.collecteBtn addTarget:self action:@selector(colllectClick) forControlEvents:UIControlEventTouchUpInside];
    [self.collecteBtn setImage:[UIImage imageNamed:@"workgroup_img_like"] forState:UIControlStateNormal];
    [self.collecteBtn setImage:[UIImage imageNamed:@"workgroup_img_like_sel"] forState:UIControlStateSelected];
    [self.contentView addSubview:self.collecteBtn];
    
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commentBtn setImage:[UIImage imageNamed:@"workgroup_img_comment"] forState:UIControlStateNormal];
    [self.commentBtn addTarget:self action:@selector(comentClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.commentBtn];
    
    self.lineview = [[UIView alloc] init];
    self.lineview.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.lineview];

    [self setSubViewLayOut];

    
}

- (void)setSubViewLayOut{
    

    [self.headIco mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.contentView).offset(15);
        make.size.sizeOffset(CGSizeMake(40, 40));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20);
        make.left.equalTo(self.headIco.mas_right).offset(10);
        make.height.offset(15);
    }];
    
    [self.dyText mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.left.equalTo(self.nameLabel);
        make.right.equalTo(self.contentView).offset(-15);
        
    }];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dyText.mas_bottom);
        make.left.equalTo(self.dyText);
        make.height.offset(CGFLOAT_MIN);
//        make.bottom.equalTo(self.photoView.mas_top);
    }];
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dyText.mas_left);
        make.top.equalTo(self.moreBtn.mas_bottom).offset(5);
        make.height.offset(CGFLOAT_MIN);
        make.right.equalTo(self.dyText).offset(-15);
        make.bottom.equalTo(self.timeLabel.mas_top).offset(-5);
    }];

    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self.lineview.mas_bottom).offset(-5);
        make.left.equalTo(self.dyText);
        
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.dyText.mas_left).offset(60);
        make.centerY.equalTo(self.timeLabel);
        make.height.equalTo(self.timeLabel);
        make.size.sizeOffset(CGSizeMake(30, 30));

    }];
    
    [self.transpondBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.collecteBtn.mas_left).offset(-8);
        make.centerY.equalTo(self.timeLabel);
        make.size.sizeOffset(CGSizeMake(30, 30));
    }];
    
    [self.collecteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.commentBtn.mas_left).offset(-8);
        make.centerY.equalTo(self.timeLabel);
        make.size.sizeOffset(CGSizeMake(30, 30));

    }];
    
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.timeLabel);
        make.size.sizeOffset(CGSizeMake(30, 30));

        
    }];
    
    [self.lineview mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.offset(0.5);
        make.bottom.equalTo(self.contentView);
        
    }];
    
}

/**
 装在cell数据

 @param model 数据模型
 */
- (void)setModel:(CircleFriendModel *)model{
    
    [self.headIco sd_setImageWithURL:[NSURL URLWithString:model.headIco] placeholderImage:[UIImage imageNamed:@"name"]];
    
    
    if (model.isSelf) {
        self.deleteBtn.hidden = NO;
    }else{
        self.deleteBtn.hidden = YES;
    }
    self.nameLabel.text = model.userName;
    self.dyText.text = model.dyText;
    
    CGRect textSize = [model.dyText boundingRectWithSize:CGSizeMake(cellContentWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    dyTextHeight = textSize.size.height+5;
    dyTextMaxHeight = self.dyText.font.pointSize*10;
    self.moreBtn.selected = model.isOpen;
    if (model.isOpen) {
        self.moreBtn.hidden = NO;
        [self.moreBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(30);
        }];
        if (self.moreBtn.selected) {
            [self.dyText mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.offset(dyTextHeight);
            }];
        }
        else{
            [self.dyText mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.offset(dyTextMaxHeight);
            }];
        }
    }else{
        if (textSize.size.height>dyTextMaxHeight) {
            self.moreBtn.hidden = NO;
            [self.moreBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.offset(30);
            }];
            [self.dyText mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.offset(dyTextMaxHeight);
            }];
        }else{
            self.moreBtn.hidden = YES;
            [self.moreBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.offset(CGFLOAT_MIN);
            }];
            [self.dyText mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.offset(dyTextHeight);
            }];
        }
    }
    
    self.timeLabel.text = [self timeTransform:model.timeDate];
    
    if (model.videoUrl.length>1) {
        
        self.photoView.videoUrl = model.videoUrl;
        
    }else{
        self.photoView.picUrlArray = model.thumbnailPicUrls;
        self.photoView.picOriArray = model.originalPicUrls;
    }
}



- (NSString *)timeTransform:(NSDate *)thisDate{

    NSString *timeStr;
    NSDate *nowDate = [NSDate date];
    NSInteger now = [nowDate timeIntervalSince1970];
    
    NSInteger this = [thisDate timeIntervalSince1970];
    
    NSInteger cha = now - this;
    
    if (cha<0) {
        timeStr = @"未知";
    }
    else if (cha<60){
        timeStr = @"刚刚";
    }
    else if (cha<60*60){
        timeStr = [NSString stringWithFormat:@"%ld分钟前",cha/60];
    }
    else if (cha<24*60*60){
        timeStr = [NSString stringWithFormat:@"%ld小时前",cha/(60*60)];
    }
    else if (cha<24*60*60*30){
        timeStr = [NSString stringWithFormat:@"%ld天前",cha/(60*60*24)];
    }
    else if (cha<24*60*60*30*12){
        timeStr = [NSString stringWithFormat:@"%ld月前",cha/(60*60*24*30)];
    }
    else if (cha>=24*60*60*30*12){
        timeStr = [NSString stringWithFormat:@"%ld年前",cha/(60*60*24*30*12)];
    }
    return timeStr;
}
#pragma mark - 按钮点击方法
- (void)showMoreText{
    
    self.moreBtn.selected = !self.moreBtn.selected;
    if (self.showMore) {
        self.showMore(self.moreBtn.selected);
    }
}

- (void)deleteClick{
    
    if (self.deleteDy) {
        self.deleteDy();
    }
    
}

- (void)transDyClick{
    if (self.transpondDy) {
        self.transpondDy();
    }
}

- (void)colllectClick{
    
    self.collecteBtn.selected = !self.collecteBtn.selected;
    if (self.colllectDy) {
        self.colllectDy(self.collecteBtn.selected);
    }
}

- (void)comentClick{
    
    if (self.commentDy) {
        self.commentDy();
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
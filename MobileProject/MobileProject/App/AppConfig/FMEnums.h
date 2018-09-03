//
//  FMEnums.h
//  MobileProject
//
//  Created by Mingo on 2017/8/9.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#ifndef FMEnums_h
#define FMEnums_h




typedef NS_ENUM(NSInteger, CellType) {
    CellTypeSuoShuJiaXiao = 0,
    CellTypeCheLiangGuanLi = 1
};



typedef NS_ENUM(NSInteger, linkType) {
    /** 没有link外链 */
    linkTypeZero = 0,
    /** Web地址 */
    linkTypeWebUrl = 1,
    /** 栏目列表 */
    linkTypeCategoriesList = 2,
    /** 投票页 */
    linkTypeVote = 3,
    /** 活动页 */
    linkTypeActivity = 4,
    /** 视频页 */
    linkTypeVideo = 5 ,
    /** 咨询页 */
    linkTypeConsulting = 6
};

typedef NS_ENUM(NSInteger, celltype) {
    /** 小图 */
    celltypeSmall = 1,
    /** 大图 */
    celltypeBig = 2,
    /** 多图 */
    celltypeMultiple = 3
};




typedef NS_ENUM(NSInteger, contentType) {
    /** 热点 */
    contentTypeHotNews = 1,
    /** 公告 */
    contentTypeNotes = 2,
    /** 教育 */
    contentTypeEducation = 3,
    /** 娱乐 */
    contentTypePlay = 4,
    /** 动漫 */
    contentTypeAnime = 5,
    /** 其他 */
    contentTypeOthers = 6,
    /** 收藏 */
    contentTypeFavorites = 7,
    /** 推送 */
    contentTypePush = 8,
    /** 资讯新闻类 */
    contentTypeGeneralNews = 9,
    
};


typedef NS_ENUM(NSInteger, accountType) {
    accountTypePhone = 1,
    accountTypeQQ = 2,
    accountTypeWX = 3,
    accountTypeWB = 4,
 
};
//account

typedef NS_ENUM(NSInteger, AskZhengType) {
    //问政
    AskZhengTypeAll = 1,
    //我的问政
    AskZhengTypeMy = 2,
    
    
};

typedef NS_ENUM(NSInteger, SeatType) {
    //不可用
    SeatTypeGangway = 0,
    //未够吗
    SeatTypeUnsold = 1,
    //以购买
    SeatTypeByselling = 2,
    
    
};

typedef NS_ENUM(NSInteger, SeatOrAisleType) {
    //过道
    SeatOrAisleTypeSeat = 0,
    //座位
    SeatOrAisleTypeAisle = 1,

};


typedef NS_ENUM(NSInteger, MyNewsType) {
    //普通类型
    MyNewsTypeCommon = 1,
    //头像类型
    MyNewsTypeHead = 2,
    
    MyNewsTypeNum = 3
    
    
};

typedef NS_ENUM(NSInteger, RecommendOneCellType) {
    //大图
    RecommendOneCellTypeBigChart = 1,
    //多图
    RecommendOneCellTypeCharts = 2,
    //无图
    RecommendOneCellTypeNoChart= 3
    
    
};

typedef NS_ENUM(NSInteger, MovieType) {
    /// 即将上映1
    MovieTypeWillShow = 1,
    /// 正在热映9
    MovieTypeHotShowNow = 9
};

typedef NS_ENUM(NSInteger, SearchType) {
    /// 1资讯搜索
    SearchTypeArticle = 1,
    /// 2正在热映
    SearchTypeScenic = 2,
    /// 3剧目搜索
    SearchTypeFilm = 3,
    /// 4话题
    SearchTypeTalk = 4
};
typedef NS_ENUM(NSInteger, OrderType) {
    /// 订单关闭
    OrderTypeShutdown = 0,
    /// 订单待付款
    OrderTypeNopayment = 1,
    /// 待发货
    OrderTypeSendGoods = 2,
    /// 待收货
    OrderTypeForTheGoods = 3,
    /// 待退款
    OrderTypeForRefund = 4,
    /// 以退款
    OrderTypeRefund = 5,
    /// 订单完成
    OrderTypeOK = 9
};

typedef NS_ENUM(NSInteger, PayType) {
    /// 支付宝支付
    PayTypeAli = 1,
    /// 微信支付
    PayTypeWX = 2,
    /// 银联支付
    PayTypeYL = 3,
    /// 线下支付
    PayTypeOffline = 4
    
};
///订单状态
typedef NS_ENUM(NSInteger, OrderStatusType) {
    ///订单状态取消
    OrderStatusTypeCancel = 0,
    ///订单状态完成
    OrderStatusTypeComplete = 2,
    ///订单状态进行中
    OrderStatusTypeOngoing = 1
};

///订单明细类型
typedef NS_ENUM(NSInteger, OrdersItemsType) {
    ///押金
    OrdersItemsTypeDeposit = 1,
    ///首付款
    OrdersItemsTypeInitialPayment = 2,
    ///尾付款
    OrdersItemsTypeFinalPaymen = 3
};

//0 => '订单已取消',
//1 => '订单发起，待支付订单押金',
//2 => '首付款凭证待确认',
//3 => '押金已支付，订单匹配中',
//4 => '订单匹配成功，待签订委托合同',
//5 => '委托合同已签，待支付服务费首付款',
//6 => '首付款凭证待确认',
//7 => '服务费首付款已支付，供电三方合同签订中',
//8 => '三方合同签订成功，待支付服务费余款',
//9 => '服务费余款凭证待确认',
//10 => '订单完成',
//11 => '押金线下支付成功',
//12 => '首付款线下支付成功',
//13 => '尾款线下支付成功',
typedef NS_ENUM(NSInteger, OrdersStatus) {
    OrdersType0 = 0,
    OrdersType1,
    OrdersType2,
    OrdersType3,
    OrdersType4,
    OrdersType5,
    OrdersType6,
    OrdersType7,
    OrdersType8,
    OrdersType9,
    OrdersType10,
    OrdersType11,
    OrdersType12,
    OrdersType13
};


#endif /* FMEnums_h */

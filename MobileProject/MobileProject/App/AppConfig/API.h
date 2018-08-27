
//  API.h
//  MobileProject
//
//  Created by Mingo on 2017/6/7.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#ifndef API_h
#define API_h

#import "FMBaseURL.h"

#define KURL(urlstr) [NSString stringWithFormat:@"%@%@",FMBaseURL,urlstr]

#define KURLIma(urlstr)  (([urlstr containsString:@"http"] )?  urlstr : ([NSString stringWithFormat:@"%@%@",FMBaseURL,urlstr]))

/////////////////// 新接口 按照 pragma mark写入对应 mark中。然后清除旧接口。
#define APIappInfo KURL(@"/api/apps/info?app_id=2")

#pragma mark - category_ids
#define CIDparentInformation 21 //资讯父级主ID
#define CIDHotInformation 22    //热点资讯
#define CIDparentShequ 28  //社区父级主ID
#define CIDparentShouye 33  //首页父级主ID
#define CIDparentShangpin 35  // 商品父级主ID
#define CIDparentHuodong 38  // 活动父级主ID
#define CIDparentScenic 39  // 景点父级主ID 
#define CIDScenicRecommend 40 //景点推荐 博物馆
#define CIDHomeBanner 36 //首页轮播图
#define CIDHomeReDian  22 //文化热点
#define CIDHomeJianShang  23 //文化鉴赏
#define CIDNewBookSpread 24 //新书速递
#define CIDcollectionSelected 25 //典藏精选
#define CIDHomeQinZi  26 //亲子
#define CIDHomePeiXun  27 //培训
#define CIDHomeZhanLan  41 //展览
#define CIDHomeJiangZuo  53 //讲座
#define CIDHomeService 272 //文化服务


#pragma mark -------订单
/// 创建订单
#define POSTOrdersCreate KURL(@"/api/orders/create?title=%@&num=%@&voltage=%@&max_price=%@&province=%@&start_date=%@&end_date=%@&yesteryear_total=%@&before_last_total=%@&industry=%@&area=%@&time_slot=%@&allow=1&token=%@")
/// /api/orders/create?title=%@&num=%@&voltage=%@&max_price=%@&province=%@&start_date=%@&end_date=%@&yesteryear_total=%@&before_last_total=%@&industry=%@&area=%@&time_slot=%@&allow=1&token=%@

/// 我的订单列表
#define GETordersList KURL(@"/api/orders/owns?site_id=2&page_size=20&page=%d&token=%@&state=%d")

/// 订单详情
#define GETOrdersInfo KURL(@"/api/orders/info?id=%d&token=%@")
///取消订单
#define GETOrdersCancel KURL(@"/api/orders/cancel?id=%d&token=%@")
///修改订单状态
#define GETOrdersState KURL (@"/api/orders/state?id=%d&token=%@")
///核实订单明细
#define GETOrdersVerify KURL(@"/api/orders/verify?id=%d&token=%@")

/// 订单明细创建
#define GETOrdersItemsCreate KURL(@"/api/orders/items/create?type=%d&title=%@&id=%d&discount=%d&token=%@")

#pragma mark --------首页
#define GETMembersIndexInfo KURL(@"/api/members/index/info?province=%@")
#define GETMembersIndexInfoLOGIN KURL(@"/api/members/index/info?province=%@&token=%@")

#pragma mark --------我的
//我的账户
#define GETMembersAccountInfo KURL(@"/api/members/account/info?token=%@")
//上传凭证发起支付
#define POSTMembersAccountRecharge KURL(@"/api/members/account/recharge?token=%@&money=%@&type=%ld&image=%@")

/// 邀请链接
#define URLMemberInvite KURL(@"/member/invite")
#define URLMemberInviteUID KURL(@"/member/invite?uid=%@")
/// 银联支付
#define GETUnionPay KURL(@"/api/union/UnionPay?token=%@&site_id=1&order_id=%@")
//#define POSTMembersAccountDetail KURL(@"/api/members/account/detail?token=%@")
//上传文件
#define POSTFileUpload KURL(@"/api/files/upload?token=%@")
//我的账户流水明细
#define GETMembersAccountDetail KURL(@"/api/members/account/detail?token=%@&page=%d&page_size=20")
//我的优惠券
#define GETmMembersPoint KURL(@"/api/members/point?token=%@")

//用户信息
#define GETMembersInfomation KURL(@"/api/members/infomation?token=%@")

#pragma mark -----------------HTML
//淘电宝信息服务协议
#define HTMLTDBAgreement KURL(@"/page/3")
//《淘电宝用户服务协议》
#define HTMLTDBAPPUserAgreement KURL(@"/page/2")
//淘电宝客服
#define HTMLCustomerService KURL(@"/page/6")
//收款账号
#define HTMLPaymentAccount KURL(@"/page/1")
// 业务介绍
#define HTMLBusinessIntroduction KURL(@"/page/7")
//注册有礼
#define HTMLRegistrationPolite KURL(@"/page/5")

//合同
#define HTMLContract KURL(@"/contract.html?id=%ld&token=%@")
#pragma mark ------------------------------------ members
//手机号登陆
#define GETmembersLogin KURL(@"/api/members/login?member_name=%@&password=%@")
//的三方登录
#define GETmembersExlogin \
KURL(@"/api/members/exlogin?member_name=%@&nick_name=%@&avatar_url=%@&source=%@")
//验证码
#define GETmembersMobileCheckcode KURL(@"/api/members/mobile/captcha?mobile=%@&type=%d&site_id=8")
//绑定手机
#define GETBindingMobilePhone KURL(@"/api/members/mobile/bind?token=%@&mobile=%@&captcha=%@")
//修改昵称
#define POSTChangeTheNickname KURL(@"/api/members/info/nick?token=%@&nick_name=%@")
//头像上传
#define userHeaderImage KURL(@"/api/members/avatar?token=%@")
//判断token
#define GETmembersTokenStatus \
KURL(@"/api/members/token/status?token=%@")

//提交反馈
#define POSTSubmitFeedback KURL(@"/api/feedback?site_id=1&contact=%@&content=%@&token=%@")


#pragma mark - ---------------------------------- films
//剧目列表
#define GETFILMSLIST KURL(@"/api/films?site_id=2&state=%d&category_id=%d&page_size=20&page=%d")

//演出推荐（正在热映和即将热映推荐。）
#define GETfilmsListRecommend \
KURL(@"/api/films?site_id=2&state=%d&tag=推荐&category_id=%d&page_size=30&page=%d")

/// 剧目详情页
#define GETfilmsDetail KURL(@"/api/films/detail?id=%ld")

///  剧目信息
#define GETfilmsInfo KURL(@"/api/films/info?id=%ld")

//剧目列表所有
#define GETFilmsListAll KURL(@"/api/films?site_id=2&page_size=50&page=%d")

#define GETFilmsListForTheatersessions KURL(@"/api/theatersessions/films?site_id=2&theater_id=%d&page_size=50&page=1")

#define GETTheatersessionsList KURL(@"/api/theatersessions?site_id=2&category_id=%d&film_id=%d&page_size=50&page=1")

/// 剧目分享
#define GETfilmsShare KURL(@"/api/films/share1?id=%ld")

/// 剧目搜索
#define GETfilmsSearch KURL(@"/api/films/search?site_id=2&type=%ld&title=%@&page_size=%ld&page=%ld")

///场次，座位
#define GETtheatersessions KURL(@"/api/theatersessions/info?id=%d")

//ttp://whnn.dev.asia-cloud.com//api/theatersessions/info?id=1
#pragma mark ------------------------------------ favorites
/// 收藏
#define POSTaddFavorites KURL(@"/api/favorites/create?id=%ld&type=%@&token=%@")
/// 检查是否收藏
#define GETfavoritesExist   KURL(@"/api/favorites/exist?id=%ld&type=%@&token=%@")
/// 删除收藏
#define GETfavoritesDelete KURL(@"/api/favorites/delete?id=%ld&type=%@&token=%@")
///收藏列表
#define GETfavoritesList KURL(@"/api/favorites?site_id=2&type=%@&page_size=20&page=%d&token=%@")

#define GETfavoritesDestroy KURL(@"/api/favorites/destroy?ids=%@&type=%@&token=%@")
#pragma mark ------------------------------------ 关注
#define GETtags KURL(@"/api/tags?site_id=2&types=film,activity,article,live,scenic,topic")
/// 电影演出关注
#define GETfilmsSearchTags KURL(@"/api/films/search?site_id=2&title=%@&page_size=20&page=")
/// 看了又看
#define GETlivesSearchTags KURL(@"/api/lives/search?site_id=2&title=%@&page_size=20&page=")
/// 景点
#define GETscenicsSearchTags KURL(@"/api/scenics/search?site_id=2&title=%@&page_size=20&page=")
/// 活动
#define GETactivitiesSearchTags KURL(@"/api/activities/search?site_id=2&title=%@&page_size=20&page=")
/// 资讯
#define GETarticlesSearchTags KURL(@"/api/articles/search?site_id=2&title=%@&page_size=20&page=")
/// 社区
#define GETtopicsSearchTags KURL(@"/api/topics/search?site_id=2&title=%@&page_size=20&page=")

/// 关注列表
#define GETtagsSearch KURL(@"/api/tags/search?site_id=2&type=%@&title=%@&page_size=20&page=")

#pragma mark ------------------------------------ messages

#pragma mark ------------------------------------ contents

#pragma mark ------------------------------------ contentsLists

#pragma mark - ---------------------------------- surveysList

#pragma mark - ---------------------------------- votes

#pragma mark - ---------------------------------- topics   社区
#define POSTCommit KURL(@"/api/topics/commit?site_id=2&category_id=%d&token=%@&title=%@&content=%@&images=%@&videos=%@")
#define GETtopicsList KURL(@"/api/topics?site_id=2&category_id=%d&page_size=20&page=%d")
#define GETPiazzaList KURL(@"/api/categories?site_id=2&parent_id=30&page_size=20&page=%d")
/// 社区分享
#define GETtopicsShare KURL(@"/api/topics/share?id=%ld")

/// 社区详情页
#define GETtopicsDetail KURL(@"/api/topics/detail?id=%ld")
#define GETtopicsSearch KURL(@"/api/topics/search?site_id=2&title=%@&page_size=%ld&page=%d")

#pragma mark - ---------------------------------- articlesList
/// 文章列表
#define GETarticlesList \
KURL(@"/api/articles?site_id=2&category_id=%ld&page_size=%ld&page=%ld")
/// 文章列表推荐
#define GETarticlesListRecommend \
KURL(@"/api/articles?site_id=2&category_id=%ld&tag=推荐&page_size=%ld&page=%ld")

/// 首页轮播图
#define GEThomeBanner \
KURL(@"/api/pages?site_id=2&category_id=%ld&page_size=%ld&page=%ld")

/// 文章分享
#define GETarticlesShare KURL(@"/api/articles/share?id=%ld")

/// 文章详情页面
#define GETarticleDetail KURL(@"/api/articles/detail?id=%ld")

/// 文章搜索
#define GETarticlesSearch KURL(@"/api/articles/search?site_id=2&title=%@&page_size=%ld&page=%ld")

/// 文章点击数
#define GETarticlesClick KURL(@"/api/articles/click?id=%ld")

#pragma mark - --------------------------------- categoriesList
#define GETcategoriesList \
KURL(@"/api/categories?site_id=2&parent_id=%ld&page_size=%ld&page=%ld")

#pragma mark - -------------------------------- theaters
/// 剧场列表
#define GETtheatersList \
KURL(@"/api/theaters?site_id=2&page_size=%ld&page=%ld")
/// 剧目相关剧场列表
#define GETtheatersListForFilms KURL(@"/api/theatersessions/theaters?site_id=2&film_id=%d&page_size=%ld&page=%ld")
#define GETfilmsInfo KURL(@"/api/films/info?id=%ld")

#define GETFilmsMerge KURL(@"/api/films/merge?site_id=2&film_category_id=%d&article_category_id=%d&activity_category_id=%d&state=0&page_size=20&page=%d")
/// 剧场列表推荐
#define GETtheatersListRecommend \
KURL(@"/api/theaters?site_id=2&tag=推荐&page_size=%ld&page=%ld")

///
#define GETtheatersDistance KURL(@"/api/theaters/distance?site_id=2&lnt=%f&lat=%f&page_size=%ld&page=%ld")

#define POSTcreate KURL(@"/api/theaters/orders/create?id=%d&token=%@")
#pragma mark - -------------------------------- activities

///  活动列表
#define GETactivitiesList \
KURL(@"/api/activities?site_id=2&category_id=%ld")

/// 活动推荐列表
#define GETactivitiesListRecommend \
KURL(@"/api/activities?site_id=2&category_id=%ld&tag=推荐")

/// 活动详情页面
#define GETactivitieDetail \
KURL(@"/api/activities/detail?site_id=2&id=%ld&token=%@")

#define GETactivitieDetailNoToken \
KURL(@"/api/activities/detail?site_id=2&id=%ld")

/// 活动分享
#define GETactivitiesShare KURL(@"/api/activities/share?id=%ld")

/// 活动信息
#define GETactivitiesInfo KURL(@"/api/activities/info?id=%ld")

/// 活动报名
#define POSTactivitiesCommit KURL(@"/api/activities/commit?site_id=2&activity_id=%ld&token=%@&person_name=%@&person_mobile=1%@&amount=%ld")
#pragma mark - ----------------------------------  scenics

/// 景点列表
#define GETscenicsList \
KURL(@"/api/scenics?site_id=2&category_id=%ld&page_size=%ld&page=%ld")

/// 景点信息
#define GETscenicsInfo KURL(@"/api/scenics/info?id=%ld")

/// 景点列表推荐到旅游首页
#define GETscenicsListRecommend \
KURL(@"/api/scenics?site_id=2&category_id=%ld&tag=推荐&page_size=%ld&page=%ld")

/// 景点列表轮播图（旅游）
#define GETscenicsListBanner \
KURL(@"/api/scenics?site_id=2&category_id=%ld&tag=轮播图&page_size=%ld&page=%ld")

/// 景点分享
#define GETscenicsShare KURL(@"/api/scenics/share?id=%ld")

/// 景点搜索
#define GETscenicsSearch KURL(@"/api/scenics/search?site_id=2&title=%@&page_size=%ld&page=%ld")

/// 景点门票下单
#define POSTcenicsOrdersCreate \
KURL(@"/api/scenics/orders/create?scenic_id=%ld&product_id=%ld&date=%@&num=%ld&token=%@")
/// 演出门票下单
#define POSTtheatersessionsOrdersCreate KURL(@"/api/theatersessions/orders/create?id=%ld&product_id=%ld&num=%ld&token=%@")
/// 我的票
#define GETscenicsOwns KURL(@"/api/scenics/owns?scenic_id=%ld&token=%@")

/// 门票列表
#define GETscenicsTicket KURL(@"/api/scenics/ticket?scenic_id=%ld")
/// 场次门票
#define GETtheatersessionsTicket KURL(@"/api/theatersessions/ticket?id=%ld")
#pragma mark - -------------------------------------    comments
/// 获取评论列表
#define GETcommentsList KURL(@"/api/comments?id=%ld&type=%@&page_size=%ld&page=%ld")

/// 发布评论
#define POSTcommentsCreate KURL(@"/api/comments/create?id=%ld&type=%@&content=%@&token=%@")

#pragma mark - --------------------------------------  Page
///客服中心
#define HTMLsupport KURL(@"/page/support.html")
///关于我们
#define HTMLabout KURL(@"/page/about.html")
///用户协议
#define HTKLprotocol KURL(@"/page/protocol.html")
/// 获取页面详情页
#define GETpagesDetail KURL(@"/api/pages/detail?id=%ld")

#pragma mark - ------------------------------------- 支付
/// 支付宝支付
#define GETalipayApppay KURL(@"/api/alipay/apppay?site_id=1&order_id=%@&token=%@")

//微信支付
#define GETwechatApppay KURL(@"/api/wechat/apppay?site_id=1&order_id=%@&token=%@")

#pragma mark - ------------------------------------  tickets
///
#define GETtheatersDetail KURL(@"/api/theaters/detail?id=%ld")
/// 我的票
#define GETticketsOwns KURL(@"/api/tickets/owns?id=%ld&token=%@")

#pragma mark - ------------------------------------ 商城mall
/// 商城
#define GETmall KURL(@"/mall")
#define GETmallAddress KURL(@"/mall/address")

#pragma mark - ------------------------------- lives看了又看
#define GETlivesList KURL(@"/api/lives?site_id=2&category_id=111&page_size=%ld&page=%ld")
#define GETlivesClick KURL(@"/api/lives/click?id=%ld")
#define GETlivesShare KURL(@"/api/lives/share?id=%ld")
#define GETlivesDetail KURL(@"/api/lives/detail?id=%ld")

/// 添加关注
#define GETfollowsCreate KURL(@"/api/follows/create?id=%d&type=live&token=%@")
/// 获取关注列表
#define GETfollowsMembers KURL(@"/api/follows/members?id=%d&type=live&token=%@")
/// 获取私聊列表
#define GETfollowsCommentsOwns KURL(@"/api/follows/comments/owns?id=%d&page_size=50&page=1&token=%@")
/// 发送私聊
#define GETfollowsComments KURL(@"/api/follows/comments/member?id=%d&member_id=%d&content=%@&token=%@")
/// 获取关于我的消息
#define GETfollowsCommentsMessages KURL(@"/api/follows/comments/messages?id=%d&token=%@")
/// 读取信息
#define GETfollowsCommentsRead KURL(@"/api/follows/comments/read?id=%d&token=%@")
#pragma mark -------------------------------- 惠民演出
/// 惠民演出列表
#define GETShows KURL(@"/api/shows?site_id=2&category_id=110&page_size=%ld&page=%ld")
/// 惠民演出详情
#define GETshowsDetail KURL(@"/api/shows/detail?id=%ld&token=%@")

/// 惠民演出详情
#define GETshowsDetailNoToken KURL(@"/api/shows/detail?id=%ld")
/// 分享
#define GETshowsShare KURL(@"/api/shows/share?id=%ld")



////广告图
#define GETcontentsListAdvertisement \
KURL(@"/api/contents/list?category_id=19&page_size=20&page=1")

////创建评论 content_type内容类型(1:新闻,2:评论,3:投票,4:活动,5:爆料,8:点播,9:直播)
#define GETcommentsCreate \
KURL(@"/api/comments/create?site_id=5&content_id=%ld&content_type=%ld&content=%@&token=%@")

////内容列表
#define GETcontentsLists \
KURL(@"/api/contents/list?site_id=5&category_id=%@&page_size=%ld&page=%ld")

//
//修改密码
#define GETmembersPasswordChange KURL(@"/api/members/password/change?token=%@&old_password=%@&new_password=%@")

////注册
#define GETRegistered KURL(@"/api/members/register?member_name=%@&nick_name=%@&password=%@&captcha=%@")
//重置密码
#define GETResetYourPassword KURL(@"/api/members/password/reset?member_name=%@&password=%@&captcha=%@")

//内容详情页面（H5）
#define GETcontentsDetail KURL(@"/api/contents/detail?site_id=5&id=%ld")


#endif /* API_h */

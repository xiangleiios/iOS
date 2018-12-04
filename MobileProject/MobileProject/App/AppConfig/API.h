
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

#define KURLIma(urlstr)  (([urlstr containsString:@"http"] )?  urlstr : ([NSString stringWithFormat:@"%@%@",[XLSingleton singleton].scanPhotoIp,urlstr]))

/////////////////// 新接口 按照 pragma mark写入对应 mark中。然后清除旧接口。
#define APIappInfo KURL(@"/api/apps/info?app_id=2")



/// 驾校名缓存
#define SchoolList @"schoolList"
/// 缓存所有字典数据
#define ALLDATA @"AllData"

/// 手动添加学员 申请类型
#define DICTApply_type @"school_student_apply_type"
/// 准驾车型
#define DICTLicense_type @"school_student_license_type"
/// 本外地
//#define DICTEnter_type @"school_student_is_enter_type"
#define DICTEnter_type @"team_school_student_enter_type"
/// 性别
#define DICTUser_sex @"sys_user_sex"
/// 名族
#define DICTEthnic @"sys_nation_type"


#pragma mark 手机号登陆
#define GETmembersLogin KURL(@"app/login?mobile=%@&password=%@")

#pragma mark 手机号登陆- 教练
#define GETCoachmembersLogin KURL(@"app/coach/login?mobile=%@&password=%@")

#pragma mark 手机号登陆 - 负责人
#define GETTeammembersLogin KURL(@"app/team/login?mobile=%@&password=%@")

#pragma mark 分校车辆管理
#define POSTTeamCarLis KURL(@"app/team/teamCar/teamCarList")

#pragma mark 分校所属驾校管理
#define POSTTeamSchoolList KURL(@"app/team/teamSchool/teamSchoolList")

#pragma mark 分校所属驾校管理
#define POSTTeamSchoolTeamSchoolInfo KURL(@"app/v1_1/team/teamSchool/teamSchoolInfo?teamSchoolId=%@")


#pragma mark 数据字典接口
#define POSTAppDictList KURL(@"system/dict/data/appDictList")

#pragma mark -新增学员咨询接口
#define POSTStudenteamAdd KURL(@"app/studenteam/add")

#pragma mark -学员咨询列表接口 - 分校负责人
#define POSTStudenteamList KURL(@"app/studenteam/list")

#pragma mark -学员咨询列表接口 - 教练
#define POSTCoachStudenteamList KURL(@"app/coach/studenteam/list")

#pragma mark -修改学员咨询接口
#define POSTStudenteamEdit KURL(@"app/studenteam/edit")

#pragma mark -学员报名-修改资料接口
#define POSTUpdateStudent KURL(@"app/team/student/updateStudent")

#pragma mark -查询报名学员列表接口 - 负责人
#define POSTStudentSignList KURL(@"app/team/student/studentSignList")

#pragma mark -查询报名学员列表接口 - 教练
#define POSTCoachStudentSignList KURL(@"app/coach/teamStuState/list")

#pragma mark -查询招生名片列表接口
#define POSTEnrollInfoList KURL(@"app/enrollInfo/list")

#pragma mark -查询所属分校列表接口
#define POSTTeamSchoolTeamSchoolList KURL(@"app/v1_1/team/teamSchool/teamSchoolList")


#pragma mark -学员咨询报名接口
#define POSTSignStudent KURL(@"app/studenteam/signStudent")

#pragma mark -修改班型接口
#define POSTClassTypeEdit KURL(@"app/classType/edit")

#pragma mark -app新增班型接口
#define POSTClassTypeAdd KURL(@"app/classType/add")

#pragma mark -删除班型接口
#define POSTClassTypeRemove KURL(@"app/classType/remove")

#pragma mark -获取招生名片信息接口
#define POSTgGetEnrollInfoInfo KURL(@"app/enrollInfo/getEnrollInfoInfo")

#pragma mark -查询所属分校招生名片信息接口
#define POSTTeamSchoolEnrollInfo KURL(@"app/v1_1/team/teamSchool/teamSchoolEnrollInfo")

#pragma mark -文件上传
#define POSTUpLoadFile KURL(@"system/file/upLoadFile")

#pragma mark -修改招生名片接口
#define POSTEnrollInfoEdit KURL(@"app/coach/v1_2/coach/editCoachEnrollInfo")


#pragma mark -编辑所属分校招生名片信息接口
#define POSTTeamSchoolEdit KURL(@"app/v1_1/team/teamSchool/teamSchoolEdit")

#pragma mark -推广名片
#define POSTEnrollInfoExtension KURL(@"/app/enrollInfo/extension")

#pragma mark -修改密码 - 负责人
#define POSTEditPwd KURL(@"app/team/teamUser/editPwd")

#pragma mark -修改密码 - 教练
#define POSTEditPwdCoach KURL(@"app/coach/ranking/updateCoachPassword")



#pragma mark -招生日报 - 负责人
#define POSTCensusList KURL(@"app/census/list")

#pragma mark -招生日报 - 教练
#define POSTCensusListcoach KURL(@"/app/coach/census/list")

#pragma mark - 消息中心
#define POSTFirstList KURL(@"appMessage/first/list")

#pragma mark - 消息中心 - 教练
#define POSTFirstcoachList KURL(@"appMessage/first/coach/list")

#pragma mark - 通知公告
#define POSTNoticetwoList KURL(@"app/noticetwo/list")

#pragma mark - 获取消息详情
#define POSTGetMessageInfo KURL(@"appMessage/first/getMessageInfo")


#pragma mark - 全部已读
#define POSTUpdateAllRead KURL(@"appMessage/first/updateAllRead")


#pragma mark -添加消息
#define POSTReplyAdd KURL(@"app/reply/add")


#pragma mark - 名片H5 - 教练
#define HTMLMINGPIAN KURL(@"plat/#/coach/detail?type=%@&id=%@")
#define HTMLMINGPIANFENXIANG KURL(@"plat/#/coach/detail?id=%@&type=share")

#pragma mark - 名片H5 - 驾校
#define HTMLMINGPIANJIAXIAO KURL(@"plat/#/school/detail?type=app&id=%@")
#define HTMLMINGPIANFENXIANGJIAXIAO KURL(@"plat/#/school/detail?type=share&id=%@")

#pragma mark - 二维码 - 教练
#define XIAOCHENGXUEWM KURL(@"wechart/pages/index/detail/detail?id=%@")


#pragma mark - 二维码 - 驾校
#define XIAOCHENGXUEWMschool KURL(@"wechart/pages/index/school/school?id=%@")


#pragma mark - 今日咨询学员
#define POSTCensiusList KURL(@"app/census/censiusList")

#pragma mark - 海报模板列表
#define POSTSysList KURL(@"app/post/sys/list")

#pragma mark - 我的海报
#define POSTUserList KURL(@"app/post/user/list")

#pragma MARK - 获取系统海报模版信息详情接口
#define POSTSysDetail KURL(@"app/post/sys/detail")

#pragma mark - 获取个人海报模版信息详情接口
#define POSTUserDetail KURL(@"app/post/user/detail");
#pragma mark - 新增用户海报接口
#define POSTPostAdd KURL(@"app/post/add")

#pragma mark - h图文海报H5
#define HTMLHAIBAO KURL(@"plat/#/poster/index?id=%@&type=%@&role=%@")

#pragma mark - 删除海报
#define POSTPostRemove KURL(@"app/post/remove?id=%@")


#pragma mark - 日咨询学员列表接口 - 负责人
#define POSTCensiusList KURL(@"app/census/censiusList")

#pragma mark - 今日报名学员列表接口 - 负责人
#define POSTSignList KURL(@"app/census/signList")

#pragma mark - 本月报名学员列表接口 - 负责人
#define POSTMonthSignList KURL(@"app/census/monthSignList")

#pragma mark - 日咨询学员列表接口 - 教练
#define POSTCensiusListcoach KURL(@"/app/coach/census/censiusList")

#pragma mark - 今日报名学员列表接口 - 教练
#define POSTSignListcoach KURL(@"/app/coach/census/signList")

#pragma mark - 本月报名学员列表接口 - 教练
#define POSTMonthSignListcoach KURL(@"/app/coach/census/monthSignList")


#pragma mark -上传用户头像 - 负责人
#define POSTUpdateTeamUserHeadImg KURL(@"app/team/teamUser/updateTeamUserHeadImg?teamUserHeadImg=%@")

#pragma mark -上传用户头像 - 教练
#define POSTUpdateCoach KURL(@"app/coach/ranking/updateCoach")

#pragma mark -考试学员
#define POSTTeamStuStateList KURL(@"app/teamStuState/list")

#pragma mark -考试学员 - 教练
#define POSTCoachTeamStuStateList KURL(@"app/coach/teamStuState/list")



#pragma mark -修改考试学员
#define POSTTeamStuStateEdit KURL(@"app/teamStuState/edit")

#pragma mark -新增标签
#define POSTTagAdd KURL(@"app/tag/add")

#pragma mark -标签列表
#define POSTTagList KURL(@"app/tag/list")

#pragma mark -删除标签
#define POSTTagRemove KURL(@"app/tag/remove?ids=%d")

#pragma mark - 训练场列表
#define POSTTeamtrainingList KURL(@"app/v1_2/teamtraining/teamtrainingList")

#pragma mark - 省 市 区
#define POSTProvinceList KURL(@"system/province/list")
#define POSTCityList KURL(@"system/city/list?provincecode=%@")
#define POSTAreaList KURL(@"system/area/list?citycode=%@")

#pragma mark -添加训练场
#define POSTAddTeamtraining KURL(@"app/teamtraining/addTeamtraining")
#pragma mark -编辑训练场
#define POSTEditTeamtraining KURL(@"app/teamtraining/editTeamtraining")
#pragma mark -删除训练场
#define POSTRemoveTeamtraining KURL(@"app/teamtraining/removeTeamtraining?teamTrainingId=%@")

#pragma mark - 预约练车  训练场列表
#define POSTTrainingRecordTrainingList KURL(@"app/trainingRecordRev2/trainingList/rev2");
#pragma mark - 查询训练场２周预约信息
#define POSTTrainingRecordTwoWeekRecords KURL(@"app/trainingRecordRev2/twoWeekRecordsRev2")

#pragma mark - 学员约车列表接口
#define POSTTrainStuslist KURL(@"app/teamStuState/trainStuslist")


#pragma mark - 查询训练场约车时段模板列表接口
#define POSTTrainingModuleList KURL(@"app/trainingModule/list")

#pragma mark - 新增训练场约车时段模板接口
#define POSTTrainingModuleAdd KURL(@"app/trainingModule/add")

#pragma mark - 修改训练场约车时段模板接口
#define POSTTrainingModuleEdit KURL(@"app/trainingModule/edit")

#pragma mark - 删除训练场约车时段模板接口
#define POSTTrainingModuleRemove KURL(@"app/trainingModule/remove?id=%@")

#pragma mark - 新增当日训练场约车时段模板接口
#define POSTTrainingInfoAdd KURL(@"app/trainingInfo/add")

#pragma mark - 修改当日训练场约车时段模板接口
#define POSTTrainingInfoEdit KURL(@"app/trainingInfo/edit")

#pragma mark - 帮学员约车
#define POSTTrainingRecordAdd KURL(@"app/trainingRecord/add")

#pragma mark - 取消预约
#define POSTCancelById KURL(@"app/trainingRecord/cancelById")
#pragma mark - 删除预约记录
#define POSTTrainingRecordDelete KURL(@"app/trainingRecord/delete?id=%@")

#pragma mark - 关闭或开启当天状态
#define POSTToCloseOrOpen KURL(@"app/trainOpenStatus/toCloseOrOpen")

#pragma mark - 获取约练车记录信息接口
#define POSTGetTrainingRecordInfoList KURL(@"app/trainingRecordRev2/getTrainingRecordInfoListRev2")

#pragma mark - 获取学员约练车记录信息接口
#define POSTGetStuRecordsList KURL(@"app/trainingRecordRev2/getStuRecordsListRev2")

#pragma mark - 获取约练车记录详情
#define POSTGetTrainingRecordInfo KURL(@"app/trainingRecord/getTrainingRecordInfo?id=%@")

#pragma mark - 查询所属分校学员评价列表接口
#define POSTTeamSchoolTeamAppraise KURL(@"app/v1_1/team/teamSchool/teamAppraise")

#pragma mark -点赞操作接口
#define POSTTeamSchoolDoPraise KURL(@"app/v1_1/team/teamSchool/doPraise")

#pragma mark -教练列表
#define POSTTeamSchoolCoachCoachList KURL(@"app/school/v1_2/teamSchoolCoach/coachList")

#pragma mark -添加教练
#define POSTTeamSchoolCoachCoachAdd KURL(@"app/school/v1_2/teamSchoolCoach/coachAdd")

#pragma mark -编辑教练
#define POSTTeamSchoolCoachCoachEdit KURL(@"app/school/v1_2/teamSchoolCoach/coachEdit")

#pragma mark -批量添加教练
#define POSTTeamSchoolCoachCoachAddll KURL(@"app/school/v1_2/teamSchoolCoach/coachAddll?data=%@&schoolId=%d&originalDeptId=%d")

#pragma mark -获取驾校
#define POSTBindSchools KURL(@"app/coach/bind/schools?city=%@")


#pragma mark -获取分校
#define POSTBindTeamSchools KURL(@"app/coach/bind/teamSchools?deptId=%@")
//plat/#/poster/index?type=app&id=

#pragma mark -获取积分排行 -负责排行
#define POSTRankingTeamSchoolRankings KURL(@"app/school/ranking/teamSchoolRankings")

#pragma mark -获取积分排行 -教练
#define POSTRankingCoachRankings KURL(@"app/coach/ranking/coachRankings")


#pragma mark -获取积分排行详情 -负责人
#define POSTRankingTeamSchoolRankingDetails KURL(@"app/school/ranking/teamSchoolRankingDetails?deptId=%@")

#pragma mark -获取积分明细列表- 负责人
#define POSTCompositeScoreListSchool KURL(@"app/school/ranking/compositeScore")

#pragma mark -获取积分明细列表- 教练
#define POSTCompositeScoreListCoach KURL(@"app/coach/ranking/compositeScore")
//system/compositeScore/list?id=1
//#pragma mark -教练驾校绑定
//#define POSTBindBindCoach KURL(@"app/coach/bind/bindCoach?id=%@&originalDeptId=%@&schoolId=%@")
#pragma mark -教练驾校绑定
#define POSTBindBindCoach KURL(@"app/coach/bind/bindCoach")
#pragma mark -教练名片详情接口
#define POSTCoachEnrollInfo KURL(@"app/coach/v1_2/coach/coachEnrollInfo?id=%@")


#pragma mark -邀请记录 - 负责人
#define POSTInvitationrecordListSchool KURL(@"app/school/invitationRecord/invitationrecordList")

#pragma mark -邀请记录 - 教练
#define POSTInvitationrecordListCoach KURL(@"app/coach/invitationRecord/invitationrecordList")


#pragma mark -签到 - 负责人
#define POSTRankingSignBoardSchool KURL(@"app/school/ranking/signBoard")

#pragma mark -签到 - 教练
#define POSTRankingSignBoardCoach KURL(@"app/coach/ranking/signBoard")



#pragma mark - 邀请H5
#define HTMLInvitationCoach KURL(@"plat/#/InvitationCoach/InvitationCoach?schoolDeptId=%@&teamSchoolDeptId=%@&coachId=%@&type=%d")



#pragma mark - 海报分享统计
#define POSTSmallRoutineSystemAddSroce KURL(@"smallRoutine/system/addSroce?id=%@")

#pragma mark - 名片分享统计
#define POSTSmallRoutineSystemShareOrClickNum KURL(@"smallRoutine/system/shareOrClickNum?id=%@&type=1")

#pragma mark - 验证码
#define GETmembersMobileCheckcode KURL(@"app/coach/ranking/verCode?phone=%@")

#pragma mark - 跟换手机号码
#define POSTupdateCoachPhone KURL(@"app/coach/ranking/updateCoachPhone")


//--------------------------------------------------------------------------------------------------

#pragma mark 一下全部要删除掉

#pragma mark --------首页
#define GETMembersIndexInfo KURL(@"api/members/index/info?province=%@")
#define GETMembersIndexInfoLOGIN KURL(@"api/members/index/info?province=%@&token=%@")

#pragma mark --------我的
//我的账户
#define GETMembersAccountInfo KURL(@"api/members/account/info?token=%@")
//上传凭证发起支付
#define POSTMembersAccountRecharge KURL(@"api/members/account/recharge?token=%@&money=%@&type=%ld&image=%@")

/// 邀请链接
#define URLMemberInvite KURL(@"member/invite")
#define URLMemberInviteUID KURL(@"member/invite?uid=%@")
/// 银联支付
#define GETUnionPay KURL(@"api/union/UnionPay?token=%@&site_id=1&order_id=%@")
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

//的三方登录
#define GETmembersExlogin \
KURL(@"/api/members/exlogin?member_name=%@&nick_name=%@&avatar_url=%@&source=%@")

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

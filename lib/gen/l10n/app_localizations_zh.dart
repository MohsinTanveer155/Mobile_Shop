// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '手机商店';

  @override
  String get appSubtitle => '专业收银与员工管理';

  @override
  String get appFullTitle => '手机商店 POS';

  @override
  String get versionLabel => '版本 1.0.0';

  @override
  String get welcomeBack => '欢迎回来';

  @override
  String get signInSubtitle => '登录以继续使用您的手机商店账户';

  @override
  String get email => '电子邮箱';

  @override
  String get password => '密码';

  @override
  String get confirmPassword => '确认密码';

  @override
  String get rememberMe => '记住我';

  @override
  String get forgotPassword => '忘记密码？';

  @override
  String get login => '登录';

  @override
  String get logout => '退出登录';

  @override
  String get createAccount => '创建账户';

  @override
  String get dontHaveAccount => '还没有账户？';

  @override
  String get alreadyHaveAccount => '已有账户？';

  @override
  String get register => '注册';

  @override
  String get passwordsDoNotMatch => '两次输入的密码不一致';

  @override
  String get accountCreated => '账户创建成功。';

  @override
  String get unableToSignIn => '无法登录，请重试。';

  @override
  String get unableToCreateAccount => '无法创建账户，请重试。';

  @override
  String get resetPassword => '重置密码';

  @override
  String get resetPasswordInstructions =>
      'Enter your email address and we\'ll send you a link to reset your password.';

  @override
  String get sendResetLink => '发送重置链接';

  @override
  String get resetLinkSent => '密码重置链接已发送至您的邮箱。';

  @override
  String resetLinkSentToEmail(Object email) {
    return 'Password reset link sent to $email.\nPlease check your email.';
  }

  @override
  String get emailAddress => 'Email Address';

  @override
  String get emailHint => 'user@example.com';

  @override
  String get pleaseEnterPassword => 'Please enter password';

  @override
  String get registerSubtitle => 'Register to join your Mobile Shop team';

  @override
  String get fullName => 'Full Name';

  @override
  String get phoneOptional => 'Phone (Optional)';

  @override
  String get role => 'Role';

  @override
  String get logoutConfirm => '确定要退出登录吗？';

  @override
  String get dashboard => '仪表盘';

  @override
  String get home => '首页';

  @override
  String get products => '商品';

  @override
  String get orders => '订单';

  @override
  String get staff => '员工';

  @override
  String get more => '更多';

  @override
  String get attendance => '考勤';

  @override
  String get leave => '请假';

  @override
  String get salary => '薪资';

  @override
  String get profile => '个人资料';

  @override
  String get sales => '销售';

  @override
  String get welcome => '欢迎';

  @override
  String get quickActions => '快捷操作';

  @override
  String get goodMorning => '早上好';

  @override
  String get goodAfternoon => '下午好';

  @override
  String get goodEvening => '晚上好';

  @override
  String get viewAll => '查看全部';

  @override
  String get startNewSale => '开始新销售';

  @override
  String get leaveRequests => '请假申请';

  @override
  String get salaryRequests => '薪资申请';

  @override
  String get noRecentOrders => '暂无最近订单。';

  @override
  String get allProductsStocked => '所有商品库存充足。';

  @override
  String get loadingDashboard => '正在加载仪表盘...';

  @override
  String get periodDaily => '日';

  @override
  String get periodWeekly => '周';

  @override
  String get periodMonthly => '月';

  @override
  String get periodDailyFull => '每日';

  @override
  String get periodWeeklyFull => '每周';

  @override
  String get periodMonthlyFull => '每月';

  @override
  String get periodYearly => '每年';

  @override
  String get manageStaff => '管理员工';

  @override
  String get employee => '员工';

  @override
  String get administrator => '管理员';

  @override
  String get admin => '管理员';

  @override
  String get user => '用户';

  @override
  String get addStaff => '添加员工';

  @override
  String get monthlySalary => '月薪';

  @override
  String get useSignupForStaff => '新员工请使用注册页面';

  @override
  String get editProfileComingSoon => '编辑资料功能即将推出';

  @override
  String updateStaffSalary(Object name) {
    return '更新 $name 的薪资';
  }

  @override
  String get hrDashboard => '人事仪表盘';

  @override
  String get executiveHrOverview => '人事管理概览';

  @override
  String get staffProfile => '员工资料';

  @override
  String get checkIn => '签到';

  @override
  String get checkOut => '签退';

  @override
  String get checkInNow => '立即签到';

  @override
  String get present => '出勤';

  @override
  String get absent => '缺勤';

  @override
  String get workingHours => '工作时间';

  @override
  String get attendanceHistory => '考勤记录';

  @override
  String get todayAttendance => '今日考勤';

  @override
  String get notCheckedIn => '未签到';

  @override
  String inAt(Object time) {
    return '签到时间 $time';
  }

  @override
  String workedDuration(Object duration) {
    return '已工作 $duration';
  }

  @override
  String get ongoing => '进行中';

  @override
  String get applyLeave => '申请请假';

  @override
  String get leaveType => '请假类型';

  @override
  String get startDate => '开始日期';

  @override
  String get endDate => '结束日期';

  @override
  String get reason => '原因';

  @override
  String get pending => '待处理';

  @override
  String get approved => '已批准';

  @override
  String get rejected => '已拒绝';

  @override
  String get unableSubmitLeave => '无法提交请假：用户未登录。';

  @override
  String get leaveSubmitted => '请假申请已提交。';

  @override
  String leaveDays(Object count) {
    return '$count 天';
  }

  @override
  String get manageLeaveRequests => '管理请假申请';

  @override
  String get noPendingLeaveRequests => '暂无待处理的请假申请。';

  @override
  String periodRange(Object start, Object end) {
    return '期间：$start - $end';
  }

  @override
  String get approveLeave => '批准请假';

  @override
  String get rejectLeave => '拒绝请假';

  @override
  String leaveStatusSuccess(Object status) {
    return '请假已$status。';
  }

  @override
  String get pleaseSignInToViewSalary => '请登录以查看薪资详情。';

  @override
  String get salaryOverview => '薪资概览';

  @override
  String get generatePayroll => '生成工资单';

  @override
  String get manageSalaryRequests => '管理薪资申请';

  @override
  String get requestSalary => '申请薪资';

  @override
  String get salaryHistory => '薪资记录';

  @override
  String get noSalaryRecords => '暂无薪资记录';

  @override
  String get noSalaryRecordsSubtitle => '已生成或已发放的薪资将显示在此处。';

  @override
  String get unableToLoadSalaryHistory => '无法加载薪资记录，请重试。';

  @override
  String get basicSalary => '基本工资';

  @override
  String get presentDays => '出勤天数';

  @override
  String get estimatedPay => '预计薪资';

  @override
  String get deductions => '扣款';

  @override
  String get unableToLoadSalaryPreview => '无法加载薪资预览，请重试。';

  @override
  String get payrollGenerated => '工资单已生成！';

  @override
  String monthYearSalary(Object monthYear) {
    return '$monthYear 薪资';
  }

  @override
  String get netPay => '实发工资';

  @override
  String get attendancePercentage => '出勤率 %';

  @override
  String get baseSalary => '基本工资';

  @override
  String get noPendingSalaryRequests => '暂无待处理的薪资申请。';

  @override
  String get amount => '金额';

  @override
  String get staffName => 'Staff Name';

  @override
  String get requestDate => 'Request Date';

  @override
  String get reject => '拒绝';

  @override
  String get approve => '批准';

  @override
  String get approveRequest => '批准申请';

  @override
  String get rejectRequest => '拒绝申请';

  @override
  String get adminRemark => '管理员备注';

  @override
  String requestStatusSuccessfully(Object status) {
    return '申请已$status。';
  }

  @override
  String get newSalaryRequest => '新建薪资申请';

  @override
  String get sendRequest => '提交申请';

  @override
  String get requestHistory => '申请记录';

  @override
  String get noSalaryRequestsYet => '暂无薪资申请。';

  @override
  String get salaryRequestSubmitted => '薪资申请提交成功。';

  @override
  String salaryRequestFailed(Object error) {
    return '申请失败：$error';
  }

  @override
  String get pleaseSignInSalaryRequests => '请登录以查看薪资申请。';

  @override
  String requestedDate(Object date) {
    return '申请日期：$date';
  }

  @override
  String adminNote(Object note) {
    return '管理员备注：$note';
  }

  @override
  String get addProduct => '添加商品';

  @override
  String get editProduct => '编辑商品';

  @override
  String get deleteProduct => '删除商品';

  @override
  String deleteProductConfirm(Object name) {
    return '确定要删除「$name」吗？';
  }

  @override
  String productDeleted(Object name) {
    return '$name 已删除';
  }

  @override
  String get productName => '商品名称';

  @override
  String get brand => '品牌';

  @override
  String get model => '型号';

  @override
  String get price => '价格';

  @override
  String get stock => '库存';

  @override
  String get available => '有货';

  @override
  String get outOfStock => '缺货';

  @override
  String get saveProduct => '保存商品';

  @override
  String get productAdded => '商品添加成功。';

  @override
  String get productUpdated => '商品更新成功';

  @override
  String get productAddedShort => '商品添加成功';

  @override
  String get productUpdatedShort => '商品更新成功';

  @override
  String brandLabel(Object brand) {
    return '品牌：$brand';
  }

  @override
  String modelLabel(Object model) {
    return '型号：$model';
  }

  @override
  String priceLabel(Object price) {
    return '价格：$price';
  }

  @override
  String stockLabel(Object quantity) {
    return '库存：$quantity';
  }

  @override
  String stockCount(Object count) {
    return '剩余 $count';
  }

  @override
  String profitLabel(Object amount) {
    return '利润：$amount';
  }

  @override
  String get qtyLabel => '数量：';

  @override
  String get barcodeLabel => '条形码：';

  @override
  String get warranty => '保修';

  @override
  String get warrantyManagement => '保修管理';

  @override
  String get addWarranty => '添加保修';

  @override
  String get warrantyDuration => '保修期限';

  @override
  String warrantyMonths(Object months) {
    return '$months 个月';
  }

  @override
  String warrantyMonthsShort(Object months) {
    return '$months 个月';
  }

  @override
  String get warrantyLabel => '保修：';

  @override
  String get pleaseEnterProductName => '请输入商品名称。';

  @override
  String get warrantyAdded => '保修添加成功。';

  @override
  String get warrantyDetails => '保修详情';

  @override
  String get deleteWarranty => '删除保修';

  @override
  String get fileClaim => '提交索赔';

  @override
  String get voidWarranty => '作废保修';

  @override
  String get claimHistory => '索赔记录';

  @override
  String costLabel(Object amount) {
    return '费用：$amount';
  }

  @override
  String get active => '有效';

  @override
  String get expired => '已过期';

  @override
  String get expiryDate => '到期日期';

  @override
  String customerLabel(Object name) {
    return '客户：$name';
  }

  @override
  String get bundles => '套装';

  @override
  String get bundleName => '套装名称';

  @override
  String get createBundle => '创建套装';

  @override
  String get sellBundle => '销售套装';

  @override
  String get bundleNotFound => '未找到套装。';

  @override
  String get itemsInBundle => '套装内商品';

  @override
  String get addItem => '添加商品';

  @override
  String get includedItems => '包含商品';

  @override
  String get bundlePrice => '套装价格';

  @override
  String get subtotal => '小计';

  @override
  String get finalPrice => '最终价格';

  @override
  String get discount => '折扣';

  @override
  String discountPercent(Object percent) {
    return '折扣（$percent%）';
  }

  @override
  String insufficientStock(Object product) {
    return '$product 库存不足';
  }

  @override
  String bundleSold(Object name) {
    return '套装已售出：$name';
  }

  @override
  String get productBundles => '商品套装';

  @override
  String get payment => '支付';

  @override
  String get paymentConfirmation => '支付确认';

  @override
  String get paymentProof => '支付凭证';

  @override
  String get paymentMethod => '支付方式';

  @override
  String get paymentBreakdown => '支付明细';

  @override
  String get cash => '现金';

  @override
  String get card => '银行卡';

  @override
  String get transfer => '转账';

  @override
  String get jazzCash => 'JazzCash';

  @override
  String get easyPaisa => 'EasyPaisa';

  @override
  String get credit => '赊账';

  @override
  String get accountNumber => '账号';

  @override
  String get notesOptional => '备注（可选）';

  @override
  String get cardReferenceNumber => '银行卡参考号';

  @override
  String get confirmSale => '确认销售';

  @override
  String get totalPrice => '总价';

  @override
  String get selectProductFirst => '请先选择商品。';

  @override
  String onePointDiscount(Object amount) {
    return '1 积分 = $amount 折扣';
  }

  @override
  String get salesScreen => '销售界面';

  @override
  String get sendReceipt => '发送收据';

  @override
  String get sendViaWhatsApp => '通过 WhatsApp 发送';

  @override
  String get sendViaEmail => '通过邮件发送';

  @override
  String get sendViaSms => '通过短信发送';

  @override
  String get share => '分享';

  @override
  String get sendToPhoneNumber => '发送至手机号';

  @override
  String get phoneNumberHint => '请输入有效的手机号码以发送收据。';

  @override
  String get send => '发送';

  @override
  String get emailNotAvailable => '邮箱地址不可用。';

  @override
  String get newSale => '新销售';

  @override
  String get orderDetails => '订单详情';

  @override
  String get orderNumber => '订单 #';

  @override
  String get quantity => '数量';

  @override
  String get total => '合计';

  @override
  String get customer => '客户';

  @override
  String get viewDetails => '查看详情';

  @override
  String get walkInCustomer => '散客';

  @override
  String get manage => '管理';

  @override
  String get customers => '客户';

  @override
  String get deleteCustomer => '删除客户？';

  @override
  String get searchCustomers => '按姓名或电话搜索...';

  @override
  String get noCustomersFound => '未找到客户';

  @override
  String get repayCredit => '偿还赊账';

  @override
  String get repay => '还款';

  @override
  String get phone => '电话';

  @override
  String get address => '地址';

  @override
  String get repeatCustomer => '回头客';

  @override
  String get favoriteProducts => '常购商品';

  @override
  String get noPurchasesYet => '暂无购买记录';

  @override
  String get addCustomer => '添加客户';

  @override
  String get updateCustomer => '更新客户';

  @override
  String pointsEarned(Object points) {
    return '+$points 积分';
  }

  @override
  String get reports => '报表';

  @override
  String get noDataToExport => '没有可导出的数据。';

  @override
  String get recentTransactions => '最近交易';

  @override
  String get noTransactionsPeriod => '该时段暂无交易。';

  @override
  String get bestSellingProducts => '畅销商品';

  @override
  String get profitWord => '利润';

  @override
  String get firebaseBackups => 'Firebase 备份';

  @override
  String get noBackupsFound => '未找到备份';

  @override
  String get restoreBackup => '恢复备份';

  @override
  String get restoreBackupConfirm => '这将替换本地数据，是否继续？';

  @override
  String get backupHistory => '备份记录';

  @override
  String get notificationSettings => '通知设置';

  @override
  String get enableNotifications => '启用通知';

  @override
  String get lowStockWarnings => '低库存提醒';

  @override
  String get dailySalesReminder => '每日销售提醒';

  @override
  String get exportLocalBackup => '导出本地备份';

  @override
  String get backupToFirebase => '备份到 Firebase';

  @override
  String get restoreFromFirebase => '从 Firebase 恢复';

  @override
  String get notificationSettingsComingSoon => '通知设置即将推出！';

  @override
  String get settings => '设置';

  @override
  String get appearance => '外观';

  @override
  String get language => '语言';

  @override
  String get currency => '货币';

  @override
  String get notifications => '通知';

  @override
  String get selectLanguage => '选择语言';

  @override
  String get selectCurrency => '选择货币';

  @override
  String get searchCurrency => '搜索货币...';

  @override
  String get searchLanguage => '搜索语言...';

  @override
  String get general => '通用';

  @override
  String get account => '账户';

  @override
  String get theme => '主题';

  @override
  String get light => '浅色';

  @override
  String get dark => '深色';

  @override
  String get systemDefault => '跟随系统';

  @override
  String get about => '关于';

  @override
  String get shopTools => '商店工具';

  @override
  String get shopToolsSubtitle => '保修、套装、报表和账户设置';

  @override
  String get editProfile => '编辑资料';

  @override
  String get unableToLoadProfile => '无法加载资料，请重试。';

  @override
  String get accessDenied => '访问被拒绝';

  @override
  String get accessDeniedMessage =>
      'You do not have permission to access this page.\nPlease contact your administrator.';

  @override
  String get goBack => '返回';

  @override
  String get cancel => '取消';

  @override
  String get save => '保存';

  @override
  String get submit => '提交';

  @override
  String get delete => '删除';

  @override
  String get edit => '编辑';

  @override
  String get view => '查看';

  @override
  String get close => '关闭';

  @override
  String get update => '更新';

  @override
  String errorGeneric(Object error) {
    return '错误：$error';
  }

  @override
  String get continueAction => '继续';

  @override
  String get yes => '是';

  @override
  String get no => '否';

  @override
  String get ok => '确定';

  @override
  String get onboardingTitle => '欢迎使用手机商店';

  @override
  String get onboardingSubtitle => '选择语言和货币以个性化应用。';

  @override
  String get chooseLanguage => '选择语言';

  @override
  String get chooseCurrency => '选择货币';

  @override
  String get getStarted => '开始使用';

  @override
  String get languageNameEnglish => '英语';

  @override
  String get languageNameUrdu => '乌尔都语';

  @override
  String get languageNameArabic => '阿拉伯语';

  @override
  String get languageNameSpanish => '西班牙语';

  @override
  String get languageNameFrench => '法语';

  @override
  String get languageNameGerman => '德语';

  @override
  String get languageNameChinese => '中文';

  @override
  String get languageNameTurkish => '土耳其语';
}

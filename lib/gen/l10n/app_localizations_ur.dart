// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'موبائل شاپ';

  @override
  String get appSubtitle => 'پیشہ ورانہ POS اور عملے کا انتظام';

  @override
  String get appFullTitle => 'موبائل شاپ POS';

  @override
  String get versionLabel => 'ورژن 1.0.0';

  @override
  String get welcomeBack => 'خوش آمدید';

  @override
  String get signInSubtitle =>
      'اپنے موبائل شاپ اکاؤنٹ میں داخل ہونے کے لیے سائن ان کریں';

  @override
  String get email => 'ای میل';

  @override
  String get password => 'پاس ورڈ';

  @override
  String get confirmPassword => 'پاس ورڈ کی تصدیق';

  @override
  String get rememberMe => 'مجھے یاد رکھیں';

  @override
  String get forgotPassword => 'پاس ورڈ بھول گئے؟';

  @override
  String get login => 'لاگ ان';

  @override
  String get logout => 'لاگ آؤٹ';

  @override
  String get createAccount => 'اکاؤنٹ بنائیں';

  @override
  String get dontHaveAccount => 'اکاؤنٹ نہیں ہے؟';

  @override
  String get alreadyHaveAccount => 'پہلے سے اکاؤنٹ ہے؟';

  @override
  String get register => 'رجسٹر';

  @override
  String get passwordsDoNotMatch => 'پاس ورڈ مماثل نہیں ہیں';

  @override
  String get accountCreated => 'اکاؤنٹ کامیابی سے بن گیا۔';

  @override
  String get unableToSignIn =>
      'سائن ان نہیں ہو سکا۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get unableToCreateAccount =>
      'اکاؤنٹ نہیں بن سکا۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get resetPassword => 'پاس ورڈ ری سیٹ';

  @override
  String get resetPasswordInstructions =>
      'Enter your email address and we\'ll send you a link to reset your password.';

  @override
  String get sendResetLink => 'ری سیٹ لنک بھیجیں';

  @override
  String get resetLinkSent =>
      'پاس ورڈ ری سیٹ لنک آپ کی ای میل پر بھیج دیا گیا۔';

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
  String get logoutConfirm => 'کیا آپ واقعی سائن آؤٹ کرنا چاہتے ہیں؟';

  @override
  String get dashboard => 'ڈیش بورڈ';

  @override
  String get home => 'ہوم';

  @override
  String get products => 'مصنوعات';

  @override
  String get orders => 'آرڈرز';

  @override
  String get staff => 'عملہ';

  @override
  String get more => 'مزید';

  @override
  String get attendance => 'حاضری';

  @override
  String get leave => 'چھٹی';

  @override
  String get salary => 'تنخواہ';

  @override
  String get profile => 'پروفائل';

  @override
  String get sales => 'فروخت';

  @override
  String get welcome => 'خوش آمدید';

  @override
  String get quickActions => 'فوری اقدامات';

  @override
  String get goodMorning => 'صبح بخیر';

  @override
  String get goodAfternoon => 'دوپہر بخیر';

  @override
  String get goodEvening => 'شام بخیر';

  @override
  String get viewAll => 'سب دیکھیں';

  @override
  String get startNewSale => 'نئی فروخت شروع کریں';

  @override
  String get leaveRequests => 'چھٹی کی درخواستیں';

  @override
  String get salaryRequests => 'تنخواہ کی درخواستیں';

  @override
  String get noRecentOrders => 'ابھی تک کوئی حالیہ آرڈر نہیں۔';

  @override
  String get allProductsStocked => 'تمام مصنوعات کی مناسب اسٹاک موجود ہے۔';

  @override
  String get loadingDashboard => 'ڈیش بورڈ لوڈ ہو رہا ہے...';

  @override
  String get periodDaily => 'د';

  @override
  String get periodWeekly => 'ہ';

  @override
  String get periodMonthly => 'م';

  @override
  String get periodDailyFull => 'روزانہ';

  @override
  String get periodWeeklyFull => 'ہفتہ وار';

  @override
  String get periodMonthlyFull => 'ماہانہ';

  @override
  String get periodYearly => 'سالانہ';

  @override
  String get manageStaff => 'عملے کا انتظام';

  @override
  String get employee => 'ملازم';

  @override
  String get administrator => 'منتظم';

  @override
  String get admin => 'ایڈمن';

  @override
  String get user => 'صارف';

  @override
  String get addStaff => 'عملہ شامل کریں';

  @override
  String get monthlySalary => 'ماہانہ تنخواہ';

  @override
  String get useSignupForStaff => 'نئے عملے کے لیے سائن اپ اسکرین استعمال کریں';

  @override
  String get editProfileComingSoon => 'پروفائل میں ترمیم جلد آ رہی ہے';

  @override
  String updateStaffSalary(Object name) {
    return '$name کی تنخواہ اپ ڈیٹ کریں';
  }

  @override
  String get hrDashboard => 'HR ڈیش بورڈ';

  @override
  String get executiveHrOverview => 'انتظامی HR جائزہ';

  @override
  String get staffProfile => 'عملے کی پروفائل';

  @override
  String get checkIn => 'حاضری درج';

  @override
  String get checkOut => 'رخصت';

  @override
  String get checkInNow => 'ابھی حاضری درج کریں';

  @override
  String get present => 'حاضر';

  @override
  String get absent => 'غیر حاضر';

  @override
  String get workingHours => 'کام کے اوقات';

  @override
  String get attendanceHistory => 'حاضری کی تاریخ';

  @override
  String get todayAttendance => 'آج کی حاضری';

  @override
  String get notCheckedIn => 'حاضری درج نہیں';

  @override
  String inAt(Object time) {
    return '$time پر آئے';
  }

  @override
  String workedDuration(Object duration) {
    return '$duration کام کیا';
  }

  @override
  String get ongoing => 'جاری';

  @override
  String get applyLeave => 'چھٹی کی درخواست';

  @override
  String get leaveType => 'چھٹی کی قسم';

  @override
  String get startDate => 'شروع کی تاریخ';

  @override
  String get endDate => 'اختتام کی تاریخ';

  @override
  String get reason => 'وجہ';

  @override
  String get pending => 'زیر التواء';

  @override
  String get approved => 'منظور';

  @override
  String get rejected => 'مسترد';

  @override
  String get unableSubmitLeave =>
      'چھٹی جمع نہیں ہو سکی: کوئی تصدیق شدہ صارف نہیں۔';

  @override
  String get leaveSubmitted => 'چھٹی کی درخواست جمع ہو گئی۔';

  @override
  String leaveDays(Object count) {
    return '$count دن';
  }

  @override
  String get manageLeaveRequests => 'چھٹی کی درخواستوں کا انتظام';

  @override
  String get noPendingLeaveRequests => 'کوئی زیر التواء چھٹی کی درخواست نہیں۔';

  @override
  String periodRange(Object start, Object end) {
    return 'مدت: $start - $end';
  }

  @override
  String get approveLeave => 'چھٹی منظور کریں';

  @override
  String get rejectLeave => 'چھٹی مسترد کریں';

  @override
  String leaveStatusSuccess(Object status) {
    return 'چھٹی $status ہو گئی۔';
  }

  @override
  String get pleaseSignInToViewSalary =>
      'تنخواہ کی تفصیلات دیکھنے کے لیے سائن ان کریں۔';

  @override
  String get salaryOverview => 'تنخواہ کا جائزہ';

  @override
  String get generatePayroll => 'پے رول بنائیں';

  @override
  String get manageSalaryRequests => 'تنخواہ کی درخواستوں کا انتظام';

  @override
  String get requestSalary => 'تنخواہ کی درخواست';

  @override
  String get salaryHistory => 'تنخواہ کی تاریخ';

  @override
  String get noSalaryRecords => 'کوئی تنخواہ کا ریکارڈ نہیں';

  @override
  String get noSalaryRecordsSubtitle =>
      'بنائی یا ادا کی گئی تنخواہیں یہاں ظاہر ہوں گی۔';

  @override
  String get unableToLoadSalaryHistory =>
      'تنخواہ کی تاریخ لوڈ نہیں ہو سکی۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get basicSalary => 'بنیادی تنخواہ';

  @override
  String get presentDays => 'حاضری کے دن';

  @override
  String get estimatedPay => 'تخمینی ادائیگی';

  @override
  String get deductions => 'کٹوتیاں';

  @override
  String get unableToLoadSalaryPreview =>
      'تنخواہ کا پیش نظارہ لوڈ نہیں ہو سکا۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get payrollGenerated => 'پے رول بن گیا!';

  @override
  String monthYearSalary(Object monthYear) {
    return '$monthYear کی تنخواہ';
  }

  @override
  String get netPay => 'خالص ادائیگی';

  @override
  String get attendancePercentage => 'حاضری %';

  @override
  String get baseSalary => 'بنیادی تنخواہ';

  @override
  String get noPendingSalaryRequests =>
      'کوئی زیر التواء تنخواہ کی درخواست نہیں۔';

  @override
  String get amount => 'رقم';

  @override
  String get staffName => 'Staff Name';

  @override
  String get requestDate => 'Request Date';

  @override
  String get reject => 'مسترد';

  @override
  String get approve => 'منظور';

  @override
  String get approveRequest => 'درخواست منظور کریں';

  @override
  String get rejectRequest => 'درخواست مسترد کریں';

  @override
  String get adminRemark => 'ایڈمن کا تبصرہ';

  @override
  String requestStatusSuccessfully(Object status) {
    return 'درخواست $status ہو گئی۔';
  }

  @override
  String get newSalaryRequest => 'نئی تنخواہ کی درخواست';

  @override
  String get sendRequest => 'درخواست بھیجیں';

  @override
  String get requestHistory => 'درخواستوں کی تاریخ';

  @override
  String get noSalaryRequestsYet => 'ابھی تک کوئی تنخواہ کی درخواست نہیں۔';

  @override
  String get salaryRequestSubmitted =>
      'تنخواہ کی درخواست کامیابی سے جمع ہو گئی۔';

  @override
  String salaryRequestFailed(Object error) {
    return 'درخواست ناکام: $error';
  }

  @override
  String get pleaseSignInSalaryRequests =>
      'تنخواہ کی درخواستیں دیکھنے کے لیے سائن ان کریں۔';

  @override
  String requestedDate(Object date) {
    return 'درخواست کی تاریخ: $date';
  }

  @override
  String adminNote(Object note) {
    return 'ایڈمن نوٹ: $note';
  }

  @override
  String get addProduct => 'مصنوعات شامل کریں';

  @override
  String get editProduct => 'مصنوعات میں ترمیم';

  @override
  String get deleteProduct => 'مصنوعات حذف کریں';

  @override
  String deleteProductConfirm(Object name) {
    return 'کیا آپ واقعی \"$name\" حذف کرنا چاہتے ہیں؟';
  }

  @override
  String productDeleted(Object name) {
    return '$name کامیابی سے حذف ہو گیا';
  }

  @override
  String get productName => 'مصنوعات کا نام';

  @override
  String get brand => 'برانڈ';

  @override
  String get model => 'ماڈل';

  @override
  String get price => 'قیمت';

  @override
  String get stock => 'اسٹاک';

  @override
  String get available => 'دستیاب';

  @override
  String get outOfStock => 'اسٹاک ختم';

  @override
  String get saveProduct => 'مصنوعات محفوظ کریں';

  @override
  String get productAdded => 'مصنوعات کامیابی سے شامل ہو گئی۔';

  @override
  String get productUpdated => 'مصنوعات کامیابی سے اپ ڈیٹ ہو گئی';

  @override
  String get productAddedShort => 'مصنوعات کامیابی سے شامل ہو گئی';

  @override
  String get productUpdatedShort => 'مصنوعات کامیابی سے اپ ڈیٹ ہو گئی';

  @override
  String brandLabel(Object brand) {
    return 'برانڈ: $brand';
  }

  @override
  String modelLabel(Object model) {
    return 'ماڈل: $model';
  }

  @override
  String priceLabel(Object price) {
    return 'قیمت: $price';
  }

  @override
  String stockLabel(Object quantity) {
    return 'اسٹاک: $quantity';
  }

  @override
  String stockCount(Object count) {
    return '$count باقی';
  }

  @override
  String profitLabel(Object amount) {
    return 'منافع: $amount';
  }

  @override
  String get qtyLabel => 'مقدار:';

  @override
  String get barcodeLabel => 'بارکوڈ:';

  @override
  String get warranty => 'وارنٹی';

  @override
  String get warrantyManagement => 'وارنٹی کا انتظام';

  @override
  String get addWarranty => 'وارنٹی شامل کریں';

  @override
  String get warrantyDuration => 'وارنٹی کی مدت';

  @override
  String warrantyMonths(Object months) {
    return '$months ماہ';
  }

  @override
  String warrantyMonthsShort(Object months) {
    return '$months ماہ';
  }

  @override
  String get warrantyLabel => 'وارنٹی:';

  @override
  String get pleaseEnterProductName => 'براہ کرم مصنوعات کا نام درج کریں۔';

  @override
  String get warrantyAdded => 'وارنٹی کامیابی سے شامل ہو گئی۔';

  @override
  String get warrantyDetails => 'وارنٹی کی تفصیلات';

  @override
  String get deleteWarranty => 'وارنٹی حذف کریں';

  @override
  String get fileClaim => 'دعویٰ درج کریں';

  @override
  String get voidWarranty => 'وارنٹی منسوخ کریں';

  @override
  String get claimHistory => 'دعویٰ کی تاریخ';

  @override
  String costLabel(Object amount) {
    return 'لاگت: $amount';
  }

  @override
  String get active => 'فعال';

  @override
  String get expired => 'میعاد ختم';

  @override
  String get expiryDate => 'میعاد ختم ہونے کی تاریخ';

  @override
  String customerLabel(Object name) {
    return 'گاہک: $name';
  }

  @override
  String get bundles => 'بنڈلز';

  @override
  String get bundleName => 'بنڈل کا نام';

  @override
  String get createBundle => 'بنڈل بنائیں';

  @override
  String get sellBundle => 'بنڈل فروخت کریں';

  @override
  String get bundleNotFound => 'بنڈل نہیں ملا۔';

  @override
  String get itemsInBundle => 'بنڈل میں اشیاء';

  @override
  String get addItem => 'شے شامل کریں';

  @override
  String get includedItems => 'شامل اشیاء';

  @override
  String get bundlePrice => 'بنڈل کی قیمت';

  @override
  String get subtotal => 'ذیلی کل';

  @override
  String get finalPrice => 'حتمی قیمت';

  @override
  String get discount => 'رعایت';

  @override
  String discountPercent(Object percent) {
    return 'رعایت ($percent%)';
  }

  @override
  String insufficientStock(Object product) {
    return '$product کے لیے ناکافی اسٹاک';
  }

  @override
  String bundleSold(Object name) {
    return 'بنڈل فروخت ہوا: $name';
  }

  @override
  String get productBundles => 'مصنوعات کے بنڈلز';

  @override
  String get payment => 'ادائیگی';

  @override
  String get paymentConfirmation => 'ادائیگی کی تصدیق';

  @override
  String get paymentProof => 'ادائیگی کا ثبوت';

  @override
  String get paymentMethod => 'ادائیگی کا طریقہ';

  @override
  String get paymentBreakdown => 'ادائیگی کی تفصیل';

  @override
  String get cash => 'نقد';

  @override
  String get card => 'کارڈ';

  @override
  String get transfer => 'منتقلی';

  @override
  String get jazzCash => 'JazzCash';

  @override
  String get easyPaisa => 'EasyPaisa';

  @override
  String get credit => 'ادھار';

  @override
  String get accountNumber => 'اکاؤنٹ نمبر';

  @override
  String get notesOptional => 'نوٹس (اختیاری)';

  @override
  String get cardReferenceNumber => 'کارڈ حوالہ نمبر';

  @override
  String get confirmSale => 'فروخت کی تصدیق';

  @override
  String get totalPrice => 'کل قیمت';

  @override
  String get selectProductFirst => 'پہلے مصنوعات منتخب کریں۔';

  @override
  String onePointDiscount(Object amount) {
    return '1 پوائنٹ = $amount رعایت';
  }

  @override
  String get salesScreen => 'فروخت کی اسکرین';

  @override
  String get sendReceipt => 'رسید بھیجیں';

  @override
  String get sendViaWhatsApp => 'WhatsApp کے ذریعے بھیجیں';

  @override
  String get sendViaEmail => 'ای میل کے ذریعے بھیجیں';

  @override
  String get sendViaSms => 'SMS کے ذریعے بھیجیں';

  @override
  String get share => 'شیئر کریں';

  @override
  String get sendToPhoneNumber => 'فون نمبر پر بھیجیں';

  @override
  String get phoneNumberHint => 'رسید بھیجنے کے لیے درست فون نمبر درج کریں۔';

  @override
  String get send => 'بھیجیں';

  @override
  String get emailNotAvailable => 'ای میل ایڈریس دستیاب نہیں۔';

  @override
  String get newSale => 'نئی فروخت';

  @override
  String get orderDetails => 'آرڈر کی تفصیلات';

  @override
  String get orderNumber => 'آرڈر #';

  @override
  String get quantity => 'مقدار';

  @override
  String get total => 'کل';

  @override
  String get customer => 'گاہک';

  @override
  String get viewDetails => 'تفصیلات دیکھیں';

  @override
  String get walkInCustomer => 'واک ان گاہک';

  @override
  String get manage => 'انتظام';

  @override
  String get customers => 'گاہک';

  @override
  String get deleteCustomer => 'گاہک حذف کریں؟';

  @override
  String get searchCustomers => 'نام یا فون سے تلاش کریں...';

  @override
  String get noCustomersFound => 'کوئی گاہک نہیں ملا';

  @override
  String get repayCredit => 'ادھار واپس کریں';

  @override
  String get repay => 'واپس کریں';

  @override
  String get phone => 'فون';

  @override
  String get address => 'پتہ';

  @override
  String get repeatCustomer => 'بار بار آنے والا گاہک';

  @override
  String get favoriteProducts => 'پسندیدہ مصنوعات';

  @override
  String get noPurchasesYet => 'ابھی تک کوئی خریداری نہیں';

  @override
  String get addCustomer => 'گاہک شامل کریں';

  @override
  String get updateCustomer => 'گاہک اپ ڈیٹ کریں';

  @override
  String pointsEarned(Object points) {
    return '+$points پوائنٹس';
  }

  @override
  String get reports => 'رپورٹس';

  @override
  String get noDataToExport => 'برآمد کے لیے کوئی ڈیٹا نہیں۔';

  @override
  String get recentTransactions => 'حالیہ لین دین';

  @override
  String get noTransactionsPeriod => 'اس مدت کے لیے کوئی لین دین نہیں۔';

  @override
  String get bestSellingProducts => 'سب سے زیادہ فروخت ہونے والی مصنوعات';

  @override
  String get profitWord => 'منافع';

  @override
  String get firebaseBackups => 'Firebase بیک اپ';

  @override
  String get noBackupsFound => 'کوئی بیک اپ نہیں ملا';

  @override
  String get restoreBackup => 'بیک اپ بحال کریں';

  @override
  String get restoreBackupConfirm =>
      'یہ مقامی ڈیٹا کو تبدیل کر دے گا۔ جاری رکھیں؟';

  @override
  String get backupHistory => 'بیک اپ کی تاریخ';

  @override
  String get notificationSettings => 'اطلاعات کی ترتیبات';

  @override
  String get enableNotifications => 'اطلاعات فعال کریں';

  @override
  String get lowStockWarnings => 'کم اسٹاک کی تنبیہات';

  @override
  String get dailySalesReminder => 'روزانہ فروخت کی یاد دہانی';

  @override
  String get exportLocalBackup => 'مقامی بیک اپ برآمد کریں';

  @override
  String get backupToFirebase => 'Firebase پر بیک اپ';

  @override
  String get restoreFromFirebase => 'Firebase سے بحال کریں';

  @override
  String get notificationSettingsComingSoon =>
      'اطلاعات کی ترتیبات جلد آ رہی ہیں!';

  @override
  String get settings => 'ترتیبات';

  @override
  String get appearance => 'ظاہری شکل';

  @override
  String get language => 'زبان';

  @override
  String get currency => 'کرنسی';

  @override
  String get notifications => 'اطلاعات';

  @override
  String get selectLanguage => 'زبان منتخب کریں';

  @override
  String get selectCurrency => 'کرنسی منتخب کریں';

  @override
  String get searchCurrency => 'کرنسی تلاش کریں...';

  @override
  String get searchLanguage => 'زبان تلاش کریں...';

  @override
  String get general => 'عمومی';

  @override
  String get account => 'اکاؤنٹ';

  @override
  String get theme => 'تھیم';

  @override
  String get light => 'روشن';

  @override
  String get dark => 'تاریک';

  @override
  String get systemDefault => 'سسٹم ڈیفالٹ';

  @override
  String get about => 'متعلق';

  @override
  String get shopTools => 'شاپ کے اوزار';

  @override
  String get shopToolsSubtitle => 'وارنٹی، بنڈلز، رپورٹس اور اکاؤنٹ کی ترتیبات';

  @override
  String get editProfile => 'پروفائل میں ترمیم';

  @override
  String get unableToLoadProfile =>
      'پروفائل لوڈ نہیں ہو سکی۔ براہ کرم دوبارہ کوشش کریں۔';

  @override
  String get accessDenied => 'رسائی مسترد';

  @override
  String get accessDeniedMessage =>
      'You do not have permission to access this page.\nPlease contact your administrator.';

  @override
  String get goBack => 'واپس جائیں';

  @override
  String get cancel => 'منسوخ';

  @override
  String get save => 'محفوظ';

  @override
  String get submit => 'جمع کرائیں';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'ترمیم';

  @override
  String get view => 'دیکھیں';

  @override
  String get close => 'بند';

  @override
  String get update => 'اپ ڈیٹ';

  @override
  String errorGeneric(Object error) {
    return 'خرابی: $error';
  }

  @override
  String get continueAction => 'جاری رکھیں';

  @override
  String get yes => 'ہاں';

  @override
  String get no => 'نہیں';

  @override
  String get ok => 'ٹھیک ہے';

  @override
  String get onboardingTitle => 'موبائل شاپ میں خوش آمدید';

  @override
  String get onboardingSubtitle =>
      'ایپ کو ذاتی بنانے کے لیے اپنی زبان اور کرنسی منتخب کریں۔';

  @override
  String get chooseLanguage => 'زبان منتخب کریں';

  @override
  String get chooseCurrency => 'کرنسی منتخب کریں';

  @override
  String get getStarted => 'شروع کریں';

  @override
  String get languageNameEnglish => 'انگریزی';

  @override
  String get languageNameUrdu => 'اردو';

  @override
  String get languageNameArabic => 'عربی';

  @override
  String get languageNameSpanish => 'ہسپانوی';

  @override
  String get languageNameFrench => 'فرانسیسی';

  @override
  String get languageNameGerman => 'جرمن';

  @override
  String get languageNameChinese => 'چینی';

  @override
  String get languageNameTurkish => 'ترکی';
}

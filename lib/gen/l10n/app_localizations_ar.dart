// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'متجر الجوال';

  @override
  String get appSubtitle => 'نقطة بيع احترافية وإدارة الموظفين';

  @override
  String get appFullTitle => 'متجر الجوال POS';

  @override
  String get versionLabel => 'الإصدار 1.0.0';

  @override
  String get welcomeBack => 'مرحباً بعودتك';

  @override
  String get signInSubtitle => 'سجّل الدخول للمتابعة إلى حساب متجر الجوال';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get rememberMe => 'تذكرني';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟';

  @override
  String get register => 'التسجيل';

  @override
  String get passwordsDoNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get accountCreated => 'تم إنشاء الحساب بنجاح.';

  @override
  String get unableToSignIn => 'تعذّر تسجيل الدخول. يرجى المحاولة مرة أخرى.';

  @override
  String get unableToCreateAccount =>
      'تعذّر إنشاء الحساب. يرجى المحاولة مرة أخرى.';

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get resetPasswordInstructions =>
      'Enter your email address and we\'ll send you a link to reset your password.';

  @override
  String get sendResetLink => 'إرسال رابط إعادة التعيين';

  @override
  String get resetLinkSent =>
      'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني.';

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
  String get logoutConfirm => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get dashboard => 'لوحة التحكم';

  @override
  String get home => 'الرئيسية';

  @override
  String get products => 'المنتجات';

  @override
  String get orders => 'الطلبات';

  @override
  String get staff => 'الموظفون';

  @override
  String get more => 'المزيد';

  @override
  String get attendance => 'الحضور';

  @override
  String get leave => 'الإجازة';

  @override
  String get salary => 'الراتب';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get sales => 'المبيعات';

  @override
  String get welcome => 'مرحباً';

  @override
  String get quickActions => 'إجراءات سريعة';

  @override
  String get goodMorning => 'صباح الخير';

  @override
  String get goodAfternoon => 'مساء الخير';

  @override
  String get goodEvening => 'مساء الخير';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get startNewSale => 'بدء عملية بيع جديدة';

  @override
  String get leaveRequests => 'طلبات الإجازة';

  @override
  String get salaryRequests => 'طلبات الراتب';

  @override
  String get noRecentOrders => 'لا توجد طلبات حديثة بعد.';

  @override
  String get allProductsStocked => 'جميع المنتجات متوفرة بكميات كافية.';

  @override
  String get loadingDashboard => 'جارٍ تحميل لوحة التحكم...';

  @override
  String get periodDaily => 'ي';

  @override
  String get periodWeekly => 'أ';

  @override
  String get periodMonthly => 'ش';

  @override
  String get periodDailyFull => 'يومي';

  @override
  String get periodWeeklyFull => 'أسبوعي';

  @override
  String get periodMonthlyFull => 'شهري';

  @override
  String get periodYearly => 'سنوي';

  @override
  String get manageStaff => 'إدارة الموظفين';

  @override
  String get employee => 'موظف';

  @override
  String get administrator => 'مسؤول';

  @override
  String get admin => 'مدير';

  @override
  String get user => 'مستخدم';

  @override
  String get addStaff => 'إضافة موظف';

  @override
  String get monthlySalary => 'الراتب الشهري';

  @override
  String get useSignupForStaff => 'استخدم شاشة التسجيل للموظفين الجدد';

  @override
  String get editProfileComingSoon => 'تعديل الملف الشخصي قريباً';

  @override
  String updateStaffSalary(Object name) {
    return 'تحديث راتب $name';
  }

  @override
  String get hrDashboard => 'لوحة الموارد البشرية';

  @override
  String get executiveHrOverview => 'نظرة تنفيذية على الموارد البشرية';

  @override
  String get staffProfile => 'ملف الموظف';

  @override
  String get checkIn => 'تسجيل الحضور';

  @override
  String get checkOut => 'تسجيل الانصراف';

  @override
  String get checkInNow => 'سجّل الحضور الآن';

  @override
  String get present => 'حاضر';

  @override
  String get absent => 'غائب';

  @override
  String get workingHours => 'ساعات العمل';

  @override
  String get attendanceHistory => 'سجل الحضور';

  @override
  String get todayAttendance => 'حضور اليوم';

  @override
  String get notCheckedIn => 'لم يتم تسجيل الحضور';

  @override
  String inAt(Object time) {
    return 'دخول في $time';
  }

  @override
  String workedDuration(Object duration) {
    return 'عمل $duration';
  }

  @override
  String get ongoing => 'جارٍ';

  @override
  String get applyLeave => 'طلب إجازة';

  @override
  String get leaveType => 'نوع الإجازة';

  @override
  String get startDate => 'تاريخ البدء';

  @override
  String get endDate => 'تاريخ الانتهاء';

  @override
  String get reason => 'السبب';

  @override
  String get pending => 'قيد الانتظار';

  @override
  String get approved => 'موافق عليه';

  @override
  String get rejected => 'مرفوض';

  @override
  String get unableSubmitLeave =>
      'تعذّر تقديم طلب الإجازة: لا يوجد مستخدم مصادق عليه.';

  @override
  String get leaveSubmitted => 'تم تقديم طلب الإجازة.';

  @override
  String leaveDays(Object count) {
    return '$count يوم/أيام';
  }

  @override
  String get manageLeaveRequests => 'إدارة طلبات الإجازة';

  @override
  String get noPendingLeaveRequests => 'لا توجد طلبات إجازة قيد الانتظار.';

  @override
  String periodRange(Object start, Object end) {
    return 'الفترة: $start - $end';
  }

  @override
  String get approveLeave => 'الموافقة على الإجازة';

  @override
  String get rejectLeave => 'رفض الإجازة';

  @override
  String leaveStatusSuccess(Object status) {
    return 'تم $status الإجازة بنجاح.';
  }

  @override
  String get pleaseSignInToViewSalary =>
      'يرجى تسجيل الدخول لعرض تفاصيل الراتب.';

  @override
  String get salaryOverview => 'نظرة عامة على الراتب';

  @override
  String get generatePayroll => 'إنشاء كشف الرواتب';

  @override
  String get manageSalaryRequests => 'إدارة طلبات الراتب';

  @override
  String get requestSalary => 'طلب راتب';

  @override
  String get salaryHistory => 'سجل الرواتب';

  @override
  String get noSalaryRecords => 'لا توجد سجلات رواتب';

  @override
  String get noSalaryRecordsSubtitle =>
      'ستظهر الرواتب المُنشأة أو المدفوعة هنا.';

  @override
  String get unableToLoadSalaryHistory =>
      'تعذّر تحميل سجل الرواتب. يرجى المحاولة مرة أخرى.';

  @override
  String get basicSalary => 'الراتب الأساسي';

  @override
  String get presentDays => 'أيام الحضور';

  @override
  String get estimatedPay => 'الأجر المقدّر';

  @override
  String get deductions => 'الخصومات';

  @override
  String get unableToLoadSalaryPreview =>
      'تعذّر تحميل معاينة الراتب. يرجى المحاولة مرة أخرى.';

  @override
  String get payrollGenerated => 'تم إنشاء كشف الرواتب!';

  @override
  String monthYearSalary(Object monthYear) {
    return 'راتب $monthYear';
  }

  @override
  String get netPay => 'صافي الأجر';

  @override
  String get attendancePercentage => 'نسبة الحضور %';

  @override
  String get baseSalary => 'الراتب الأساسي';

  @override
  String get noPendingSalaryRequests => 'لا توجد طلبات راتب قيد الانتظار.';

  @override
  String get amount => 'المبلغ';

  @override
  String get staffName => 'Staff Name';

  @override
  String get requestDate => 'Request Date';

  @override
  String get reject => 'رفض';

  @override
  String get approve => 'موافقة';

  @override
  String get approveRequest => 'الموافقة على الطلب';

  @override
  String get rejectRequest => 'رفض الطلب';

  @override
  String get adminRemark => 'ملاحظة المدير';

  @override
  String requestStatusSuccessfully(Object status) {
    return 'تم $status الطلب بنجاح.';
  }

  @override
  String get newSalaryRequest => 'طلب راتب جديد';

  @override
  String get sendRequest => 'إرسال الطلب';

  @override
  String get requestHistory => 'سجل الطلبات';

  @override
  String get noSalaryRequestsYet => 'لا توجد طلبات راتب بعد.';

  @override
  String get salaryRequestSubmitted => 'تم تقديم طلب الراتب بنجاح.';

  @override
  String salaryRequestFailed(Object error) {
    return 'فشل الطلب: $error';
  }

  @override
  String get pleaseSignInSalaryRequests =>
      'يرجى تسجيل الدخول لعرض طلبات الراتب.';

  @override
  String requestedDate(Object date) {
    return 'تاريخ الطلب: $date';
  }

  @override
  String adminNote(Object note) {
    return 'ملاحظة المدير: $note';
  }

  @override
  String get addProduct => 'إضافة منتج';

  @override
  String get editProduct => 'تعديل المنتج';

  @override
  String get deleteProduct => 'حذف المنتج';

  @override
  String deleteProductConfirm(Object name) {
    return 'هل أنت متأكد أنك تريد حذف \"$name\"؟';
  }

  @override
  String productDeleted(Object name) {
    return 'تم حذف $name بنجاح';
  }

  @override
  String get productName => 'اسم المنتج';

  @override
  String get brand => 'العلامة التجارية';

  @override
  String get model => 'الطراز';

  @override
  String get price => 'السعر';

  @override
  String get stock => 'المخزون';

  @override
  String get available => 'متوفر';

  @override
  String get outOfStock => 'نفد من المخزون';

  @override
  String get saveProduct => 'حفظ المنتج';

  @override
  String get productAdded => 'تمت إضافة المنتج بنجاح.';

  @override
  String get productUpdated => 'تم تحديث المنتج بنجاح';

  @override
  String get productAddedShort => 'تمت إضافة المنتج بنجاح';

  @override
  String get productUpdatedShort => 'تم تحديث المنتج بنجاح';

  @override
  String brandLabel(Object brand) {
    return 'العلامة التجارية: $brand';
  }

  @override
  String modelLabel(Object model) {
    return 'الطراز: $model';
  }

  @override
  String priceLabel(Object price) {
    return 'السعر: $price';
  }

  @override
  String stockLabel(Object quantity) {
    return 'المخزون: $quantity';
  }

  @override
  String stockCount(Object count) {
    return 'متبقي $count';
  }

  @override
  String profitLabel(Object amount) {
    return 'الربح: $amount';
  }

  @override
  String get qtyLabel => 'الكمية:';

  @override
  String get barcodeLabel => 'الباركود:';

  @override
  String get warranty => 'الضمان';

  @override
  String get warrantyManagement => 'إدارة الضمان';

  @override
  String get addWarranty => 'إضافة ضمان';

  @override
  String get warrantyDuration => 'مدة الضمان';

  @override
  String warrantyMonths(Object months) {
    return '$months شهر/أشهر';
  }

  @override
  String warrantyMonthsShort(Object months) {
    return '$months شهر';
  }

  @override
  String get warrantyLabel => 'الضمان:';

  @override
  String get pleaseEnterProductName => 'يرجى إدخال اسم المنتج.';

  @override
  String get warrantyAdded => 'تمت إضافة الضمان بنجاح.';

  @override
  String get warrantyDetails => 'تفاصيل الضمان';

  @override
  String get deleteWarranty => 'حذف الضمان';

  @override
  String get fileClaim => 'تقديم مطالبة';

  @override
  String get voidWarranty => 'إلغاء الضمان';

  @override
  String get claimHistory => 'سجل المطالبات';

  @override
  String costLabel(Object amount) {
    return 'التكلفة: $amount';
  }

  @override
  String get active => 'نشط';

  @override
  String get expired => 'منتهي الصلاحية';

  @override
  String get expiryDate => 'تاريخ الانتهاء';

  @override
  String customerLabel(Object name) {
    return 'العميل: $name';
  }

  @override
  String get bundles => 'الحزم';

  @override
  String get bundleName => 'اسم الحزمة';

  @override
  String get createBundle => 'إنشاء حزمة';

  @override
  String get sellBundle => 'بيع الحزمة';

  @override
  String get bundleNotFound => 'لم يتم العثور على الحزمة.';

  @override
  String get itemsInBundle => 'العناصر في الحزمة';

  @override
  String get addItem => 'إضافة عنصر';

  @override
  String get includedItems => 'العناصر المضمنة';

  @override
  String get bundlePrice => 'سعر الحزمة';

  @override
  String get subtotal => 'المجموع الفرعي';

  @override
  String get finalPrice => 'السعر النهائي';

  @override
  String get discount => 'الخصم';

  @override
  String discountPercent(Object percent) {
    return 'خصم ($percent%)';
  }

  @override
  String insufficientStock(Object product) {
    return 'مخزون غير كافٍ لـ $product';
  }

  @override
  String bundleSold(Object name) {
    return 'تم بيع الحزمة: $name';
  }

  @override
  String get productBundles => 'حزم المنتجات';

  @override
  String get payment => 'الدفع';

  @override
  String get paymentConfirmation => 'تأكيد الدفع';

  @override
  String get paymentProof => 'إثبات الدفع';

  @override
  String get paymentMethod => 'طريقة الدفع';

  @override
  String get paymentBreakdown => 'تفاصيل الدفع';

  @override
  String get cash => 'نقداً';

  @override
  String get card => 'بطاقة';

  @override
  String get transfer => 'تحويل';

  @override
  String get jazzCash => 'JazzCash';

  @override
  String get easyPaisa => 'EasyPaisa';

  @override
  String get credit => 'ائتمان';

  @override
  String get accountNumber => 'رقم الحساب';

  @override
  String get notesOptional => 'ملاحظات (اختياري)';

  @override
  String get cardReferenceNumber => 'رقم مرجع البطاقة';

  @override
  String get confirmSale => 'تأكيد البيع';

  @override
  String get totalPrice => 'السعر الإجمالي';

  @override
  String get selectProductFirst => 'اختر منتجاً أولاً.';

  @override
  String onePointDiscount(Object amount) {
    return 'نقطة واحدة = خصم $amount';
  }

  @override
  String get salesScreen => 'شاشة المبيعات';

  @override
  String get sendReceipt => 'إرسال الإيصال';

  @override
  String get sendViaWhatsApp => 'إرسال عبر WhatsApp';

  @override
  String get sendViaEmail => 'إرسال عبر البريد الإلكتروني';

  @override
  String get sendViaSms => 'إرسال عبر SMS';

  @override
  String get share => 'مشاركة';

  @override
  String get sendToPhoneNumber => 'إرسال إلى رقم الهاتف';

  @override
  String get phoneNumberHint => 'أدخل رقم هاتف صالحاً لإرسال الإيصال.';

  @override
  String get send => 'إرسال';

  @override
  String get emailNotAvailable => 'عنوان البريد الإلكتروني غير متوفر.';

  @override
  String get newSale => 'بيع جديد';

  @override
  String get orderDetails => 'تفاصيل الطلب';

  @override
  String get orderNumber => 'طلب #';

  @override
  String get quantity => 'الكمية';

  @override
  String get total => 'الإجمالي';

  @override
  String get customer => 'العميل';

  @override
  String get viewDetails => 'عرض التفاصيل';

  @override
  String get walkInCustomer => 'عميل بدون موعد';

  @override
  String get manage => 'إدارة';

  @override
  String get customers => 'العملاء';

  @override
  String get deleteCustomer => 'حذف العميل؟';

  @override
  String get searchCustomers => 'البحث بالاسم أو الهاتف...';

  @override
  String get noCustomersFound => 'لم يتم العثور على عملاء';

  @override
  String get repayCredit => 'سداد الائتمان';

  @override
  String get repay => 'سداد';

  @override
  String get phone => 'الهاتف';

  @override
  String get address => 'العنوان';

  @override
  String get repeatCustomer => 'عميل متكرر';

  @override
  String get favoriteProducts => 'المنتجات المفضلة';

  @override
  String get noPurchasesYet => 'لا توجد مشتريات بعد';

  @override
  String get addCustomer => 'إضافة عميل';

  @override
  String get updateCustomer => 'تحديث العميل';

  @override
  String pointsEarned(Object points) {
    return '+$points نقطة';
  }

  @override
  String get reports => 'التقارير';

  @override
  String get noDataToExport => 'لا توجد بيانات للتصدير.';

  @override
  String get recentTransactions => 'المعاملات الأخيرة';

  @override
  String get noTransactionsPeriod => 'لا توجد معاملات لهذه الفترة.';

  @override
  String get bestSellingProducts => 'المنتجات الأكثر مبيعاً';

  @override
  String get profitWord => 'ربح';

  @override
  String get firebaseBackups => 'نسخ Firebase الاحتياطية';

  @override
  String get noBackupsFound => 'لم يتم العثور على نسخ احتياطية';

  @override
  String get restoreBackup => 'استعادة النسخة الاحتياطية';

  @override
  String get restoreBackupConfirm =>
      'سيؤدي هذا إلى استبدال البيانات المحلية. هل تريد المتابعة؟';

  @override
  String get backupHistory => 'سجل النسخ الاحتياطية';

  @override
  String get notificationSettings => 'إعدادات الإشعارات';

  @override
  String get enableNotifications => 'تفعيل الإشعارات';

  @override
  String get lowStockWarnings => 'تحذيرات انخفاض المخزون';

  @override
  String get dailySalesReminder => 'تذكير المبيعات اليومية';

  @override
  String get exportLocalBackup => 'تصدير نسخة احتياطية محلية';

  @override
  String get backupToFirebase => 'نسخ احتياطي إلى Firebase';

  @override
  String get restoreFromFirebase => 'استعادة من Firebase';

  @override
  String get notificationSettingsComingSoon => 'إعدادات الإشعارات قريباً!';

  @override
  String get settings => 'الإعدادات';

  @override
  String get appearance => 'المظهر';

  @override
  String get language => 'اللغة';

  @override
  String get currency => 'العملة';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get selectLanguage => 'اختر اللغة';

  @override
  String get selectCurrency => 'اختر العملة';

  @override
  String get searchCurrency => 'البحث عن عملة...';

  @override
  String get searchLanguage => 'البحث عن لغة...';

  @override
  String get general => 'عام';

  @override
  String get account => 'الحساب';

  @override
  String get theme => 'السمة';

  @override
  String get light => 'فاتح';

  @override
  String get dark => 'داكن';

  @override
  String get systemDefault => 'افتراضي النظام';

  @override
  String get about => 'حول';

  @override
  String get shopTools => 'أدوات المتجر';

  @override
  String get shopToolsSubtitle => 'الضمان والحزم والتقارير وإعدادات الحساب';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get unableToLoadProfile =>
      'تعذّر تحميل الملف الشخصي. يرجى المحاولة مرة أخرى.';

  @override
  String get accessDenied => 'تم رفض الوصول';

  @override
  String get accessDeniedMessage =>
      'You do not have permission to access this page.\nPlease contact your administrator.';

  @override
  String get goBack => 'رجوع';

  @override
  String get cancel => 'إلغاء';

  @override
  String get save => 'حفظ';

  @override
  String get submit => 'إرسال';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get view => 'عرض';

  @override
  String get close => 'إغلاق';

  @override
  String get update => 'تحديث';

  @override
  String errorGeneric(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get continueAction => 'متابعة';

  @override
  String get yes => 'نعم';

  @override
  String get no => 'لا';

  @override
  String get ok => 'موافق';

  @override
  String get onboardingTitle => 'مرحباً بك في متجر الجوال';

  @override
  String get onboardingSubtitle => 'اختر لغتك وعملتك لتخصيص التطبيق.';

  @override
  String get chooseLanguage => 'اختر اللغة';

  @override
  String get chooseCurrency => 'اختر العملة';

  @override
  String get getStarted => 'ابدأ';

  @override
  String get languageNameEnglish => 'الإنجليزية';

  @override
  String get languageNameUrdu => 'الأردية';

  @override
  String get languageNameArabic => 'العربية';

  @override
  String get languageNameSpanish => 'الإسبانية';

  @override
  String get languageNameFrench => 'الفرنسية';

  @override
  String get languageNameGerman => 'الألمانية';

  @override
  String get languageNameChinese => 'الصينية';

  @override
  String get languageNameTurkish => 'التركية';
}

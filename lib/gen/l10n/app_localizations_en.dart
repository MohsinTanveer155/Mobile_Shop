// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Mobile Shop';

  @override
  String get appSubtitle => 'Professional POS & Staff Management';

  @override
  String get appFullTitle => 'Mobile Shop POS';

  @override
  String get versionLabel => 'Version 1.0.0';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get signInSubtitle =>
      'Sign in to continue to your Mobile Shop account';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get createAccount => 'Create Account';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get register => 'Register';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get accountCreated => 'Account created successfully.';

  @override
  String get unableToSignIn => 'Unable to sign in. Please try again.';

  @override
  String get unableToCreateAccount =>
      'Unable to create account. Please try again.';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get resetPasswordInstructions =>
      'Enter your email address and we\'ll send you a link to reset your password.';

  @override
  String get sendResetLink => 'Send Reset Link';

  @override
  String get resetLinkSent => 'Password reset link sent to your email.';

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
  String get logoutConfirm => 'Are you sure you want to sign out?';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get home => 'Home';

  @override
  String get products => 'Products';

  @override
  String get orders => 'Orders';

  @override
  String get staff => 'Staff';

  @override
  String get more => 'More';

  @override
  String get attendance => 'Attendance';

  @override
  String get leave => 'Leave';

  @override
  String get salary => 'Salary';

  @override
  String get profile => 'Profile';

  @override
  String get sales => 'Sales';

  @override
  String get welcome => 'Welcome';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get goodMorning => 'Good Morning';

  @override
  String get goodAfternoon => 'Good Afternoon';

  @override
  String get goodEvening => 'Good Evening';

  @override
  String get viewAll => 'View All';

  @override
  String get startNewSale => 'Start New Sale';

  @override
  String get leaveRequests => 'Leave requests';

  @override
  String get salaryRequests => 'Salary Requests';

  @override
  String get noRecentOrders => 'No recent orders yet.';

  @override
  String get allProductsStocked => 'All products are sufficiently stocked.';

  @override
  String get loadingDashboard => 'Loading dashboard...';

  @override
  String get periodDaily => 'D';

  @override
  String get periodWeekly => 'W';

  @override
  String get periodMonthly => 'M';

  @override
  String get periodDailyFull => 'Daily';

  @override
  String get periodWeeklyFull => 'Weekly';

  @override
  String get periodMonthlyFull => 'Monthly';

  @override
  String get periodYearly => 'Yearly';

  @override
  String get manageStaff => 'Manage Staff';

  @override
  String get employee => 'Employee';

  @override
  String get administrator => 'Administrator';

  @override
  String get admin => 'Admin';

  @override
  String get user => 'User';

  @override
  String get addStaff => 'Add Staff';

  @override
  String get monthlySalary => 'Monthly Salary';

  @override
  String get useSignupForStaff => 'Use Signup screen for new staff';

  @override
  String get editProfileComingSoon => 'Edit profile coming soon';

  @override
  String updateStaffSalary(Object name) {
    return 'Update $name\'s Salary';
  }

  @override
  String get hrDashboard => 'HR Dashboard';

  @override
  String get executiveHrOverview => 'Executive HR Overview';

  @override
  String get staffProfile => 'Staff Profile';

  @override
  String get checkIn => 'Check In';

  @override
  String get checkOut => 'Check Out';

  @override
  String get checkInNow => 'Check In Now';

  @override
  String get present => 'Present';

  @override
  String get absent => 'Absent';

  @override
  String get workingHours => 'Working Hours';

  @override
  String get attendanceHistory => 'Attendance History';

  @override
  String get todayAttendance => 'Today\'s Attendance';

  @override
  String get notCheckedIn => 'Not checked in';

  @override
  String inAt(Object time) {
    return 'In at $time';
  }

  @override
  String workedDuration(Object duration) {
    return '$duration worked';
  }

  @override
  String get ongoing => 'Ongoing';

  @override
  String get applyLeave => 'Apply Leave';

  @override
  String get leaveType => 'Leave Type';

  @override
  String get startDate => 'Start Date';

  @override
  String get endDate => 'End Date';

  @override
  String get reason => 'Reason';

  @override
  String get pending => 'Pending';

  @override
  String get approved => 'Approved';

  @override
  String get rejected => 'Rejected';

  @override
  String get unableSubmitLeave =>
      'Unable to submit leave: no authenticated user.';

  @override
  String get leaveSubmitted => 'Leave request submitted.';

  @override
  String leaveDays(Object count) {
    return '$count day(s)';
  }

  @override
  String get manageLeaveRequests => 'Manage Leave Requests';

  @override
  String get noPendingLeaveRequests => 'No pending leave requests.';

  @override
  String periodRange(Object start, Object end) {
    return 'Period: $start - $end';
  }

  @override
  String get approveLeave => 'Approve Leave';

  @override
  String get rejectLeave => 'Reject Leave';

  @override
  String leaveStatusSuccess(Object status) {
    return 'Leave $status successfully.';
  }

  @override
  String get pleaseSignInToViewSalary =>
      'Please sign in to view salary details.';

  @override
  String get salaryOverview => 'Salary Overview';

  @override
  String get generatePayroll => 'Generate Payroll';

  @override
  String get manageSalaryRequests => 'Manage Salary Requests';

  @override
  String get requestSalary => 'Request Salary';

  @override
  String get salaryHistory => 'Salary History';

  @override
  String get noSalaryRecords => 'No salary records';

  @override
  String get noSalaryRecordsSubtitle =>
      'Generated or paid salaries will appear here.';

  @override
  String get unableToLoadSalaryHistory =>
      'Unable to load salary history. Please try again.';

  @override
  String get basicSalary => 'Basic Salary';

  @override
  String get presentDays => 'Present Days';

  @override
  String get estimatedPay => 'Estimated Pay';

  @override
  String get deductions => 'Deductions';

  @override
  String get unableToLoadSalaryPreview =>
      'Unable to load salary preview. Please try again.';

  @override
  String get payrollGenerated => 'Payroll generated!';

  @override
  String monthYearSalary(Object monthYear) {
    return '$monthYear Salary';
  }

  @override
  String get netPay => 'Net Pay';

  @override
  String get attendancePercentage => 'Attendance %';

  @override
  String get baseSalary => 'Base Salary';

  @override
  String get noPendingSalaryRequests => 'No pending salary requests.';

  @override
  String get amount => 'Amount';

  @override
  String get staffName => 'Staff Name';

  @override
  String get requestDate => 'Request Date';

  @override
  String get reject => 'Reject';

  @override
  String get approve => 'Approve';

  @override
  String get approveRequest => 'Approve Request';

  @override
  String get rejectRequest => 'Reject Request';

  @override
  String get adminRemark => 'Admin Remark';

  @override
  String requestStatusSuccessfully(Object status) {
    return 'Request $status successfully.';
  }

  @override
  String get newSalaryRequest => 'New Salary Request';

  @override
  String get sendRequest => 'Send Request';

  @override
  String get requestHistory => 'Request History';

  @override
  String get noSalaryRequestsYet => 'No salary requests yet.';

  @override
  String get salaryRequestSubmitted => 'Salary request submitted successfully.';

  @override
  String salaryRequestFailed(Object error) {
    return 'Request failed: $error';
  }

  @override
  String get pleaseSignInSalaryRequests =>
      'Please sign in to view salary requests.';

  @override
  String requestedDate(Object date) {
    return 'Requested: $date';
  }

  @override
  String adminNote(Object note) {
    return 'Admin Note: $note';
  }

  @override
  String get addProduct => 'Add Product';

  @override
  String get editProduct => 'Edit Product';

  @override
  String get deleteProduct => 'Delete Product';

  @override
  String deleteProductConfirm(Object name) {
    return 'Are you sure you want to delete \"$name\"?';
  }

  @override
  String productDeleted(Object name) {
    return '$name deleted successfully';
  }

  @override
  String get productName => 'Product Name';

  @override
  String get brand => 'Brand';

  @override
  String get model => 'Model';

  @override
  String get price => 'Price';

  @override
  String get stock => 'Stock';

  @override
  String get available => 'Available';

  @override
  String get outOfStock => 'Out of Stock';

  @override
  String get saveProduct => 'Save Product';

  @override
  String get productAdded => 'Product added successfully.';

  @override
  String get productUpdated => 'Product updated successfully';

  @override
  String get productAddedShort => 'Product added successfully';

  @override
  String get productUpdatedShort => 'Product updated successfully';

  @override
  String brandLabel(Object brand) {
    return 'Brand: $brand';
  }

  @override
  String modelLabel(Object model) {
    return 'Model: $model';
  }

  @override
  String priceLabel(Object price) {
    return 'Price: $price';
  }

  @override
  String stockLabel(Object quantity) {
    return 'Stock: $quantity';
  }

  @override
  String stockCount(Object count) {
    return '$count left';
  }

  @override
  String profitLabel(Object amount) {
    return 'Profit: $amount';
  }

  @override
  String get qtyLabel => 'Qty:';

  @override
  String get barcodeLabel => 'Barcode:';

  @override
  String get warranty => 'Warranty';

  @override
  String get warrantyManagement => 'Warranty Management';

  @override
  String get addWarranty => 'Add Warranty';

  @override
  String get warrantyDuration => 'Warranty Duration';

  @override
  String warrantyMonths(Object months) {
    return '$months months';
  }

  @override
  String warrantyMonthsShort(Object months) {
    return '$months mo';
  }

  @override
  String get warrantyLabel => 'Warranty:';

  @override
  String get pleaseEnterProductName => 'Please enter product name.';

  @override
  String get warrantyAdded => 'Warranty added successfully.';

  @override
  String get warrantyDetails => 'Warranty Details';

  @override
  String get deleteWarranty => 'Delete Warranty';

  @override
  String get fileClaim => 'File Claim';

  @override
  String get voidWarranty => 'Void Warranty';

  @override
  String get claimHistory => 'Claim History';

  @override
  String costLabel(Object amount) {
    return 'Cost: $amount';
  }

  @override
  String get active => 'Active';

  @override
  String get expired => 'Expired';

  @override
  String get expiryDate => 'Expiry Date';

  @override
  String customerLabel(Object name) {
    return 'Customer: $name';
  }

  @override
  String get bundles => 'Bundles';

  @override
  String get bundleName => 'Bundle Name';

  @override
  String get createBundle => 'Create Bundle';

  @override
  String get sellBundle => 'Sell Bundle';

  @override
  String get bundleNotFound => 'Bundle not found.';

  @override
  String get itemsInBundle => 'Items in Bundle';

  @override
  String get addItem => 'Add Item';

  @override
  String get includedItems => 'Included Items';

  @override
  String get bundlePrice => 'Bundle Price';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get finalPrice => 'Final Price';

  @override
  String get discount => 'Discount';

  @override
  String discountPercent(Object percent) {
    return 'Discount ($percent%)';
  }

  @override
  String insufficientStock(Object product) {
    return 'Insufficient stock for $product';
  }

  @override
  String bundleSold(Object name) {
    return 'Bundle sold: $name';
  }

  @override
  String get productBundles => 'Product Bundles';

  @override
  String get payment => 'Payment';

  @override
  String get paymentConfirmation => 'Payment Confirmation';

  @override
  String get paymentProof => 'Payment Proof';

  @override
  String get paymentMethod => 'Payment Method';

  @override
  String get paymentBreakdown => 'Payment Breakdown';

  @override
  String get cash => 'Cash';

  @override
  String get card => 'Card';

  @override
  String get transfer => 'Transfer';

  @override
  String get jazzCash => 'JazzCash';

  @override
  String get easyPaisa => 'EasyPaisa';

  @override
  String get credit => 'Credit';

  @override
  String get accountNumber => 'Account Number';

  @override
  String get notesOptional => 'Notes (Optional)';

  @override
  String get cardReferenceNumber => 'Card Reference Number';

  @override
  String get confirmSale => 'Confirm Sale';

  @override
  String get totalPrice => 'Total Price';

  @override
  String get selectProductFirst => 'Select a product first.';

  @override
  String onePointDiscount(Object amount) {
    return '1 point = $amount discount';
  }

  @override
  String get salesScreen => 'Sales Screen';

  @override
  String get sendReceipt => 'Send Receipt';

  @override
  String get sendViaWhatsApp => 'Send via WhatsApp';

  @override
  String get sendViaEmail => 'Send via Email';

  @override
  String get sendViaSms => 'Send via SMS';

  @override
  String get share => 'Share';

  @override
  String get sendToPhoneNumber => 'Send to Phone Number';

  @override
  String get phoneNumberHint =>
      'Enter a valid phone number for receipt delivery.';

  @override
  String get send => 'Send';

  @override
  String get emailNotAvailable => 'Email address not available.';

  @override
  String get newSale => 'New Sale';

  @override
  String get orderDetails => 'Order Details';

  @override
  String get orderNumber => 'Order #';

  @override
  String get quantity => 'Quantity';

  @override
  String get total => 'Total';

  @override
  String get customer => 'Customer';

  @override
  String get viewDetails => 'View Details';

  @override
  String get walkInCustomer => 'Walk-in Customer';

  @override
  String get manage => 'Manage';

  @override
  String get customers => 'Customers';

  @override
  String get deleteCustomer => 'Delete Customer?';

  @override
  String get searchCustomers => 'Search by name or phone...';

  @override
  String get noCustomersFound => 'No customers found';

  @override
  String get repayCredit => 'Repay Credit';

  @override
  String get repay => 'Repay';

  @override
  String get phone => 'Phone';

  @override
  String get address => 'Address';

  @override
  String get repeatCustomer => 'Repeat Customer';

  @override
  String get favoriteProducts => 'Favorite Products';

  @override
  String get noPurchasesYet => 'No purchases yet';

  @override
  String get addCustomer => 'Add Customer';

  @override
  String get updateCustomer => 'Update Customer';

  @override
  String pointsEarned(Object points) {
    return '+$points pts';
  }

  @override
  String get reports => 'Reports';

  @override
  String get noDataToExport => 'No data to export.';

  @override
  String get recentTransactions => 'Recent Transactions';

  @override
  String get noTransactionsPeriod => 'No transactions for this period.';

  @override
  String get bestSellingProducts => 'Best Selling Products';

  @override
  String get profitWord => 'profit';

  @override
  String get firebaseBackups => 'Firebase Backups';

  @override
  String get noBackupsFound => 'No backups found';

  @override
  String get restoreBackup => 'Restore Backup';

  @override
  String get restoreBackupConfirm => 'This will replace local data. Continue?';

  @override
  String get backupHistory => 'Backup History';

  @override
  String get notificationSettings => 'Notification Settings';

  @override
  String get enableNotifications => 'Enable Notifications';

  @override
  String get lowStockWarnings => 'Low Stock Warnings';

  @override
  String get dailySalesReminder => 'Daily Sales Reminder';

  @override
  String get exportLocalBackup => 'Export Local Backup';

  @override
  String get backupToFirebase => 'Backup to Firebase';

  @override
  String get restoreFromFirebase => 'Restore From Firebase';

  @override
  String get notificationSettingsComingSoon =>
      'Notification settings coming soon!';

  @override
  String get settings => 'Settings';

  @override
  String get appearance => 'Appearance';

  @override
  String get language => 'Language';

  @override
  String get currency => 'Currency';

  @override
  String get notifications => 'Notifications';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get selectCurrency => 'Select Currency';

  @override
  String get searchCurrency => 'Search currency...';

  @override
  String get searchLanguage => 'Search language...';

  @override
  String get general => 'General';

  @override
  String get account => 'Account';

  @override
  String get theme => 'Theme';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get systemDefault => 'System Default';

  @override
  String get about => 'About';

  @override
  String get shopTools => 'Shop Tools';

  @override
  String get shopToolsSubtitle =>
      'Warranty, bundles, reports, and account settings';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get unableToLoadProfile => 'Unable to load profile. Please try again.';

  @override
  String get accessDenied => 'Access Denied';

  @override
  String get accessDeniedMessage =>
      'You do not have permission to access this page.\nPlease contact your administrator.';

  @override
  String get goBack => 'Go Back';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get submit => 'Submit';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get view => 'View';

  @override
  String get close => 'Close';

  @override
  String get update => 'Update';

  @override
  String errorGeneric(Object error) {
    return 'Error: $error';
  }

  @override
  String get continueAction => 'Continue';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get ok => 'OK';

  @override
  String get onboardingTitle => 'Welcome to Mobile Shop';

  @override
  String get onboardingSubtitle =>
      'Choose your language and currency to personalize the app.';

  @override
  String get chooseLanguage => 'Choose Language';

  @override
  String get chooseCurrency => 'Choose Currency';

  @override
  String get getStarted => 'Get Started';

  @override
  String get languageNameEnglish => 'English';

  @override
  String get languageNameUrdu => 'Urdu';

  @override
  String get languageNameArabic => 'Arabic';

  @override
  String get languageNameSpanish => 'Spanish';

  @override
  String get languageNameFrench => 'French';

  @override
  String get languageNameGerman => 'German';

  @override
  String get languageNameChinese => 'Chinese';

  @override
  String get languageNameTurkish => 'Turkish';
}

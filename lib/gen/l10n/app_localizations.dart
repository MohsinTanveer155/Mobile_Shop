import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('tr'),
    Locale('ur'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Mobile Shop'**
  String get appTitle;

  /// No description provided for @appSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Professional POS & Staff Management'**
  String get appSubtitle;

  /// No description provided for @appFullTitle.
  ///
  /// In en, this message translates to:
  /// **'Mobile Shop POS'**
  String get appFullTitle;

  /// No description provided for @versionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get versionLabel;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @signInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue to your Mobile Shop account'**
  String get signInSubtitle;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @accountCreated.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully.'**
  String get accountCreated;

  /// No description provided for @unableToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Unable to sign in. Please try again.'**
  String get unableToSignIn;

  /// No description provided for @unableToCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Unable to create account. Please try again.'**
  String get unableToCreateAccount;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @resetPasswordInstructions.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we\'ll send you a link to reset your password.'**
  String get resetPasswordInstructions;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// No description provided for @resetLinkSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset link sent to your email.'**
  String get resetLinkSent;

  /// No description provided for @resetLinkSentToEmail.
  ///
  /// In en, this message translates to:
  /// **'Password reset link sent to {email}.\nPlease check your email.'**
  String resetLinkSentToEmail(Object email);

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'user@example.com'**
  String get emailHint;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter password'**
  String get pleaseEnterPassword;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Register to join your Mobile Shop team'**
  String get registerSubtitle;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @phoneOptional.
  ///
  /// In en, this message translates to:
  /// **'Phone (Optional)'**
  String get phoneOptional;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @logoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get logoutConfirm;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @products.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @staff.
  ///
  /// In en, this message translates to:
  /// **'Staff'**
  String get staff;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @attendance.
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get attendance;

  /// No description provided for @leave.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get leave;

  /// No description provided for @salary.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get salary;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @sales.
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get sales;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get goodEvening;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @startNewSale.
  ///
  /// In en, this message translates to:
  /// **'Start New Sale'**
  String get startNewSale;

  /// No description provided for @leaveRequests.
  ///
  /// In en, this message translates to:
  /// **'Leave requests'**
  String get leaveRequests;

  /// No description provided for @salaryRequests.
  ///
  /// In en, this message translates to:
  /// **'Salary Requests'**
  String get salaryRequests;

  /// No description provided for @noRecentOrders.
  ///
  /// In en, this message translates to:
  /// **'No recent orders yet.'**
  String get noRecentOrders;

  /// No description provided for @allProductsStocked.
  ///
  /// In en, this message translates to:
  /// **'All products are sufficiently stocked.'**
  String get allProductsStocked;

  /// No description provided for @loadingDashboard.
  ///
  /// In en, this message translates to:
  /// **'Loading dashboard...'**
  String get loadingDashboard;

  /// No description provided for @periodDaily.
  ///
  /// In en, this message translates to:
  /// **'D'**
  String get periodDaily;

  /// No description provided for @periodWeekly.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get periodWeekly;

  /// No description provided for @periodMonthly.
  ///
  /// In en, this message translates to:
  /// **'M'**
  String get periodMonthly;

  /// No description provided for @periodDailyFull.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get periodDailyFull;

  /// No description provided for @periodWeeklyFull.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get periodWeeklyFull;

  /// No description provided for @periodMonthlyFull.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get periodMonthlyFull;

  /// No description provided for @periodYearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get periodYearly;

  /// No description provided for @manageStaff.
  ///
  /// In en, this message translates to:
  /// **'Manage Staff'**
  String get manageStaff;

  /// No description provided for @employee.
  ///
  /// In en, this message translates to:
  /// **'Employee'**
  String get employee;

  /// No description provided for @administrator.
  ///
  /// In en, this message translates to:
  /// **'Administrator'**
  String get administrator;

  /// No description provided for @admin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get admin;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @addStaff.
  ///
  /// In en, this message translates to:
  /// **'Add Staff'**
  String get addStaff;

  /// No description provided for @monthlySalary.
  ///
  /// In en, this message translates to:
  /// **'Monthly Salary'**
  String get monthlySalary;

  /// No description provided for @useSignupForStaff.
  ///
  /// In en, this message translates to:
  /// **'Use Signup screen for new staff'**
  String get useSignupForStaff;

  /// No description provided for @editProfileComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Edit profile coming soon'**
  String get editProfileComingSoon;

  /// No description provided for @updateStaffSalary.
  ///
  /// In en, this message translates to:
  /// **'Update {name}\'s Salary'**
  String updateStaffSalary(Object name);

  /// No description provided for @hrDashboard.
  ///
  /// In en, this message translates to:
  /// **'HR Dashboard'**
  String get hrDashboard;

  /// No description provided for @executiveHrOverview.
  ///
  /// In en, this message translates to:
  /// **'Executive HR Overview'**
  String get executiveHrOverview;

  /// No description provided for @staffProfile.
  ///
  /// In en, this message translates to:
  /// **'Staff Profile'**
  String get staffProfile;

  /// No description provided for @checkIn.
  ///
  /// In en, this message translates to:
  /// **'Check In'**
  String get checkIn;

  /// No description provided for @checkOut.
  ///
  /// In en, this message translates to:
  /// **'Check Out'**
  String get checkOut;

  /// No description provided for @checkInNow.
  ///
  /// In en, this message translates to:
  /// **'Check In Now'**
  String get checkInNow;

  /// No description provided for @present.
  ///
  /// In en, this message translates to:
  /// **'Present'**
  String get present;

  /// No description provided for @absent.
  ///
  /// In en, this message translates to:
  /// **'Absent'**
  String get absent;

  /// No description provided for @workingHours.
  ///
  /// In en, this message translates to:
  /// **'Working Hours'**
  String get workingHours;

  /// No description provided for @attendanceHistory.
  ///
  /// In en, this message translates to:
  /// **'Attendance History'**
  String get attendanceHistory;

  /// No description provided for @todayAttendance.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Attendance'**
  String get todayAttendance;

  /// No description provided for @notCheckedIn.
  ///
  /// In en, this message translates to:
  /// **'Not checked in'**
  String get notCheckedIn;

  /// No description provided for @inAt.
  ///
  /// In en, this message translates to:
  /// **'In at {time}'**
  String inAt(Object time);

  /// No description provided for @workedDuration.
  ///
  /// In en, this message translates to:
  /// **'{duration} worked'**
  String workedDuration(Object duration);

  /// No description provided for @ongoing.
  ///
  /// In en, this message translates to:
  /// **'Ongoing'**
  String get ongoing;

  /// No description provided for @applyLeave.
  ///
  /// In en, this message translates to:
  /// **'Apply Leave'**
  String get applyLeave;

  /// No description provided for @leaveType.
  ///
  /// In en, this message translates to:
  /// **'Leave Type'**
  String get leaveType;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// No description provided for @reason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @unableSubmitLeave.
  ///
  /// In en, this message translates to:
  /// **'Unable to submit leave: no authenticated user.'**
  String get unableSubmitLeave;

  /// No description provided for @leaveSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Leave request submitted.'**
  String get leaveSubmitted;

  /// No description provided for @leaveDays.
  ///
  /// In en, this message translates to:
  /// **'{count} day(s)'**
  String leaveDays(Object count);

  /// No description provided for @manageLeaveRequests.
  ///
  /// In en, this message translates to:
  /// **'Manage Leave Requests'**
  String get manageLeaveRequests;

  /// No description provided for @noPendingLeaveRequests.
  ///
  /// In en, this message translates to:
  /// **'No pending leave requests.'**
  String get noPendingLeaveRequests;

  /// No description provided for @periodRange.
  ///
  /// In en, this message translates to:
  /// **'Period: {start} - {end}'**
  String periodRange(Object start, Object end);

  /// No description provided for @approveLeave.
  ///
  /// In en, this message translates to:
  /// **'Approve Leave'**
  String get approveLeave;

  /// No description provided for @rejectLeave.
  ///
  /// In en, this message translates to:
  /// **'Reject Leave'**
  String get rejectLeave;

  /// No description provided for @leaveStatusSuccess.
  ///
  /// In en, this message translates to:
  /// **'Leave {status} successfully.'**
  String leaveStatusSuccess(Object status);

  /// No description provided for @pleaseSignInToViewSalary.
  ///
  /// In en, this message translates to:
  /// **'Please sign in to view salary details.'**
  String get pleaseSignInToViewSalary;

  /// No description provided for @salaryOverview.
  ///
  /// In en, this message translates to:
  /// **'Salary Overview'**
  String get salaryOverview;

  /// No description provided for @generatePayroll.
  ///
  /// In en, this message translates to:
  /// **'Generate Payroll'**
  String get generatePayroll;

  /// No description provided for @manageSalaryRequests.
  ///
  /// In en, this message translates to:
  /// **'Manage Salary Requests'**
  String get manageSalaryRequests;

  /// No description provided for @requestSalary.
  ///
  /// In en, this message translates to:
  /// **'Request Salary'**
  String get requestSalary;

  /// No description provided for @salaryHistory.
  ///
  /// In en, this message translates to:
  /// **'Salary History'**
  String get salaryHistory;

  /// No description provided for @noSalaryRecords.
  ///
  /// In en, this message translates to:
  /// **'No salary records'**
  String get noSalaryRecords;

  /// No description provided for @noSalaryRecordsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Generated or paid salaries will appear here.'**
  String get noSalaryRecordsSubtitle;

  /// No description provided for @unableToLoadSalaryHistory.
  ///
  /// In en, this message translates to:
  /// **'Unable to load salary history. Please try again.'**
  String get unableToLoadSalaryHistory;

  /// No description provided for @basicSalary.
  ///
  /// In en, this message translates to:
  /// **'Basic Salary'**
  String get basicSalary;

  /// No description provided for @presentDays.
  ///
  /// In en, this message translates to:
  /// **'Present Days'**
  String get presentDays;

  /// No description provided for @estimatedPay.
  ///
  /// In en, this message translates to:
  /// **'Estimated Pay'**
  String get estimatedPay;

  /// No description provided for @deductions.
  ///
  /// In en, this message translates to:
  /// **'Deductions'**
  String get deductions;

  /// No description provided for @unableToLoadSalaryPreview.
  ///
  /// In en, this message translates to:
  /// **'Unable to load salary preview. Please try again.'**
  String get unableToLoadSalaryPreview;

  /// No description provided for @payrollGenerated.
  ///
  /// In en, this message translates to:
  /// **'Payroll generated!'**
  String get payrollGenerated;

  /// No description provided for @monthYearSalary.
  ///
  /// In en, this message translates to:
  /// **'{monthYear} Salary'**
  String monthYearSalary(Object monthYear);

  /// No description provided for @netPay.
  ///
  /// In en, this message translates to:
  /// **'Net Pay'**
  String get netPay;

  /// No description provided for @attendancePercentage.
  ///
  /// In en, this message translates to:
  /// **'Attendance %'**
  String get attendancePercentage;

  /// No description provided for @baseSalary.
  ///
  /// In en, this message translates to:
  /// **'Base Salary'**
  String get baseSalary;

  /// No description provided for @noPendingSalaryRequests.
  ///
  /// In en, this message translates to:
  /// **'No pending salary requests.'**
  String get noPendingSalaryRequests;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @staffName.
  ///
  /// In en, this message translates to:
  /// **'Staff Name'**
  String get staffName;

  /// No description provided for @requestDate.
  ///
  /// In en, this message translates to:
  /// **'Request Date'**
  String get requestDate;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// No description provided for @approveRequest.
  ///
  /// In en, this message translates to:
  /// **'Approve Request'**
  String get approveRequest;

  /// No description provided for @rejectRequest.
  ///
  /// In en, this message translates to:
  /// **'Reject Request'**
  String get rejectRequest;

  /// No description provided for @adminRemark.
  ///
  /// In en, this message translates to:
  /// **'Admin Remark'**
  String get adminRemark;

  /// No description provided for @requestStatusSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Request {status} successfully.'**
  String requestStatusSuccessfully(Object status);

  /// No description provided for @newSalaryRequest.
  ///
  /// In en, this message translates to:
  /// **'New Salary Request'**
  String get newSalaryRequest;

  /// No description provided for @sendRequest.
  ///
  /// In en, this message translates to:
  /// **'Send Request'**
  String get sendRequest;

  /// No description provided for @requestHistory.
  ///
  /// In en, this message translates to:
  /// **'Request History'**
  String get requestHistory;

  /// No description provided for @noSalaryRequestsYet.
  ///
  /// In en, this message translates to:
  /// **'No salary requests yet.'**
  String get noSalaryRequestsYet;

  /// No description provided for @salaryRequestSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Salary request submitted successfully.'**
  String get salaryRequestSubmitted;

  /// No description provided for @salaryRequestFailed.
  ///
  /// In en, this message translates to:
  /// **'Request failed: {error}'**
  String salaryRequestFailed(Object error);

  /// No description provided for @pleaseSignInSalaryRequests.
  ///
  /// In en, this message translates to:
  /// **'Please sign in to view salary requests.'**
  String get pleaseSignInSalaryRequests;

  /// No description provided for @requestedDate.
  ///
  /// In en, this message translates to:
  /// **'Requested: {date}'**
  String requestedDate(Object date);

  /// No description provided for @adminNote.
  ///
  /// In en, this message translates to:
  /// **'Admin Note: {note}'**
  String adminNote(Object note);

  /// No description provided for @addProduct.
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get addProduct;

  /// No description provided for @editProduct.
  ///
  /// In en, this message translates to:
  /// **'Edit Product'**
  String get editProduct;

  /// No description provided for @deleteProduct.
  ///
  /// In en, this message translates to:
  /// **'Delete Product'**
  String get deleteProduct;

  /// No description provided for @deleteProductConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"?'**
  String deleteProductConfirm(Object name);

  /// No description provided for @productDeleted.
  ///
  /// In en, this message translates to:
  /// **'{name} deleted successfully'**
  String productDeleted(Object name);

  /// No description provided for @productName.
  ///
  /// In en, this message translates to:
  /// **'Product Name'**
  String get productName;

  /// No description provided for @brand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get brand;

  /// No description provided for @model.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get model;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @stock.
  ///
  /// In en, this message translates to:
  /// **'Stock'**
  String get stock;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @outOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get outOfStock;

  /// No description provided for @saveProduct.
  ///
  /// In en, this message translates to:
  /// **'Save Product'**
  String get saveProduct;

  /// No description provided for @productAdded.
  ///
  /// In en, this message translates to:
  /// **'Product added successfully.'**
  String get productAdded;

  /// No description provided for @productUpdated.
  ///
  /// In en, this message translates to:
  /// **'Product updated successfully'**
  String get productUpdated;

  /// No description provided for @productAddedShort.
  ///
  /// In en, this message translates to:
  /// **'Product added successfully'**
  String get productAddedShort;

  /// No description provided for @productUpdatedShort.
  ///
  /// In en, this message translates to:
  /// **'Product updated successfully'**
  String get productUpdatedShort;

  /// No description provided for @brandLabel.
  ///
  /// In en, this message translates to:
  /// **'Brand: {brand}'**
  String brandLabel(Object brand);

  /// No description provided for @modelLabel.
  ///
  /// In en, this message translates to:
  /// **'Model: {model}'**
  String modelLabel(Object model);

  /// No description provided for @priceLabel.
  ///
  /// In en, this message translates to:
  /// **'Price: {price}'**
  String priceLabel(Object price);

  /// No description provided for @stockLabel.
  ///
  /// In en, this message translates to:
  /// **'Stock: {quantity}'**
  String stockLabel(Object quantity);

  /// No description provided for @stockCount.
  ///
  /// In en, this message translates to:
  /// **'{count} left'**
  String stockCount(Object count);

  /// No description provided for @profitLabel.
  ///
  /// In en, this message translates to:
  /// **'Profit: {amount}'**
  String profitLabel(Object amount);

  /// No description provided for @qtyLabel.
  ///
  /// In en, this message translates to:
  /// **'Qty:'**
  String get qtyLabel;

  /// No description provided for @barcodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Barcode:'**
  String get barcodeLabel;

  /// No description provided for @warranty.
  ///
  /// In en, this message translates to:
  /// **'Warranty'**
  String get warranty;

  /// No description provided for @warrantyManagement.
  ///
  /// In en, this message translates to:
  /// **'Warranty Management'**
  String get warrantyManagement;

  /// No description provided for @addWarranty.
  ///
  /// In en, this message translates to:
  /// **'Add Warranty'**
  String get addWarranty;

  /// No description provided for @warrantyDuration.
  ///
  /// In en, this message translates to:
  /// **'Warranty Duration'**
  String get warrantyDuration;

  /// No description provided for @warrantyMonths.
  ///
  /// In en, this message translates to:
  /// **'{months} months'**
  String warrantyMonths(Object months);

  /// No description provided for @warrantyMonthsShort.
  ///
  /// In en, this message translates to:
  /// **'{months} mo'**
  String warrantyMonthsShort(Object months);

  /// No description provided for @warrantyLabel.
  ///
  /// In en, this message translates to:
  /// **'Warranty:'**
  String get warrantyLabel;

  /// No description provided for @pleaseEnterProductName.
  ///
  /// In en, this message translates to:
  /// **'Please enter product name.'**
  String get pleaseEnterProductName;

  /// No description provided for @warrantyAdded.
  ///
  /// In en, this message translates to:
  /// **'Warranty added successfully.'**
  String get warrantyAdded;

  /// No description provided for @warrantyDetails.
  ///
  /// In en, this message translates to:
  /// **'Warranty Details'**
  String get warrantyDetails;

  /// No description provided for @deleteWarranty.
  ///
  /// In en, this message translates to:
  /// **'Delete Warranty'**
  String get deleteWarranty;

  /// No description provided for @fileClaim.
  ///
  /// In en, this message translates to:
  /// **'File Claim'**
  String get fileClaim;

  /// No description provided for @voidWarranty.
  ///
  /// In en, this message translates to:
  /// **'Void Warranty'**
  String get voidWarranty;

  /// No description provided for @claimHistory.
  ///
  /// In en, this message translates to:
  /// **'Claim History'**
  String get claimHistory;

  /// No description provided for @costLabel.
  ///
  /// In en, this message translates to:
  /// **'Cost: {amount}'**
  String costLabel(Object amount);

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// No description provided for @expiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get expiryDate;

  /// No description provided for @customerLabel.
  ///
  /// In en, this message translates to:
  /// **'Customer: {name}'**
  String customerLabel(Object name);

  /// No description provided for @bundles.
  ///
  /// In en, this message translates to:
  /// **'Bundles'**
  String get bundles;

  /// No description provided for @bundleName.
  ///
  /// In en, this message translates to:
  /// **'Bundle Name'**
  String get bundleName;

  /// No description provided for @createBundle.
  ///
  /// In en, this message translates to:
  /// **'Create Bundle'**
  String get createBundle;

  /// No description provided for @sellBundle.
  ///
  /// In en, this message translates to:
  /// **'Sell Bundle'**
  String get sellBundle;

  /// No description provided for @bundleNotFound.
  ///
  /// In en, this message translates to:
  /// **'Bundle not found.'**
  String get bundleNotFound;

  /// No description provided for @itemsInBundle.
  ///
  /// In en, this message translates to:
  /// **'Items in Bundle'**
  String get itemsInBundle;

  /// No description provided for @addItem.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get addItem;

  /// No description provided for @includedItems.
  ///
  /// In en, this message translates to:
  /// **'Included Items'**
  String get includedItems;

  /// No description provided for @bundlePrice.
  ///
  /// In en, this message translates to:
  /// **'Bundle Price'**
  String get bundlePrice;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @finalPrice.
  ///
  /// In en, this message translates to:
  /// **'Final Price'**
  String get finalPrice;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @discountPercent.
  ///
  /// In en, this message translates to:
  /// **'Discount ({percent}%)'**
  String discountPercent(Object percent);

  /// No description provided for @insufficientStock.
  ///
  /// In en, this message translates to:
  /// **'Insufficient stock for {product}'**
  String insufficientStock(Object product);

  /// No description provided for @bundleSold.
  ///
  /// In en, this message translates to:
  /// **'Bundle sold: {name}'**
  String bundleSold(Object name);

  /// No description provided for @productBundles.
  ///
  /// In en, this message translates to:
  /// **'Product Bundles'**
  String get productBundles;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @paymentConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Payment Confirmation'**
  String get paymentConfirmation;

  /// No description provided for @paymentProof.
  ///
  /// In en, this message translates to:
  /// **'Payment Proof'**
  String get paymentProof;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @paymentBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Payment Breakdown'**
  String get paymentBreakdown;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// No description provided for @card.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get card;

  /// No description provided for @transfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transfer;

  /// No description provided for @jazzCash.
  ///
  /// In en, this message translates to:
  /// **'JazzCash'**
  String get jazzCash;

  /// No description provided for @easyPaisa.
  ///
  /// In en, this message translates to:
  /// **'EasyPaisa'**
  String get easyPaisa;

  /// No description provided for @credit.
  ///
  /// In en, this message translates to:
  /// **'Credit'**
  String get credit;

  /// No description provided for @accountNumber.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get accountNumber;

  /// No description provided for @notesOptional.
  ///
  /// In en, this message translates to:
  /// **'Notes (Optional)'**
  String get notesOptional;

  /// No description provided for @cardReferenceNumber.
  ///
  /// In en, this message translates to:
  /// **'Card Reference Number'**
  String get cardReferenceNumber;

  /// No description provided for @confirmSale.
  ///
  /// In en, this message translates to:
  /// **'Confirm Sale'**
  String get confirmSale;

  /// No description provided for @totalPrice.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get totalPrice;

  /// No description provided for @selectProductFirst.
  ///
  /// In en, this message translates to:
  /// **'Select a product first.'**
  String get selectProductFirst;

  /// No description provided for @onePointDiscount.
  ///
  /// In en, this message translates to:
  /// **'1 point = {amount} discount'**
  String onePointDiscount(Object amount);

  /// No description provided for @salesScreen.
  ///
  /// In en, this message translates to:
  /// **'Sales Screen'**
  String get salesScreen;

  /// No description provided for @sendReceipt.
  ///
  /// In en, this message translates to:
  /// **'Send Receipt'**
  String get sendReceipt;

  /// No description provided for @sendViaWhatsApp.
  ///
  /// In en, this message translates to:
  /// **'Send via WhatsApp'**
  String get sendViaWhatsApp;

  /// No description provided for @sendViaEmail.
  ///
  /// In en, this message translates to:
  /// **'Send via Email'**
  String get sendViaEmail;

  /// No description provided for @sendViaSms.
  ///
  /// In en, this message translates to:
  /// **'Send via SMS'**
  String get sendViaSms;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @sendToPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Send to Phone Number'**
  String get sendToPhoneNumber;

  /// No description provided for @phoneNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number for receipt delivery.'**
  String get phoneNumberHint;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @emailNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Email address not available.'**
  String get emailNotAvailable;

  /// No description provided for @newSale.
  ///
  /// In en, this message translates to:
  /// **'New Sale'**
  String get newSale;

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get orderDetails;

  /// No description provided for @orderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order #'**
  String get orderNumber;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @customer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customer;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @walkInCustomer.
  ///
  /// In en, this message translates to:
  /// **'Walk-in Customer'**
  String get walkInCustomer;

  /// No description provided for @manage.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get manage;

  /// No description provided for @customers.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get customers;

  /// No description provided for @deleteCustomer.
  ///
  /// In en, this message translates to:
  /// **'Delete Customer?'**
  String get deleteCustomer;

  /// No description provided for @searchCustomers.
  ///
  /// In en, this message translates to:
  /// **'Search by name or phone...'**
  String get searchCustomers;

  /// No description provided for @noCustomersFound.
  ///
  /// In en, this message translates to:
  /// **'No customers found'**
  String get noCustomersFound;

  /// No description provided for @repayCredit.
  ///
  /// In en, this message translates to:
  /// **'Repay Credit'**
  String get repayCredit;

  /// No description provided for @repay.
  ///
  /// In en, this message translates to:
  /// **'Repay'**
  String get repay;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @repeatCustomer.
  ///
  /// In en, this message translates to:
  /// **'Repeat Customer'**
  String get repeatCustomer;

  /// No description provided for @favoriteProducts.
  ///
  /// In en, this message translates to:
  /// **'Favorite Products'**
  String get favoriteProducts;

  /// No description provided for @noPurchasesYet.
  ///
  /// In en, this message translates to:
  /// **'No purchases yet'**
  String get noPurchasesYet;

  /// No description provided for @addCustomer.
  ///
  /// In en, this message translates to:
  /// **'Add Customer'**
  String get addCustomer;

  /// No description provided for @updateCustomer.
  ///
  /// In en, this message translates to:
  /// **'Update Customer'**
  String get updateCustomer;

  /// No description provided for @pointsEarned.
  ///
  /// In en, this message translates to:
  /// **'+{points} pts'**
  String pointsEarned(Object points);

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @noDataToExport.
  ///
  /// In en, this message translates to:
  /// **'No data to export.'**
  String get noDataToExport;

  /// No description provided for @recentTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get recentTransactions;

  /// No description provided for @noTransactionsPeriod.
  ///
  /// In en, this message translates to:
  /// **'No transactions for this period.'**
  String get noTransactionsPeriod;

  /// No description provided for @bestSellingProducts.
  ///
  /// In en, this message translates to:
  /// **'Best Selling Products'**
  String get bestSellingProducts;

  /// No description provided for @profitWord.
  ///
  /// In en, this message translates to:
  /// **'profit'**
  String get profitWord;

  /// No description provided for @firebaseBackups.
  ///
  /// In en, this message translates to:
  /// **'Firebase Backups'**
  String get firebaseBackups;

  /// No description provided for @noBackupsFound.
  ///
  /// In en, this message translates to:
  /// **'No backups found'**
  String get noBackupsFound;

  /// No description provided for @restoreBackup.
  ///
  /// In en, this message translates to:
  /// **'Restore Backup'**
  String get restoreBackup;

  /// No description provided for @restoreBackupConfirm.
  ///
  /// In en, this message translates to:
  /// **'This will replace local data. Continue?'**
  String get restoreBackupConfirm;

  /// No description provided for @backupHistory.
  ///
  /// In en, this message translates to:
  /// **'Backup History'**
  String get backupHistory;

  /// No description provided for @notificationSettings.
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notificationSettings;

  /// No description provided for @enableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable Notifications'**
  String get enableNotifications;

  /// No description provided for @lowStockWarnings.
  ///
  /// In en, this message translates to:
  /// **'Low Stock Warnings'**
  String get lowStockWarnings;

  /// No description provided for @dailySalesReminder.
  ///
  /// In en, this message translates to:
  /// **'Daily Sales Reminder'**
  String get dailySalesReminder;

  /// No description provided for @exportLocalBackup.
  ///
  /// In en, this message translates to:
  /// **'Export Local Backup'**
  String get exportLocalBackup;

  /// No description provided for @backupToFirebase.
  ///
  /// In en, this message translates to:
  /// **'Backup to Firebase'**
  String get backupToFirebase;

  /// No description provided for @restoreFromFirebase.
  ///
  /// In en, this message translates to:
  /// **'Restore From Firebase'**
  String get restoreFromFirebase;

  /// No description provided for @notificationSettingsComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Notification settings coming soon!'**
  String get notificationSettingsComingSoon;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @selectCurrency.
  ///
  /// In en, this message translates to:
  /// **'Select Currency'**
  String get selectCurrency;

  /// No description provided for @searchCurrency.
  ///
  /// In en, this message translates to:
  /// **'Search currency...'**
  String get searchCurrency;

  /// No description provided for @searchLanguage.
  ///
  /// In en, this message translates to:
  /// **'Search language...'**
  String get searchLanguage;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @shopTools.
  ///
  /// In en, this message translates to:
  /// **'Shop Tools'**
  String get shopTools;

  /// No description provided for @shopToolsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Warranty, bundles, reports, and account settings'**
  String get shopToolsSubtitle;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @unableToLoadProfile.
  ///
  /// In en, this message translates to:
  /// **'Unable to load profile. Please try again.'**
  String get unableToLoadProfile;

  /// No description provided for @accessDenied.
  ///
  /// In en, this message translates to:
  /// **'Access Denied'**
  String get accessDenied;

  /// No description provided for @accessDeniedMessage.
  ///
  /// In en, this message translates to:
  /// **'You do not have permission to access this page.\nPlease contact your administrator.'**
  String get accessDeniedMessage;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorGeneric(Object error);

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Mobile Shop'**
  String get onboardingTitle;

  /// No description provided for @onboardingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your language and currency to personalize the app.'**
  String get onboardingSubtitle;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get chooseLanguage;

  /// No description provided for @chooseCurrency.
  ///
  /// In en, this message translates to:
  /// **'Choose Currency'**
  String get chooseCurrency;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @languageNameEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageNameEnglish;

  /// No description provided for @languageNameUrdu.
  ///
  /// In en, this message translates to:
  /// **'Urdu'**
  String get languageNameUrdu;

  /// No description provided for @languageNameArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get languageNameArabic;

  /// No description provided for @languageNameSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get languageNameSpanish;

  /// No description provided for @languageNameFrench.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get languageNameFrench;

  /// No description provided for @languageNameGerman.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get languageNameGerman;

  /// No description provided for @languageNameChinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get languageNameChinese;

  /// No description provided for @languageNameTurkish.
  ///
  /// In en, this message translates to:
  /// **'Turkish'**
  String get languageNameTurkish;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'tr',
    'ur',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'tr':
      return AppLocalizationsTr();
    case 'ur':
      return AppLocalizationsUr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

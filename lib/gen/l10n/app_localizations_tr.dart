// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Mobile Shop';

  @override
  String get appSubtitle => 'Profesyonel POS ve Personel Yönetimi';

  @override
  String get appFullTitle => 'Mobile Shop POS';

  @override
  String get versionLabel => 'Sürüm 1.0.0';

  @override
  String get welcomeBack => 'Tekrar hoş geldiniz';

  @override
  String get signInSubtitle =>
      'Mobile Shop hesabınıza devam etmek için giriş yapın';

  @override
  String get email => 'E-posta';

  @override
  String get password => 'Şifre';

  @override
  String get confirmPassword => 'Şifreyi Onayla';

  @override
  String get rememberMe => 'Beni hatırla';

  @override
  String get forgotPassword => 'Şifrenizi mi unuttunuz?';

  @override
  String get login => 'Giriş Yap';

  @override
  String get logout => 'Çıkış Yap';

  @override
  String get createAccount => 'Hesap Oluştur';

  @override
  String get dontHaveAccount => 'Hesabınız yok mu?';

  @override
  String get alreadyHaveAccount => 'Zaten hesabınız var mı?';

  @override
  String get register => 'Kayıt Ol';

  @override
  String get passwordsDoNotMatch => 'Şifreler eşleşmiyor';

  @override
  String get accountCreated => 'Hesap başarıyla oluşturuldu.';

  @override
  String get unableToSignIn => 'Giriş yapılamadı. Lütfen tekrar deneyin.';

  @override
  String get unableToCreateAccount =>
      'Hesap oluşturulamadı. Lütfen tekrar deneyin.';

  @override
  String get resetPassword => 'Şifreyi Sıfırla';

  @override
  String get resetPasswordInstructions =>
      'Enter your email address and we\'ll send you a link to reset your password.';

  @override
  String get sendResetLink => 'Sıfırlama Bağlantısı Gönder';

  @override
  String get resetLinkSent =>
      'Şifre sıfırlama bağlantısı e-postanıza gönderildi.';

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
  String get logoutConfirm => 'Çıkış yapmak istediğinizden emin misiniz?';

  @override
  String get dashboard => 'Kontrol Paneli';

  @override
  String get home => 'Ana Sayfa';

  @override
  String get products => 'Ürünler';

  @override
  String get orders => 'Siparişler';

  @override
  String get staff => 'Personel';

  @override
  String get more => 'Daha Fazla';

  @override
  String get attendance => 'Devam';

  @override
  String get leave => 'İzin';

  @override
  String get salary => 'Maaş';

  @override
  String get profile => 'Profil';

  @override
  String get sales => 'Satışlar';

  @override
  String get welcome => 'Hoş geldiniz';

  @override
  String get quickActions => 'Hızlı İşlemler';

  @override
  String get goodMorning => 'Günaydın';

  @override
  String get goodAfternoon => 'İyi günler';

  @override
  String get goodEvening => 'İyi akşamlar';

  @override
  String get viewAll => 'Tümünü Gör';

  @override
  String get startNewSale => 'Yeni Satış Başlat';

  @override
  String get leaveRequests => 'İzin talepleri';

  @override
  String get salaryRequests => 'Maaş Talepleri';

  @override
  String get noRecentOrders => 'Henüz son sipariş yok.';

  @override
  String get allProductsStocked => 'Tüm ürünler yeterli stokta.';

  @override
  String get loadingDashboard => 'Kontrol paneli yükleniyor...';

  @override
  String get periodDaily => 'G';

  @override
  String get periodWeekly => 'H';

  @override
  String get periodMonthly => 'A';

  @override
  String get periodDailyFull => 'Günlük';

  @override
  String get periodWeeklyFull => 'Haftalık';

  @override
  String get periodMonthlyFull => 'Aylık';

  @override
  String get periodYearly => 'Yıllık';

  @override
  String get manageStaff => 'Personeli Yönet';

  @override
  String get employee => 'Çalışan';

  @override
  String get administrator => 'Yönetici';

  @override
  String get admin => 'Admin';

  @override
  String get user => 'Kullanıcı';

  @override
  String get addStaff => 'Personel Ekle';

  @override
  String get monthlySalary => 'Aylık Maaş';

  @override
  String get useSignupForStaff => 'Yeni personel için Kayıt ekranını kullanın';

  @override
  String get editProfileComingSoon => 'Profil düzenleme yakında';

  @override
  String updateStaffSalary(Object name) {
    return '$name Maaşını Güncelle';
  }

  @override
  String get hrDashboard => 'İK Kontrol Paneli';

  @override
  String get executiveHrOverview => 'Yönetici İK Özeti';

  @override
  String get staffProfile => 'Personel Profili';

  @override
  String get checkIn => 'Giriş Yap';

  @override
  String get checkOut => 'Çıkış Yap';

  @override
  String get checkInNow => 'Şimdi Giriş Yap';

  @override
  String get present => 'Mevcut';

  @override
  String get absent => 'Yok';

  @override
  String get workingHours => 'Çalışma Saatleri';

  @override
  String get attendanceHistory => 'Devam Geçmişi';

  @override
  String get todayAttendance => 'Bugünkü Devam';

  @override
  String get notCheckedIn => 'Giriş yapılmadı';

  @override
  String inAt(Object time) {
    return 'Giriş: $time';
  }

  @override
  String workedDuration(Object duration) {
    return '$duration çalışıldı';
  }

  @override
  String get ongoing => 'Devam ediyor';

  @override
  String get applyLeave => 'İzin Talep Et';

  @override
  String get leaveType => 'İzin Türü';

  @override
  String get startDate => 'Başlangıç Tarihi';

  @override
  String get endDate => 'Bitiş Tarihi';

  @override
  String get reason => 'Sebep';

  @override
  String get pending => 'Beklemede';

  @override
  String get approved => 'Onaylandı';

  @override
  String get rejected => 'Reddedildi';

  @override
  String get unableSubmitLeave =>
      'İzin gönderilemedi: kimliği doğrulanmış kullanıcı yok.';

  @override
  String get leaveSubmitted => 'İzin talebi gönderildi.';

  @override
  String leaveDays(Object count) {
    return '$count gün';
  }

  @override
  String get manageLeaveRequests => 'İzin Taleplerini Yönet';

  @override
  String get noPendingLeaveRequests => 'Bekleyen izin talebi yok.';

  @override
  String periodRange(Object start, Object end) {
    return 'Dönem: $start - $end';
  }

  @override
  String get approveLeave => 'İzni Onayla';

  @override
  String get rejectLeave => 'İzni Reddet';

  @override
  String leaveStatusSuccess(Object status) {
    return 'İzin başarıyla $status.';
  }

  @override
  String get pleaseSignInToViewSalary =>
      'Maaş detaylarını görmek için giriş yapın.';

  @override
  String get salaryOverview => 'Maaş Özeti';

  @override
  String get generatePayroll => 'Bordro Oluştur';

  @override
  String get manageSalaryRequests => 'Maaş Taleplerini Yönet';

  @override
  String get requestSalary => 'Maaş Talep Et';

  @override
  String get salaryHistory => 'Maaş Geçmişi';

  @override
  String get noSalaryRecords => 'Maaş kaydı yok';

  @override
  String get noSalaryRecordsSubtitle =>
      'Oluşturulan veya ödenen maaşlar burada görünecek.';

  @override
  String get unableToLoadSalaryHistory =>
      'Maaş geçmişi yüklenemedi. Lütfen tekrar deneyin.';

  @override
  String get basicSalary => 'Temel Maaş';

  @override
  String get presentDays => 'Devam Günleri';

  @override
  String get estimatedPay => 'Tahmini Ödeme';

  @override
  String get deductions => 'Kesintiler';

  @override
  String get unableToLoadSalaryPreview =>
      'Maaş önizlemesi yüklenemedi. Lütfen tekrar deneyin.';

  @override
  String get payrollGenerated => 'Bordro oluşturuldu!';

  @override
  String monthYearSalary(Object monthYear) {
    return '$monthYear Maaşı';
  }

  @override
  String get netPay => 'Net Ödeme';

  @override
  String get attendancePercentage => 'Devam %';

  @override
  String get baseSalary => 'Temel Maaş';

  @override
  String get noPendingSalaryRequests => 'Bekleyen maaş talebi yok.';

  @override
  String get amount => 'Tutar';

  @override
  String get staffName => 'Staff Name';

  @override
  String get requestDate => 'Request Date';

  @override
  String get reject => 'Reddet';

  @override
  String get approve => 'Onayla';

  @override
  String get approveRequest => 'Talebi Onayla';

  @override
  String get rejectRequest => 'Talebi Reddet';

  @override
  String get adminRemark => 'Yönetici Notu';

  @override
  String requestStatusSuccessfully(Object status) {
    return 'Talep başarıyla $status.';
  }

  @override
  String get newSalaryRequest => 'Yeni Maaş Talebi';

  @override
  String get sendRequest => 'Talep Gönder';

  @override
  String get requestHistory => 'Talep Geçmişi';

  @override
  String get noSalaryRequestsYet => 'Henüz maaş talebi yok.';

  @override
  String get salaryRequestSubmitted => 'Maaş talebi başarıyla gönderildi.';

  @override
  String salaryRequestFailed(Object error) {
    return 'Talep başarısız: $error';
  }

  @override
  String get pleaseSignInSalaryRequests =>
      'Maaş taleplerini görmek için giriş yapın.';

  @override
  String requestedDate(Object date) {
    return 'Talep tarihi: $date';
  }

  @override
  String adminNote(Object note) {
    return 'Yönetici Notu: $note';
  }

  @override
  String get addProduct => 'Ürün Ekle';

  @override
  String get editProduct => 'Ürünü Düzenle';

  @override
  String get deleteProduct => 'Ürünü Sil';

  @override
  String deleteProductConfirm(Object name) {
    return '\"$name\" ürününü silmek istediğinizden emin misiniz?';
  }

  @override
  String productDeleted(Object name) {
    return '$name başarıyla silindi';
  }

  @override
  String get productName => 'Ürün Adı';

  @override
  String get brand => 'Marka';

  @override
  String get model => 'Model';

  @override
  String get price => 'Fiyat';

  @override
  String get stock => 'Stok';

  @override
  String get available => 'Mevcut';

  @override
  String get outOfStock => 'Stokta Yok';

  @override
  String get saveProduct => 'Ürünü Kaydet';

  @override
  String get productAdded => 'Ürün başarıyla eklendi.';

  @override
  String get productUpdated => 'Ürün başarıyla güncellendi';

  @override
  String get productAddedShort => 'Ürün başarıyla eklendi';

  @override
  String get productUpdatedShort => 'Ürün başarıyla güncellendi';

  @override
  String brandLabel(Object brand) {
    return 'Marka: $brand';
  }

  @override
  String modelLabel(Object model) {
    return 'Model: $model';
  }

  @override
  String priceLabel(Object price) {
    return 'Fiyat: $price';
  }

  @override
  String stockLabel(Object quantity) {
    return 'Stok: $quantity';
  }

  @override
  String stockCount(Object count) {
    return '$count kaldı';
  }

  @override
  String profitLabel(Object amount) {
    return 'Kâr: $amount';
  }

  @override
  String get qtyLabel => 'Adet:';

  @override
  String get barcodeLabel => 'Barkod:';

  @override
  String get warranty => 'Garanti';

  @override
  String get warrantyManagement => 'Garanti Yönetimi';

  @override
  String get addWarranty => 'Garanti Ekle';

  @override
  String get warrantyDuration => 'Garanti Süresi';

  @override
  String warrantyMonths(Object months) {
    return '$months ay';
  }

  @override
  String warrantyMonthsShort(Object months) {
    return '$months ay';
  }

  @override
  String get warrantyLabel => 'Garanti:';

  @override
  String get pleaseEnterProductName => 'Lütfen ürün adını girin.';

  @override
  String get warrantyAdded => 'Garanti başarıyla eklendi.';

  @override
  String get warrantyDetails => 'Garanti Detayları';

  @override
  String get deleteWarranty => 'Garantiyi Sil';

  @override
  String get fileClaim => 'Talep Oluştur';

  @override
  String get voidWarranty => 'Garantiyi İptal Et';

  @override
  String get claimHistory => 'Talep Geçmişi';

  @override
  String costLabel(Object amount) {
    return 'Maliyet: $amount';
  }

  @override
  String get active => 'Aktif';

  @override
  String get expired => 'Süresi Doldu';

  @override
  String get expiryDate => 'Son Kullanma Tarihi';

  @override
  String customerLabel(Object name) {
    return 'Müşteri: $name';
  }

  @override
  String get bundles => 'Paketler';

  @override
  String get bundleName => 'Paket Adı';

  @override
  String get createBundle => 'Paket Oluştur';

  @override
  String get sellBundle => 'Paket Sat';

  @override
  String get bundleNotFound => 'Paket bulunamadı.';

  @override
  String get itemsInBundle => 'Paketteki Ürünler';

  @override
  String get addItem => 'Ürün Ekle';

  @override
  String get includedItems => 'Dahil Edilen Ürünler';

  @override
  String get bundlePrice => 'Paket Fiyatı';

  @override
  String get subtotal => 'Ara Toplam';

  @override
  String get finalPrice => 'Son Fiyat';

  @override
  String get discount => 'İndirim';

  @override
  String discountPercent(Object percent) {
    return 'İndirim ($percent%)';
  }

  @override
  String insufficientStock(Object product) {
    return '$product için yetersiz stok';
  }

  @override
  String bundleSold(Object name) {
    return 'Paket satıldı: $name';
  }

  @override
  String get productBundles => 'Ürün Paketleri';

  @override
  String get payment => 'Ödeme';

  @override
  String get paymentConfirmation => 'Ödeme Onayı';

  @override
  String get paymentProof => 'Ödeme Belgesi';

  @override
  String get paymentMethod => 'Ödeme Yöntemi';

  @override
  String get paymentBreakdown => 'Ödeme Detayı';

  @override
  String get cash => 'Nakit';

  @override
  String get card => 'Kart';

  @override
  String get transfer => 'Havale';

  @override
  String get jazzCash => 'JazzCash';

  @override
  String get easyPaisa => 'EasyPaisa';

  @override
  String get credit => 'Kredi';

  @override
  String get accountNumber => 'Hesap Numarası';

  @override
  String get notesOptional => 'Notlar (İsteğe Bağlı)';

  @override
  String get cardReferenceNumber => 'Kart Referans Numarası';

  @override
  String get confirmSale => 'Satışı Onayla';

  @override
  String get totalPrice => 'Toplam Fiyat';

  @override
  String get selectProductFirst => 'Önce bir ürün seçin.';

  @override
  String onePointDiscount(Object amount) {
    return '1 puan = $amount indirim';
  }

  @override
  String get salesScreen => 'Satış Ekranı';

  @override
  String get sendReceipt => 'Fiş Gönder';

  @override
  String get sendViaWhatsApp => 'WhatsApp ile Gönder';

  @override
  String get sendViaEmail => 'E-posta ile Gönder';

  @override
  String get sendViaSms => 'SMS ile Gönder';

  @override
  String get share => 'Paylaş';

  @override
  String get sendToPhoneNumber => 'Telefon Numarasına Gönder';

  @override
  String get phoneNumberHint =>
      'Fiş gönderimi için geçerli bir telefon numarası girin.';

  @override
  String get send => 'Gönder';

  @override
  String get emailNotAvailable => 'E-posta adresi mevcut değil.';

  @override
  String get newSale => 'Yeni Satış';

  @override
  String get orderDetails => 'Sipariş Detayları';

  @override
  String get orderNumber => 'Sipariş #';

  @override
  String get quantity => 'Miktar';

  @override
  String get total => 'Toplam';

  @override
  String get customer => 'Müşteri';

  @override
  String get viewDetails => 'Detayları Gör';

  @override
  String get walkInCustomer => 'Gelen Müşteri';

  @override
  String get manage => 'Yönet';

  @override
  String get customers => 'Müşteriler';

  @override
  String get deleteCustomer => 'Müşteri Silinsin mi?';

  @override
  String get searchCustomers => 'Ad veya telefonla ara...';

  @override
  String get noCustomersFound => 'Müşteri bulunamadı';

  @override
  String get repayCredit => 'Krediyi Öde';

  @override
  String get repay => 'Öde';

  @override
  String get phone => 'Telefon';

  @override
  String get address => 'Adres';

  @override
  String get repeatCustomer => 'Tekrarlayan Müşteri';

  @override
  String get favoriteProducts => 'Favori Ürünler';

  @override
  String get noPurchasesYet => 'Henüz alışveriş yok';

  @override
  String get addCustomer => 'Müşteri Ekle';

  @override
  String get updateCustomer => 'Müşteriyi Güncelle';

  @override
  String pointsEarned(Object points) {
    return '+$points puan';
  }

  @override
  String get reports => 'Raporlar';

  @override
  String get noDataToExport => 'Dışa aktarılacak veri yok.';

  @override
  String get recentTransactions => 'Son İşlemler';

  @override
  String get noTransactionsPeriod => 'Bu dönem için işlem yok.';

  @override
  String get bestSellingProducts => 'En Çok Satan Ürünler';

  @override
  String get profitWord => 'kâr';

  @override
  String get firebaseBackups => 'Firebase Yedekleri';

  @override
  String get noBackupsFound => 'Yedek bulunamadı';

  @override
  String get restoreBackup => 'Yedeği Geri Yükle';

  @override
  String get restoreBackupConfirm =>
      'Bu işlem yerel verileri değiştirecek. Devam edilsin mi?';

  @override
  String get backupHistory => 'Yedekleme Geçmişi';

  @override
  String get notificationSettings => 'Bildirim Ayarları';

  @override
  String get enableNotifications => 'Bildirimleri Etkinleştir';

  @override
  String get lowStockWarnings => 'Düşük Stok Uyarıları';

  @override
  String get dailySalesReminder => 'Günlük Satış Hatırlatıcısı';

  @override
  String get exportLocalBackup => 'Yerel Yedek Dışa Aktar';

  @override
  String get backupToFirebase => 'Firebase\'e Yedekle';

  @override
  String get restoreFromFirebase => 'Firebase\'den Geri Yükle';

  @override
  String get notificationSettingsComingSoon => 'Bildirim ayarları yakında!';

  @override
  String get settings => 'Ayarlar';

  @override
  String get appearance => 'Görünüm';

  @override
  String get language => 'Dil';

  @override
  String get currency => 'Para Birimi';

  @override
  String get notifications => 'Bildirimler';

  @override
  String get selectLanguage => 'Dil Seç';

  @override
  String get selectCurrency => 'Para Birimi Seç';

  @override
  String get searchCurrency => 'Para birimi ara...';

  @override
  String get searchLanguage => 'Dil ara...';

  @override
  String get general => 'Genel';

  @override
  String get account => 'Hesap';

  @override
  String get theme => 'Tema';

  @override
  String get light => 'Açık';

  @override
  String get dark => 'Koyu';

  @override
  String get systemDefault => 'Sistem Varsayılanı';

  @override
  String get about => 'Hakkında';

  @override
  String get shopTools => 'Mağaza Araçları';

  @override
  String get shopToolsSubtitle =>
      'Garanti, paketler, raporlar ve hesap ayarları';

  @override
  String get editProfile => 'Profili Düzenle';

  @override
  String get unableToLoadProfile =>
      'Profil yüklenemedi. Lütfen tekrar deneyin.';

  @override
  String get accessDenied => 'Erişim Reddedildi';

  @override
  String get accessDeniedMessage =>
      'You do not have permission to access this page.\nPlease contact your administrator.';

  @override
  String get goBack => 'Geri Dön';

  @override
  String get cancel => 'İptal';

  @override
  String get save => 'Kaydet';

  @override
  String get submit => 'Gönder';

  @override
  String get delete => 'Sil';

  @override
  String get edit => 'Düzenle';

  @override
  String get view => 'Görüntüle';

  @override
  String get close => 'Kapat';

  @override
  String get update => 'Güncelle';

  @override
  String errorGeneric(Object error) {
    return 'Hata: $error';
  }

  @override
  String get continueAction => 'Devam Et';

  @override
  String get yes => 'Evet';

  @override
  String get no => 'Hayır';

  @override
  String get ok => 'Tamam';

  @override
  String get onboardingTitle => 'Mobile Shop\'a Hoş Geldiniz';

  @override
  String get onboardingSubtitle =>
      'Uygulamayı kişiselleştirmek için dil ve para biriminizi seçin.';

  @override
  String get chooseLanguage => 'Dil Seçin';

  @override
  String get chooseCurrency => 'Para Birimi Seçin';

  @override
  String get getStarted => 'Başlayın';

  @override
  String get languageNameEnglish => 'İngilizce';

  @override
  String get languageNameUrdu => 'Urduca';

  @override
  String get languageNameArabic => 'Arapça';

  @override
  String get languageNameSpanish => 'İspanyolca';

  @override
  String get languageNameFrench => 'Fransızca';

  @override
  String get languageNameGerman => 'Almanca';

  @override
  String get languageNameChinese => 'Çince';

  @override
  String get languageNameTurkish => 'Türkçe';
}

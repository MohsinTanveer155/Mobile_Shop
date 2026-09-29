// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Mobile Shop';

  @override
  String get appSubtitle => 'Professionelles Kassensystem & Personalverwaltung';

  @override
  String get appFullTitle => 'Mobile Shop POS';

  @override
  String get versionLabel => 'Version 1.0.0';

  @override
  String get welcomeBack => 'Willkommen zurück';

  @override
  String get signInSubtitle =>
      'Melden Sie sich an, um zu Ihrem Mobile-Shop-Konto fortzufahren';

  @override
  String get email => 'E-Mail';

  @override
  String get password => 'Passwort';

  @override
  String get confirmPassword => 'Passwort bestätigen';

  @override
  String get rememberMe => 'Angemeldet bleiben';

  @override
  String get forgotPassword => 'Passwort vergessen?';

  @override
  String get login => 'Anmelden';

  @override
  String get logout => 'Abmelden';

  @override
  String get createAccount => 'Konto erstellen';

  @override
  String get dontHaveAccount => 'Noch kein Konto?';

  @override
  String get alreadyHaveAccount => 'Bereits ein Konto?';

  @override
  String get register => 'Registrieren';

  @override
  String get passwordsDoNotMatch => 'Passwörter stimmen nicht überein';

  @override
  String get accountCreated => 'Konto erfolgreich erstellt.';

  @override
  String get unableToSignIn =>
      'Anmeldung nicht möglich. Bitte versuchen Sie es erneut.';

  @override
  String get unableToCreateAccount =>
      'Konto konnte nicht erstellt werden. Bitte versuchen Sie es erneut.';

  @override
  String get resetPassword => 'Passwort zurücksetzen';

  @override
  String get resetPasswordInstructions =>
      'Enter your email address and we\'ll send you a link to reset your password.';

  @override
  String get sendResetLink => 'Link zum Zurücksetzen senden';

  @override
  String get resetLinkSent =>
      'Link zum Zurücksetzen des Passworts wurde an Ihre E-Mail gesendet.';

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
  String get logoutConfirm => 'Möchten Sie sich wirklich abmelden?';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get home => 'Startseite';

  @override
  String get products => 'Produkte';

  @override
  String get orders => 'Bestellungen';

  @override
  String get staff => 'Personal';

  @override
  String get more => 'Mehr';

  @override
  String get attendance => 'Anwesenheit';

  @override
  String get leave => 'Urlaub';

  @override
  String get salary => 'Gehalt';

  @override
  String get profile => 'Profil';

  @override
  String get sales => 'Verkäufe';

  @override
  String get welcome => 'Willkommen';

  @override
  String get quickActions => 'Schnellaktionen';

  @override
  String get goodMorning => 'Guten Morgen';

  @override
  String get goodAfternoon => 'Guten Tag';

  @override
  String get goodEvening => 'Guten Abend';

  @override
  String get viewAll => 'Alle anzeigen';

  @override
  String get startNewSale => 'Neuen Verkauf starten';

  @override
  String get leaveRequests => 'Urlaubsanträge';

  @override
  String get salaryRequests => 'Gehaltsanträge';

  @override
  String get noRecentOrders => 'Noch keine aktuellen Bestellungen.';

  @override
  String get allProductsStocked => 'Alle Produkte sind ausreichend auf Lager.';

  @override
  String get loadingDashboard => 'Dashboard wird geladen...';

  @override
  String get periodDaily => 'T';

  @override
  String get periodWeekly => 'W';

  @override
  String get periodMonthly => 'M';

  @override
  String get periodDailyFull => 'Täglich';

  @override
  String get periodWeeklyFull => 'Wöchentlich';

  @override
  String get periodMonthlyFull => 'Monatlich';

  @override
  String get periodYearly => 'Jährlich';

  @override
  String get manageStaff => 'Personal verwalten';

  @override
  String get employee => 'Mitarbeiter';

  @override
  String get administrator => 'Administrator';

  @override
  String get admin => 'Admin';

  @override
  String get user => 'Benutzer';

  @override
  String get addStaff => 'Personal hinzufügen';

  @override
  String get monthlySalary => 'Monatsgehalt';

  @override
  String get useSignupForStaff =>
      'Registrierungsbildschirm für neues Personal verwenden';

  @override
  String get editProfileComingSoon => 'Profilbearbeitung demnächst verfügbar';

  @override
  String updateStaffSalary(Object name) {
    return 'Gehalt von $name aktualisieren';
  }

  @override
  String get hrDashboard => 'HR-Dashboard';

  @override
  String get executiveHrOverview => 'Geschäftsführungsübersicht HR';

  @override
  String get staffProfile => 'Mitarbeiterprofil';

  @override
  String get checkIn => 'Einchecken';

  @override
  String get checkOut => 'Auschecken';

  @override
  String get checkInNow => 'Jetzt einchecken';

  @override
  String get present => 'Anwesend';

  @override
  String get absent => 'Abwesend';

  @override
  String get workingHours => 'Arbeitszeiten';

  @override
  String get attendanceHistory => 'Anwesenheitshistorie';

  @override
  String get todayAttendance => 'Heutige Anwesenheit';

  @override
  String get notCheckedIn => 'Nicht eingecheckt';

  @override
  String inAt(Object time) {
    return 'Eingestempelt um $time';
  }

  @override
  String workedDuration(Object duration) {
    return '$duration gearbeitet';
  }

  @override
  String get ongoing => 'Laufend';

  @override
  String get applyLeave => 'Urlaub beantragen';

  @override
  String get leaveType => 'Urlaubsart';

  @override
  String get startDate => 'Startdatum';

  @override
  String get endDate => 'Enddatum';

  @override
  String get reason => 'Grund';

  @override
  String get pending => 'Ausstehend';

  @override
  String get approved => 'Genehmigt';

  @override
  String get rejected => 'Abgelehnt';

  @override
  String get unableSubmitLeave =>
      'Urlaubsantrag konnte nicht gesendet werden: kein authentifizierter Benutzer.';

  @override
  String get leaveSubmitted => 'Urlaubsantrag eingereicht.';

  @override
  String leaveDays(Object count) {
    return '$count Tag(e)';
  }

  @override
  String get manageLeaveRequests => 'Urlaubsanträge verwalten';

  @override
  String get noPendingLeaveRequests => 'Keine ausstehenden Urlaubsanträge.';

  @override
  String periodRange(Object start, Object end) {
    return 'Zeitraum: $start - $end';
  }

  @override
  String get approveLeave => 'Urlaub genehmigen';

  @override
  String get rejectLeave => 'Urlaub ablehnen';

  @override
  String leaveStatusSuccess(Object status) {
    return 'Urlaub erfolgreich $status.';
  }

  @override
  String get pleaseSignInToViewSalary =>
      'Bitte melden Sie sich an, um Gehaltsdetails anzuzeigen.';

  @override
  String get salaryOverview => 'Gehaltsübersicht';

  @override
  String get generatePayroll => 'Gehaltsabrechnung erstellen';

  @override
  String get manageSalaryRequests => 'Gehaltsanträge verwalten';

  @override
  String get requestSalary => 'Gehalt beantragen';

  @override
  String get salaryHistory => 'Gehaltshistorie';

  @override
  String get noSalaryRecords => 'Keine Gehaltsdatensätze';

  @override
  String get noSalaryRecordsSubtitle =>
      'Erstellte oder ausgezahlte Gehälter werden hier angezeigt.';

  @override
  String get unableToLoadSalaryHistory =>
      'Gehaltshistorie konnte nicht geladen werden. Bitte versuchen Sie es erneut.';

  @override
  String get basicSalary => 'Grundgehalt';

  @override
  String get presentDays => 'Anwesenheitstage';

  @override
  String get estimatedPay => 'Geschätzte Auszahlung';

  @override
  String get deductions => 'Abzüge';

  @override
  String get unableToLoadSalaryPreview =>
      'Gehaltsvorschau konnte nicht geladen werden. Bitte versuchen Sie es erneut.';

  @override
  String get payrollGenerated => 'Gehaltsabrechnung erstellt!';

  @override
  String monthYearSalary(Object monthYear) {
    return 'Gehalt $monthYear';
  }

  @override
  String get netPay => 'Nettoauszahlung';

  @override
  String get attendancePercentage => 'Anwesenheit %';

  @override
  String get baseSalary => 'Grundgehalt';

  @override
  String get noPendingSalaryRequests => 'Keine ausstehenden Gehaltsanträge.';

  @override
  String get amount => 'Betrag';

  @override
  String get staffName => 'Staff Name';

  @override
  String get requestDate => 'Request Date';

  @override
  String get reject => 'Ablehnen';

  @override
  String get approve => 'Genehmigen';

  @override
  String get approveRequest => 'Antrag genehmigen';

  @override
  String get rejectRequest => 'Antrag ablehnen';

  @override
  String get adminRemark => 'Admin-Anmerkung';

  @override
  String requestStatusSuccessfully(Object status) {
    return 'Antrag erfolgreich $status.';
  }

  @override
  String get newSalaryRequest => 'Neuer Gehaltsantrag';

  @override
  String get sendRequest => 'Antrag senden';

  @override
  String get requestHistory => 'Antragshistorie';

  @override
  String get noSalaryRequestsYet => 'Noch keine Gehaltsanträge.';

  @override
  String get salaryRequestSubmitted => 'Gehaltsantrag erfolgreich eingereicht.';

  @override
  String salaryRequestFailed(Object error) {
    return 'Antrag fehlgeschlagen: $error';
  }

  @override
  String get pleaseSignInSalaryRequests =>
      'Bitte melden Sie sich an, um Gehaltsanträge anzuzeigen.';

  @override
  String requestedDate(Object date) {
    return 'Beantragt: $date';
  }

  @override
  String adminNote(Object note) {
    return 'Admin-Hinweis: $note';
  }

  @override
  String get addProduct => 'Produkt hinzufügen';

  @override
  String get editProduct => 'Produkt bearbeiten';

  @override
  String get deleteProduct => 'Produkt löschen';

  @override
  String deleteProductConfirm(Object name) {
    return 'Möchten Sie \"$name\" wirklich löschen?';
  }

  @override
  String productDeleted(Object name) {
    return '$name erfolgreich gelöscht';
  }

  @override
  String get productName => 'Produktname';

  @override
  String get brand => 'Marke';

  @override
  String get model => 'Modell';

  @override
  String get price => 'Preis';

  @override
  String get stock => 'Bestand';

  @override
  String get available => 'Verfügbar';

  @override
  String get outOfStock => 'Nicht auf Lager';

  @override
  String get saveProduct => 'Produkt speichern';

  @override
  String get productAdded => 'Produkt erfolgreich hinzugefügt.';

  @override
  String get productUpdated => 'Produkt erfolgreich aktualisiert';

  @override
  String get productAddedShort => 'Produkt erfolgreich hinzugefügt';

  @override
  String get productUpdatedShort => 'Produkt erfolgreich aktualisiert';

  @override
  String brandLabel(Object brand) {
    return 'Marke: $brand';
  }

  @override
  String modelLabel(Object model) {
    return 'Modell: $model';
  }

  @override
  String priceLabel(Object price) {
    return 'Preis: $price';
  }

  @override
  String stockLabel(Object quantity) {
    return 'Bestand: $quantity';
  }

  @override
  String stockCount(Object count) {
    return '$count übrig';
  }

  @override
  String profitLabel(Object amount) {
    return 'Gewinn: $amount';
  }

  @override
  String get qtyLabel => 'Menge:';

  @override
  String get barcodeLabel => 'Barcode:';

  @override
  String get warranty => 'Garantie';

  @override
  String get warrantyManagement => 'Garantieverwaltung';

  @override
  String get addWarranty => 'Garantie hinzufügen';

  @override
  String get warrantyDuration => 'Garantiedauer';

  @override
  String warrantyMonths(Object months) {
    return '$months Monate';
  }

  @override
  String warrantyMonthsShort(Object months) {
    return '$months Mon.';
  }

  @override
  String get warrantyLabel => 'Garantie:';

  @override
  String get pleaseEnterProductName => 'Bitte geben Sie den Produktnamen ein.';

  @override
  String get warrantyAdded => 'Garantie erfolgreich hinzugefügt.';

  @override
  String get warrantyDetails => 'Garantiedetails';

  @override
  String get deleteWarranty => 'Garantie löschen';

  @override
  String get fileClaim => 'Reklamation einreichen';

  @override
  String get voidWarranty => 'Garantie ungültig machen';

  @override
  String get claimHistory => 'Reklamationshistorie';

  @override
  String costLabel(Object amount) {
    return 'Kosten: $amount';
  }

  @override
  String get active => 'Aktiv';

  @override
  String get expired => 'Abgelaufen';

  @override
  String get expiryDate => 'Ablaufdatum';

  @override
  String customerLabel(Object name) {
    return 'Kunde: $name';
  }

  @override
  String get bundles => 'Pakete';

  @override
  String get bundleName => 'Paketname';

  @override
  String get createBundle => 'Paket erstellen';

  @override
  String get sellBundle => 'Paket verkaufen';

  @override
  String get bundleNotFound => 'Paket nicht gefunden.';

  @override
  String get itemsInBundle => 'Artikel im Paket';

  @override
  String get addItem => 'Artikel hinzufügen';

  @override
  String get includedItems => 'Enthaltene Artikel';

  @override
  String get bundlePrice => 'Paketpreis';

  @override
  String get subtotal => 'Zwischensumme';

  @override
  String get finalPrice => 'Endpreis';

  @override
  String get discount => 'Rabatt';

  @override
  String discountPercent(Object percent) {
    return 'Rabatt ($percent%)';
  }

  @override
  String insufficientStock(Object product) {
    return 'Unzureichender Bestand für $product';
  }

  @override
  String bundleSold(Object name) {
    return 'Paket verkauft: $name';
  }

  @override
  String get productBundles => 'Produktpakete';

  @override
  String get payment => 'Zahlung';

  @override
  String get paymentConfirmation => 'Zahlungsbestätigung';

  @override
  String get paymentProof => 'Zahlungsnachweis';

  @override
  String get paymentMethod => 'Zahlungsmethode';

  @override
  String get paymentBreakdown => 'Zahlungsaufschlüsselung';

  @override
  String get cash => 'Bar';

  @override
  String get card => 'Karte';

  @override
  String get transfer => 'Überweisung';

  @override
  String get jazzCash => 'JazzCash';

  @override
  String get easyPaisa => 'EasyPaisa';

  @override
  String get credit => 'Kredit';

  @override
  String get accountNumber => 'Kontonummer';

  @override
  String get notesOptional => 'Notizen (optional)';

  @override
  String get cardReferenceNumber => 'Kartenreferenznummer';

  @override
  String get confirmSale => 'Verkauf bestätigen';

  @override
  String get totalPrice => 'Gesamtpreis';

  @override
  String get selectProductFirst => 'Wählen Sie zuerst ein Produkt aus.';

  @override
  String onePointDiscount(Object amount) {
    return '1 Punkt = $amount Rabatt';
  }

  @override
  String get salesScreen => 'Verkaufsbildschirm';

  @override
  String get sendReceipt => 'Beleg senden';

  @override
  String get sendViaWhatsApp => 'Per WhatsApp senden';

  @override
  String get sendViaEmail => 'Per E-Mail senden';

  @override
  String get sendViaSms => 'Per SMS senden';

  @override
  String get share => 'Teilen';

  @override
  String get sendToPhoneNumber => 'An Telefonnummer senden';

  @override
  String get phoneNumberHint =>
      'Geben Sie eine gültige Telefonnummer für den Belegversand ein.';

  @override
  String get send => 'Senden';

  @override
  String get emailNotAvailable => 'E-Mail-Adresse nicht verfügbar.';

  @override
  String get newSale => 'Neuer Verkauf';

  @override
  String get orderDetails => 'Bestelldetails';

  @override
  String get orderNumber => 'Bestellung #';

  @override
  String get quantity => 'Menge';

  @override
  String get total => 'Gesamt';

  @override
  String get customer => 'Kunde';

  @override
  String get viewDetails => 'Details anzeigen';

  @override
  String get walkInCustomer => 'Laufkunde';

  @override
  String get manage => 'Verwalten';

  @override
  String get customers => 'Kunden';

  @override
  String get deleteCustomer => 'Kunde löschen?';

  @override
  String get searchCustomers => 'Nach Name oder Telefon suchen...';

  @override
  String get noCustomersFound => 'Keine Kunden gefunden';

  @override
  String get repayCredit => 'Kredit zurückzahlen';

  @override
  String get repay => 'Zurückzahlen';

  @override
  String get phone => 'Telefon';

  @override
  String get address => 'Adresse';

  @override
  String get repeatCustomer => 'Stammkunde';

  @override
  String get favoriteProducts => 'Lieblingsprodukte';

  @override
  String get noPurchasesYet => 'Noch keine Käufe';

  @override
  String get addCustomer => 'Kunde hinzufügen';

  @override
  String get updateCustomer => 'Kunde aktualisieren';

  @override
  String pointsEarned(Object points) {
    return '+$points Pkt.';
  }

  @override
  String get reports => 'Berichte';

  @override
  String get noDataToExport => 'Keine Daten zum Exportieren.';

  @override
  String get recentTransactions => 'Letzte Transaktionen';

  @override
  String get noTransactionsPeriod => 'Keine Transaktionen in diesem Zeitraum.';

  @override
  String get bestSellingProducts => 'Bestseller';

  @override
  String get profitWord => 'Gewinn';

  @override
  String get firebaseBackups => 'Firebase-Sicherungen';

  @override
  String get noBackupsFound => 'Keine Sicherungen gefunden';

  @override
  String get restoreBackup => 'Sicherung wiederherstellen';

  @override
  String get restoreBackupConfirm => 'Dies ersetzt lokale Daten. Fortfahren?';

  @override
  String get backupHistory => 'Sicherungshistorie';

  @override
  String get notificationSettings => 'Benachrichtigungseinstellungen';

  @override
  String get enableNotifications => 'Benachrichtigungen aktivieren';

  @override
  String get lowStockWarnings => 'Warnungen bei niedrigem Bestand';

  @override
  String get dailySalesReminder => 'Tägliche Verkaufserinnerung';

  @override
  String get exportLocalBackup => 'Lokale Sicherung exportieren';

  @override
  String get backupToFirebase => 'In Firebase sichern';

  @override
  String get restoreFromFirebase => 'Aus Firebase wiederherstellen';

  @override
  String get notificationSettingsComingSoon =>
      'Benachrichtigungseinstellungen demnächst verfügbar!';

  @override
  String get settings => 'Einstellungen';

  @override
  String get appearance => 'Erscheinungsbild';

  @override
  String get language => 'Sprache';

  @override
  String get currency => 'Währung';

  @override
  String get notifications => 'Benachrichtigungen';

  @override
  String get selectLanguage => 'Sprache auswählen';

  @override
  String get selectCurrency => 'Währung auswählen';

  @override
  String get searchCurrency => 'Währung suchen...';

  @override
  String get searchLanguage => 'Sprache suchen...';

  @override
  String get general => 'Allgemein';

  @override
  String get account => 'Konto';

  @override
  String get theme => 'Design';

  @override
  String get light => 'Hell';

  @override
  String get dark => 'Dunkel';

  @override
  String get systemDefault => 'Systemstandard';

  @override
  String get about => 'Über';

  @override
  String get shopTools => 'Shop-Tools';

  @override
  String get shopToolsSubtitle =>
      'Garantie, Pakete, Berichte und Kontoeinstellungen';

  @override
  String get editProfile => 'Profil bearbeiten';

  @override
  String get unableToLoadProfile =>
      'Profil konnte nicht geladen werden. Bitte versuchen Sie es erneut.';

  @override
  String get accessDenied => 'Zugriff verweigert';

  @override
  String get accessDeniedMessage =>
      'You do not have permission to access this page.\nPlease contact your administrator.';

  @override
  String get goBack => 'Zurück';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get save => 'Speichern';

  @override
  String get submit => 'Absenden';

  @override
  String get delete => 'Löschen';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get view => 'Anzeigen';

  @override
  String get close => 'Schließen';

  @override
  String get update => 'Aktualisieren';

  @override
  String errorGeneric(Object error) {
    return 'Fehler: $error';
  }

  @override
  String get continueAction => 'Weiter';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'Nein';

  @override
  String get ok => 'OK';

  @override
  String get onboardingTitle => 'Willkommen bei Mobile Shop';

  @override
  String get onboardingSubtitle =>
      'Wählen Sie Sprache und Währung, um die App anzupassen.';

  @override
  String get chooseLanguage => 'Sprache wählen';

  @override
  String get chooseCurrency => 'Währung wählen';

  @override
  String get getStarted => 'Loslegen';

  @override
  String get languageNameEnglish => 'Englisch';

  @override
  String get languageNameUrdu => 'Urdu';

  @override
  String get languageNameArabic => 'Arabisch';

  @override
  String get languageNameSpanish => 'Spanisch';

  @override
  String get languageNameFrench => 'Französisch';

  @override
  String get languageNameGerman => 'Deutsch';

  @override
  String get languageNameChinese => 'Chinesisch';

  @override
  String get languageNameTurkish => 'Türkisch';
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Mobile Shop';

  @override
  String get appSubtitle => 'Caisse professionnelle et gestion du personnel';

  @override
  String get appFullTitle => 'Mobile Shop POS';

  @override
  String get versionLabel => 'Version 1.0.0';

  @override
  String get welcomeBack => 'Bon retour';

  @override
  String get signInSubtitle =>
      'Connectez-vous pour accéder à votre compte Mobile Shop';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Mot de passe';

  @override
  String get confirmPassword => 'Confirmer le mot de passe';

  @override
  String get rememberMe => 'Se souvenir de moi';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get login => 'Connexion';

  @override
  String get logout => 'Déconnexion';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get dontHaveAccount => 'Vous n\'avez pas de compte ?';

  @override
  String get alreadyHaveAccount => 'Vous avez déjà un compte ?';

  @override
  String get register => 'S\'inscrire';

  @override
  String get passwordsDoNotMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get accountCreated => 'Compte créé avec succès.';

  @override
  String get unableToSignIn => 'Connexion impossible. Veuillez réessayer.';

  @override
  String get unableToCreateAccount =>
      'Impossible de créer le compte. Veuillez réessayer.';

  @override
  String get resetPassword => 'Réinitialiser le mot de passe';

  @override
  String get resetPasswordInstructions =>
      'Enter your email address and we\'ll send you a link to reset your password.';

  @override
  String get sendResetLink => 'Envoyer le lien de réinitialisation';

  @override
  String get resetLinkSent => 'Lien de réinitialisation envoyé à votre e-mail.';

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
  String get logoutConfirm => 'Voulez-vous vraiment vous déconnecter ?';

  @override
  String get dashboard => 'Tableau de bord';

  @override
  String get home => 'Accueil';

  @override
  String get products => 'Produits';

  @override
  String get orders => 'Commandes';

  @override
  String get staff => 'Personnel';

  @override
  String get more => 'Plus';

  @override
  String get attendance => 'Présence';

  @override
  String get leave => 'Congé';

  @override
  String get salary => 'Salaire';

  @override
  String get profile => 'Profil';

  @override
  String get sales => 'Ventes';

  @override
  String get welcome => 'Bienvenue';

  @override
  String get quickActions => 'Actions rapides';

  @override
  String get goodMorning => 'Bonjour';

  @override
  String get goodAfternoon => 'Bon après-midi';

  @override
  String get goodEvening => 'Bonsoir';

  @override
  String get viewAll => 'Tout voir';

  @override
  String get startNewSale => 'Nouvelle vente';

  @override
  String get leaveRequests => 'Demandes de congé';

  @override
  String get salaryRequests => 'Demandes de salaire';

  @override
  String get noRecentOrders => 'Aucune commande récente pour le moment.';

  @override
  String get allProductsStocked =>
      'Tous les produits sont suffisamment en stock.';

  @override
  String get loadingDashboard => 'Chargement du tableau de bord...';

  @override
  String get periodDaily => 'J';

  @override
  String get periodWeekly => 'S';

  @override
  String get periodMonthly => 'M';

  @override
  String get periodDailyFull => 'Quotidien';

  @override
  String get periodWeeklyFull => 'Hebdomadaire';

  @override
  String get periodMonthlyFull => 'Mensuel';

  @override
  String get periodYearly => 'Annuel';

  @override
  String get manageStaff => 'Gérer le personnel';

  @override
  String get employee => 'Employé';

  @override
  String get administrator => 'Administrateur';

  @override
  String get admin => 'Admin';

  @override
  String get user => 'Utilisateur';

  @override
  String get addStaff => 'Ajouter du personnel';

  @override
  String get monthlySalary => 'Salaire mensuel';

  @override
  String get useSignupForStaff =>
      'Utilisez l\'écran d\'inscription pour le nouveau personnel';

  @override
  String get editProfileComingSoon =>
      'Modification du profil bientôt disponible';

  @override
  String updateStaffSalary(Object name) {
    return 'Mettre à jour le salaire de $name';
  }

  @override
  String get hrDashboard => 'Tableau de bord RH';

  @override
  String get executiveHrOverview => 'Aperçu RH exécutif';

  @override
  String get staffProfile => 'Profil du personnel';

  @override
  String get checkIn => 'Pointage d\'entrée';

  @override
  String get checkOut => 'Pointage de sortie';

  @override
  String get checkInNow => 'Pointer maintenant';

  @override
  String get present => 'Présent';

  @override
  String get absent => 'Absent';

  @override
  String get workingHours => 'Heures de travail';

  @override
  String get attendanceHistory => 'Historique de présence';

  @override
  String get todayAttendance => 'Présence du jour';

  @override
  String get notCheckedIn => 'Non pointé';

  @override
  String inAt(Object time) {
    return 'Entrée à $time';
  }

  @override
  String workedDuration(Object duration) {
    return '$duration travaillées';
  }

  @override
  String get ongoing => 'En cours';

  @override
  String get applyLeave => 'Demander un congé';

  @override
  String get leaveType => 'Type de congé';

  @override
  String get startDate => 'Date de début';

  @override
  String get endDate => 'Date de fin';

  @override
  String get reason => 'Motif';

  @override
  String get pending => 'En attente';

  @override
  String get approved => 'Approuvé';

  @override
  String get rejected => 'Rejeté';

  @override
  String get unableSubmitLeave =>
      'Impossible d\'envoyer la demande : aucun utilisateur authentifié.';

  @override
  String get leaveSubmitted => 'Demande de congé envoyée.';

  @override
  String leaveDays(Object count) {
    return '$count jour(s)';
  }

  @override
  String get manageLeaveRequests => 'Gérer les demandes de congé';

  @override
  String get noPendingLeaveRequests => 'Aucune demande de congé en attente.';

  @override
  String periodRange(Object start, Object end) {
    return 'Période : $start - $end';
  }

  @override
  String get approveLeave => 'Approuver le congé';

  @override
  String get rejectLeave => 'Rejeter le congé';

  @override
  String leaveStatusSuccess(Object status) {
    return 'Congé $status avec succès.';
  }

  @override
  String get pleaseSignInToViewSalary =>
      'Connectez-vous pour voir les détails du salaire.';

  @override
  String get salaryOverview => 'Aperçu du salaire';

  @override
  String get generatePayroll => 'Générer la paie';

  @override
  String get manageSalaryRequests => 'Gérer les demandes de salaire';

  @override
  String get requestSalary => 'Demander un salaire';

  @override
  String get salaryHistory => 'Historique des salaires';

  @override
  String get noSalaryRecords => 'Aucun enregistrement de salaire';

  @override
  String get noSalaryRecordsSubtitle =>
      'Les salaires générés ou payés apparaîtront ici.';

  @override
  String get unableToLoadSalaryHistory =>
      'Impossible de charger l\'historique des salaires. Veuillez réessayer.';

  @override
  String get basicSalary => 'Salaire de base';

  @override
  String get presentDays => 'Jours de présence';

  @override
  String get estimatedPay => 'Paiement estimé';

  @override
  String get deductions => 'Déductions';

  @override
  String get unableToLoadSalaryPreview =>
      'Impossible de charger l\'aperçu du salaire. Veuillez réessayer.';

  @override
  String get payrollGenerated => 'Paie générée !';

  @override
  String monthYearSalary(Object monthYear) {
    return 'Salaire de $monthYear';
  }

  @override
  String get netPay => 'Salaire net';

  @override
  String get attendancePercentage => 'Présence %';

  @override
  String get baseSalary => 'Salaire de base';

  @override
  String get noPendingSalaryRequests => 'Aucune demande de salaire en attente.';

  @override
  String get amount => 'Montant';

  @override
  String get staffName => 'Staff Name';

  @override
  String get requestDate => 'Request Date';

  @override
  String get reject => 'Rejeter';

  @override
  String get approve => 'Approuver';

  @override
  String get approveRequest => 'Approuver la demande';

  @override
  String get rejectRequest => 'Rejeter la demande';

  @override
  String get adminRemark => 'Remarque de l\'administrateur';

  @override
  String requestStatusSuccessfully(Object status) {
    return 'Demande $status avec succès.';
  }

  @override
  String get newSalaryRequest => 'Nouvelle demande de salaire';

  @override
  String get sendRequest => 'Envoyer la demande';

  @override
  String get requestHistory => 'Historique des demandes';

  @override
  String get noSalaryRequestsYet => 'Aucune demande de salaire pour le moment.';

  @override
  String get salaryRequestSubmitted =>
      'Demande de salaire envoyée avec succès.';

  @override
  String salaryRequestFailed(Object error) {
    return 'Échec de la demande : $error';
  }

  @override
  String get pleaseSignInSalaryRequests =>
      'Connectez-vous pour voir les demandes de salaire.';

  @override
  String requestedDate(Object date) {
    return 'Demandé le : $date';
  }

  @override
  String adminNote(Object note) {
    return 'Note de l\'administrateur : $note';
  }

  @override
  String get addProduct => 'Ajouter un produit';

  @override
  String get editProduct => 'Modifier le produit';

  @override
  String get deleteProduct => 'Supprimer le produit';

  @override
  String deleteProductConfirm(Object name) {
    return 'Voulez-vous vraiment supprimer « $name » ?';
  }

  @override
  String productDeleted(Object name) {
    return '$name supprimé avec succès';
  }

  @override
  String get productName => 'Nom du produit';

  @override
  String get brand => 'Marque';

  @override
  String get model => 'Modèle';

  @override
  String get price => 'Prix';

  @override
  String get stock => 'Stock';

  @override
  String get available => 'Disponible';

  @override
  String get outOfStock => 'Rupture de stock';

  @override
  String get saveProduct => 'Enregistrer le produit';

  @override
  String get productAdded => 'Produit ajouté avec succès.';

  @override
  String get productUpdated => 'Produit mis à jour avec succès';

  @override
  String get productAddedShort => 'Produit ajouté avec succès';

  @override
  String get productUpdatedShort => 'Produit mis à jour avec succès';

  @override
  String brandLabel(Object brand) {
    return 'Marque : $brand';
  }

  @override
  String modelLabel(Object model) {
    return 'Modèle : $model';
  }

  @override
  String priceLabel(Object price) {
    return 'Prix : $price';
  }

  @override
  String stockLabel(Object quantity) {
    return 'Stock : $quantity';
  }

  @override
  String stockCount(Object count) {
    return '$count restant(s)';
  }

  @override
  String profitLabel(Object amount) {
    return 'Bénéfice : $amount';
  }

  @override
  String get qtyLabel => 'Qté :';

  @override
  String get barcodeLabel => 'Code-barres :';

  @override
  String get warranty => 'Garantie';

  @override
  String get warrantyManagement => 'Gestion des garanties';

  @override
  String get addWarranty => 'Ajouter une garantie';

  @override
  String get warrantyDuration => 'Durée de la garantie';

  @override
  String warrantyMonths(Object months) {
    return '$months mois';
  }

  @override
  String warrantyMonthsShort(Object months) {
    return '$months mois';
  }

  @override
  String get warrantyLabel => 'Garantie :';

  @override
  String get pleaseEnterProductName => 'Veuillez saisir le nom du produit.';

  @override
  String get warrantyAdded => 'Garantie ajoutée avec succès.';

  @override
  String get warrantyDetails => 'Détails de la garantie';

  @override
  String get deleteWarranty => 'Supprimer la garantie';

  @override
  String get fileClaim => 'Déposer une réclamation';

  @override
  String get voidWarranty => 'Annuler la garantie';

  @override
  String get claimHistory => 'Historique des réclamations';

  @override
  String costLabel(Object amount) {
    return 'Coût : $amount';
  }

  @override
  String get active => 'Active';

  @override
  String get expired => 'Expirée';

  @override
  String get expiryDate => 'Date d\'expiration';

  @override
  String customerLabel(Object name) {
    return 'Client : $name';
  }

  @override
  String get bundles => 'Lots';

  @override
  String get bundleName => 'Nom du lot';

  @override
  String get createBundle => 'Créer un lot';

  @override
  String get sellBundle => 'Vendre le lot';

  @override
  String get bundleNotFound => 'Lot introuvable.';

  @override
  String get itemsInBundle => 'Articles du lot';

  @override
  String get addItem => 'Ajouter un article';

  @override
  String get includedItems => 'Articles inclus';

  @override
  String get bundlePrice => 'Prix du lot';

  @override
  String get subtotal => 'Sous-total';

  @override
  String get finalPrice => 'Prix final';

  @override
  String get discount => 'Remise';

  @override
  String discountPercent(Object percent) {
    return 'Remise ($percent %)';
  }

  @override
  String insufficientStock(Object product) {
    return 'Stock insuffisant pour $product';
  }

  @override
  String bundleSold(Object name) {
    return 'Lot vendu : $name';
  }

  @override
  String get productBundles => 'Lots de produits';

  @override
  String get payment => 'Paiement';

  @override
  String get paymentConfirmation => 'Confirmation de paiement';

  @override
  String get paymentProof => 'Preuve de paiement';

  @override
  String get paymentMethod => 'Mode de paiement';

  @override
  String get paymentBreakdown => 'Détail du paiement';

  @override
  String get cash => 'Espèces';

  @override
  String get card => 'Carte';

  @override
  String get transfer => 'Virement';

  @override
  String get jazzCash => 'JazzCash';

  @override
  String get easyPaisa => 'EasyPaisa';

  @override
  String get credit => 'Crédit';

  @override
  String get accountNumber => 'Numéro de compte';

  @override
  String get notesOptional => 'Notes (facultatif)';

  @override
  String get cardReferenceNumber => 'Numéro de référence de carte';

  @override
  String get confirmSale => 'Confirmer la vente';

  @override
  String get totalPrice => 'Prix total';

  @override
  String get selectProductFirst => 'Sélectionnez d\'abord un produit.';

  @override
  String onePointDiscount(Object amount) {
    return '1 point = $amount de remise';
  }

  @override
  String get salesScreen => 'Écran des ventes';

  @override
  String get sendReceipt => 'Envoyer le reçu';

  @override
  String get sendViaWhatsApp => 'Envoyer via WhatsApp';

  @override
  String get sendViaEmail => 'Envoyer par e-mail';

  @override
  String get sendViaSms => 'Envoyer par SMS';

  @override
  String get share => 'Partager';

  @override
  String get sendToPhoneNumber => 'Envoyer au numéro de téléphone';

  @override
  String get phoneNumberHint =>
      'Saisissez un numéro de téléphone valide pour l\'envoi du reçu.';

  @override
  String get send => 'Envoyer';

  @override
  String get emailNotAvailable => 'Adresse e-mail non disponible.';

  @override
  String get newSale => 'Nouvelle vente';

  @override
  String get orderDetails => 'Détails de la commande';

  @override
  String get orderNumber => 'Commande n°';

  @override
  String get quantity => 'Quantité';

  @override
  String get total => 'Total';

  @override
  String get customer => 'Client';

  @override
  String get viewDetails => 'Voir les détails';

  @override
  String get walkInCustomer => 'Client de passage';

  @override
  String get manage => 'Gérer';

  @override
  String get customers => 'Clients';

  @override
  String get deleteCustomer => 'Supprimer le client ?';

  @override
  String get searchCustomers => 'Rechercher par nom ou téléphone...';

  @override
  String get noCustomersFound => 'Aucun client trouvé';

  @override
  String get repayCredit => 'Rembourser le crédit';

  @override
  String get repay => 'Rembourser';

  @override
  String get phone => 'Téléphone';

  @override
  String get address => 'Adresse';

  @override
  String get repeatCustomer => 'Client fidèle';

  @override
  String get favoriteProducts => 'Produits favoris';

  @override
  String get noPurchasesYet => 'Aucun achat pour le moment';

  @override
  String get addCustomer => 'Ajouter un client';

  @override
  String get updateCustomer => 'Mettre à jour le client';

  @override
  String pointsEarned(Object points) {
    return '+$points pts';
  }

  @override
  String get reports => 'Rapports';

  @override
  String get noDataToExport => 'Aucune donnée à exporter.';

  @override
  String get recentTransactions => 'Transactions récentes';

  @override
  String get noTransactionsPeriod => 'Aucune transaction pour cette période.';

  @override
  String get bestSellingProducts => 'Produits les plus vendus';

  @override
  String get profitWord => 'bénéfice';

  @override
  String get firebaseBackups => 'Sauvegardes Firebase';

  @override
  String get noBackupsFound => 'Aucune sauvegarde trouvée';

  @override
  String get restoreBackup => 'Restaurer la sauvegarde';

  @override
  String get restoreBackupConfirm =>
      'Cela remplacera les données locales. Continuer ?';

  @override
  String get backupHistory => 'Historique des sauvegardes';

  @override
  String get notificationSettings => 'Paramètres de notification';

  @override
  String get enableNotifications => 'Activer les notifications';

  @override
  String get lowStockWarnings => 'Alertes de stock faible';

  @override
  String get dailySalesReminder => 'Rappel des ventes quotidiennes';

  @override
  String get exportLocalBackup => 'Exporter une sauvegarde locale';

  @override
  String get backupToFirebase => 'Sauvegarder sur Firebase';

  @override
  String get restoreFromFirebase => 'Restaurer depuis Firebase';

  @override
  String get notificationSettingsComingSoon =>
      'Paramètres de notification bientôt disponibles !';

  @override
  String get settings => 'Paramètres';

  @override
  String get appearance => 'Apparence';

  @override
  String get language => 'Langue';

  @override
  String get currency => 'Devise';

  @override
  String get notifications => 'Notifications';

  @override
  String get selectLanguage => 'Sélectionner la langue';

  @override
  String get selectCurrency => 'Sélectionner la devise';

  @override
  String get searchCurrency => 'Rechercher une devise...';

  @override
  String get searchLanguage => 'Rechercher une langue...';

  @override
  String get general => 'Général';

  @override
  String get account => 'Compte';

  @override
  String get theme => 'Thème';

  @override
  String get light => 'Clair';

  @override
  String get dark => 'Sombre';

  @override
  String get systemDefault => 'Par défaut du système';

  @override
  String get about => 'À propos';

  @override
  String get shopTools => 'Outils de la boutique';

  @override
  String get shopToolsSubtitle =>
      'Garantie, lots, rapports et paramètres du compte';

  @override
  String get editProfile => 'Modifier le profil';

  @override
  String get unableToLoadProfile =>
      'Impossible de charger le profil. Veuillez réessayer.';

  @override
  String get accessDenied => 'Accès refusé';

  @override
  String get accessDeniedMessage =>
      'You do not have permission to access this page.\nPlease contact your administrator.';

  @override
  String get goBack => 'Retour';

  @override
  String get cancel => 'Annuler';

  @override
  String get save => 'Enregistrer';

  @override
  String get submit => 'Soumettre';

  @override
  String get delete => 'Supprimer';

  @override
  String get edit => 'Modifier';

  @override
  String get view => 'Voir';

  @override
  String get close => 'Fermer';

  @override
  String get update => 'Mettre à jour';

  @override
  String errorGeneric(Object error) {
    return 'Erreur : $error';
  }

  @override
  String get continueAction => 'Continuer';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get ok => 'OK';

  @override
  String get onboardingTitle => 'Bienvenue sur Mobile Shop';

  @override
  String get onboardingSubtitle =>
      'Choisissez votre langue et votre devise pour personnaliser l\'application.';

  @override
  String get chooseLanguage => 'Choisir la langue';

  @override
  String get chooseCurrency => 'Choisir la devise';

  @override
  String get getStarted => 'Commencer';

  @override
  String get languageNameEnglish => 'Anglais';

  @override
  String get languageNameUrdu => 'Ourdou';

  @override
  String get languageNameArabic => 'Arabe';

  @override
  String get languageNameSpanish => 'Espagnol';

  @override
  String get languageNameFrench => 'Français';

  @override
  String get languageNameGerman => 'Allemand';

  @override
  String get languageNameChinese => 'Chinois';

  @override
  String get languageNameTurkish => 'Turc';
}

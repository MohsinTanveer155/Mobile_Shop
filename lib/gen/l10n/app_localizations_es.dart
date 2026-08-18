// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Mobile Shop';

  @override
  String get appSubtitle => 'TPV profesional y gestión de personal';

  @override
  String get appFullTitle => 'Mobile Shop POS';

  @override
  String get versionLabel => 'Versión 1.0.0';

  @override
  String get welcomeBack => 'Bienvenido de nuevo';

  @override
  String get signInSubtitle =>
      'Inicia sesión para continuar en tu cuenta de Mobile Shop';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get confirmPassword => 'Confirmar contraseña';

  @override
  String get rememberMe => 'Recordarme';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get dontHaveAccount => '¿No tienes una cuenta?';

  @override
  String get alreadyHaveAccount => '¿Ya tienes una cuenta?';

  @override
  String get register => 'Registrarse';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get accountCreated => 'Cuenta creada correctamente.';

  @override
  String get unableToSignIn => 'No se pudo iniciar sesión. Inténtalo de nuevo.';

  @override
  String get unableToCreateAccount =>
      'No se pudo crear la cuenta. Inténtalo de nuevo.';

  @override
  String get resetPassword => 'Restablecer contraseña';

  @override
  String get resetPasswordInstructions =>
      'Enter your email address and we\'ll send you a link to reset your password.';

  @override
  String get sendResetLink => 'Enviar enlace de restablecimiento';

  @override
  String get resetLinkSent =>
      'Enlace de restablecimiento de contraseña enviado a tu correo.';

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
  String get logoutConfirm => '¿Seguro que quieres cerrar sesión?';

  @override
  String get dashboard => 'Panel';

  @override
  String get home => 'Inicio';

  @override
  String get products => 'Productos';

  @override
  String get orders => 'Pedidos';

  @override
  String get staff => 'Personal';

  @override
  String get more => 'Más';

  @override
  String get attendance => 'Asistencia';

  @override
  String get leave => 'Permiso';

  @override
  String get salary => 'Salario';

  @override
  String get profile => 'Perfil';

  @override
  String get sales => 'Ventas';

  @override
  String get welcome => 'Bienvenido';

  @override
  String get quickActions => 'Acciones rápidas';

  @override
  String get goodMorning => 'Buenos días';

  @override
  String get goodAfternoon => 'Buenas tardes';

  @override
  String get goodEvening => 'Buenas noches';

  @override
  String get viewAll => 'Ver todo';

  @override
  String get startNewSale => 'Iniciar nueva venta';

  @override
  String get leaveRequests => 'Solicitudes de permiso';

  @override
  String get salaryRequests => 'Solicitudes de salario';

  @override
  String get noRecentOrders => 'Aún no hay pedidos recientes.';

  @override
  String get allProductsStocked =>
      'Todos los productos tienen stock suficiente.';

  @override
  String get loadingDashboard => 'Cargando panel...';

  @override
  String get periodDaily => 'D';

  @override
  String get periodWeekly => 'S';

  @override
  String get periodMonthly => 'M';

  @override
  String get periodDailyFull => 'Diario';

  @override
  String get periodWeeklyFull => 'Semanal';

  @override
  String get periodMonthlyFull => 'Mensual';

  @override
  String get periodYearly => 'Anual';

  @override
  String get manageStaff => 'Gestionar personal';

  @override
  String get employee => 'Empleado';

  @override
  String get administrator => 'Administrador';

  @override
  String get admin => 'Admin';

  @override
  String get user => 'Usuario';

  @override
  String get addStaff => 'Añadir personal';

  @override
  String get monthlySalary => 'Salario mensual';

  @override
  String get useSignupForStaff =>
      'Usa la pantalla de registro para nuevo personal';

  @override
  String get editProfileComingSoon => 'Edición de perfil próximamente';

  @override
  String updateStaffSalary(Object name) {
    return 'Actualizar salario de $name';
  }

  @override
  String get hrDashboard => 'Panel de RR. HH.';

  @override
  String get executiveHrOverview => 'Resumen ejecutivo de RR. HH.';

  @override
  String get staffProfile => 'Perfil del empleado';

  @override
  String get checkIn => 'Entrada';

  @override
  String get checkOut => 'Salida';

  @override
  String get checkInNow => 'Registrar entrada ahora';

  @override
  String get present => 'Presente';

  @override
  String get absent => 'Ausente';

  @override
  String get workingHours => 'Horas de trabajo';

  @override
  String get attendanceHistory => 'Historial de asistencia';

  @override
  String get todayAttendance => 'Asistencia de hoy';

  @override
  String get notCheckedIn => 'Sin registrar entrada';

  @override
  String inAt(Object time) {
    return 'Entrada a las $time';
  }

  @override
  String workedDuration(Object duration) {
    return '$duration trabajados';
  }

  @override
  String get ongoing => 'En curso';

  @override
  String get applyLeave => 'Solicitar permiso';

  @override
  String get leaveType => 'Tipo de permiso';

  @override
  String get startDate => 'Fecha de inicio';

  @override
  String get endDate => 'Fecha de fin';

  @override
  String get reason => 'Motivo';

  @override
  String get pending => 'Pendiente';

  @override
  String get approved => 'Aprobado';

  @override
  String get rejected => 'Rechazado';

  @override
  String get unableSubmitLeave =>
      'No se pudo enviar el permiso: no hay usuario autenticado.';

  @override
  String get leaveSubmitted => 'Solicitud de permiso enviada.';

  @override
  String leaveDays(Object count) {
    return '$count día(s)';
  }

  @override
  String get manageLeaveRequests => 'Gestionar solicitudes de permiso';

  @override
  String get noPendingLeaveRequests =>
      'No hay solicitudes de permiso pendientes.';

  @override
  String periodRange(Object start, Object end) {
    return 'Período: $start - $end';
  }

  @override
  String get approveLeave => 'Aprobar permiso';

  @override
  String get rejectLeave => 'Rechazar permiso';

  @override
  String leaveStatusSuccess(Object status) {
    return 'Permiso $status correctamente.';
  }

  @override
  String get pleaseSignInToViewSalary =>
      'Inicia sesión para ver los detalles del salario.';

  @override
  String get salaryOverview => 'Resumen de salario';

  @override
  String get generatePayroll => 'Generar nómina';

  @override
  String get manageSalaryRequests => 'Gestionar solicitudes de salario';

  @override
  String get requestSalary => 'Solicitar salario';

  @override
  String get salaryHistory => 'Historial de salarios';

  @override
  String get noSalaryRecords => 'No hay registros de salario';

  @override
  String get noSalaryRecordsSubtitle =>
      'Los salarios generados o pagados aparecerán aquí.';

  @override
  String get unableToLoadSalaryHistory =>
      'No se pudo cargar el historial de salarios. Inténtalo de nuevo.';

  @override
  String get basicSalary => 'Salario base';

  @override
  String get presentDays => 'Días presentes';

  @override
  String get estimatedPay => 'Pago estimado';

  @override
  String get deductions => 'Deducciones';

  @override
  String get unableToLoadSalaryPreview =>
      'No se pudo cargar la vista previa del salario. Inténtalo de nuevo.';

  @override
  String get payrollGenerated => '¡Nómina generada!';

  @override
  String monthYearSalary(Object monthYear) {
    return 'Salario de $monthYear';
  }

  @override
  String get netPay => 'Pago neto';

  @override
  String get attendancePercentage => 'Asistencia %';

  @override
  String get baseSalary => 'Salario base';

  @override
  String get noPendingSalaryRequests =>
      'No hay solicitudes de salario pendientes.';

  @override
  String get amount => 'Importe';

  @override
  String get reject => 'Rechazar';

  @override
  String get approve => 'Aprobar';

  @override
  String get approveRequest => 'Aprobar solicitud';

  @override
  String get rejectRequest => 'Rechazar solicitud';

  @override
  String get adminRemark => 'Comentario del administrador';

  @override
  String requestStatusSuccessfully(Object status) {
    return 'Solicitud $status correctamente.';
  }

  @override
  String get newSalaryRequest => 'Nueva solicitud de salario';

  @override
  String get sendRequest => 'Enviar solicitud';

  @override
  String get requestHistory => 'Historial de solicitudes';

  @override
  String get noSalaryRequestsYet => 'Aún no hay solicitudes de salario.';

  @override
  String get salaryRequestSubmitted =>
      'Solicitud de salario enviada correctamente.';

  @override
  String salaryRequestFailed(Object error) {
    return 'Solicitud fallida: $error';
  }

  @override
  String get pleaseSignInSalaryRequests =>
      'Inicia sesión para ver las solicitudes de salario.';

  @override
  String requestedDate(Object date) {
    return 'Solicitado: $date';
  }

  @override
  String adminNote(Object note) {
    return 'Nota del administrador: $note';
  }

  @override
  String get addProduct => 'Añadir producto';

  @override
  String get editProduct => 'Editar producto';

  @override
  String get deleteProduct => 'Eliminar producto';

  @override
  String deleteProductConfirm(Object name) {
    return '¿Seguro que quieres eliminar \"$name\"?';
  }

  @override
  String productDeleted(Object name) {
    return '$name eliminado correctamente';
  }

  @override
  String get productName => 'Nombre del producto';

  @override
  String get brand => 'Marca';

  @override
  String get model => 'Modelo';

  @override
  String get price => 'Precio';

  @override
  String get stock => 'Stock';

  @override
  String get available => 'Disponible';

  @override
  String get outOfStock => 'Agotado';

  @override
  String get saveProduct => 'Guardar producto';

  @override
  String get productAdded => 'Producto añadido correctamente.';

  @override
  String get productUpdated => 'Producto actualizado correctamente';

  @override
  String get productAddedShort => 'Producto añadido correctamente';

  @override
  String get productUpdatedShort => 'Producto actualizado correctamente';

  @override
  String brandLabel(Object brand) {
    return 'Marca: $brand';
  }

  @override
  String modelLabel(Object model) {
    return 'Modelo: $model';
  }

  @override
  String priceLabel(Object price) {
    return 'Precio: $price';
  }

  @override
  String stockLabel(Object quantity) {
    return 'Stock: $quantity';
  }

  @override
  String stockCount(Object count) {
    return 'Quedan $count';
  }

  @override
  String profitLabel(Object amount) {
    return 'Beneficio: $amount';
  }

  @override
  String get qtyLabel => 'Cant.:';

  @override
  String get barcodeLabel => 'Código de barras:';

  @override
  String get warranty => 'Garantía';

  @override
  String get warrantyManagement => 'Gestión de garantías';

  @override
  String get addWarranty => 'Añadir garantía';

  @override
  String get warrantyDuration => 'Duración de la garantía';

  @override
  String warrantyMonths(Object months) {
    return '$months meses';
  }

  @override
  String warrantyMonthsShort(Object months) {
    return '$months mes';
  }

  @override
  String get warrantyLabel => 'Garantía:';

  @override
  String get pleaseEnterProductName => 'Introduce el nombre del producto.';

  @override
  String get warrantyAdded => 'Garantía añadida correctamente.';

  @override
  String get warrantyDetails => 'Detalles de la garantía';

  @override
  String get deleteWarranty => 'Eliminar garantía';

  @override
  String get fileClaim => 'Presentar reclamación';

  @override
  String get voidWarranty => 'Anular garantía';

  @override
  String get claimHistory => 'Historial de reclamaciones';

  @override
  String costLabel(Object amount) {
    return 'Coste: $amount';
  }

  @override
  String get active => 'Activa';

  @override
  String get expired => 'Caducada';

  @override
  String get expiryDate => 'Fecha de caducidad';

  @override
  String customerLabel(Object name) {
    return 'Cliente: $name';
  }

  @override
  String get bundles => 'Paquetes';

  @override
  String get bundleName => 'Nombre del paquete';

  @override
  String get createBundle => 'Crear paquete';

  @override
  String get sellBundle => 'Vender paquete';

  @override
  String get bundleNotFound => 'Paquete no encontrado.';

  @override
  String get itemsInBundle => 'Artículos del paquete';

  @override
  String get addItem => 'Añadir artículo';

  @override
  String get includedItems => 'Artículos incluidos';

  @override
  String get bundlePrice => 'Precio del paquete';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get finalPrice => 'Precio final';

  @override
  String get discount => 'Descuento';

  @override
  String discountPercent(Object percent) {
    return 'Descuento ($percent%)';
  }

  @override
  String insufficientStock(Object product) {
    return 'Stock insuficiente para $product';
  }

  @override
  String bundleSold(Object name) {
    return 'Paquete vendido: $name';
  }

  @override
  String get productBundles => 'Paquetes de productos';

  @override
  String get payment => 'Pago';

  @override
  String get paymentConfirmation => 'Confirmación de pago';

  @override
  String get paymentProof => 'Comprobante de pago';

  @override
  String get paymentMethod => 'Método de pago';

  @override
  String get paymentBreakdown => 'Desglose del pago';

  @override
  String get cash => 'Efectivo';

  @override
  String get card => 'Tarjeta';

  @override
  String get transfer => 'Transferencia';

  @override
  String get jazzCash => 'JazzCash';

  @override
  String get easyPaisa => 'EasyPaisa';

  @override
  String get credit => 'Crédito';

  @override
  String get accountNumber => 'Número de cuenta';

  @override
  String get notesOptional => 'Notas (opcional)';

  @override
  String get cardReferenceNumber => 'Número de referencia de tarjeta';

  @override
  String get confirmSale => 'Confirmar venta';

  @override
  String get totalPrice => 'Precio total';

  @override
  String get selectProductFirst => 'Selecciona un producto primero.';

  @override
  String onePointDiscount(Object amount) {
    return '1 punto = $amount de descuento';
  }

  @override
  String get salesScreen => 'Pantalla de ventas';

  @override
  String get sendReceipt => 'Enviar recibo';

  @override
  String get sendViaWhatsApp => 'Enviar por WhatsApp';

  @override
  String get sendViaEmail => 'Enviar por correo electrónico';

  @override
  String get sendViaSms => 'Enviar por SMS';

  @override
  String get share => 'Compartir';

  @override
  String get sendToPhoneNumber => 'Enviar al número de teléfono';

  @override
  String get phoneNumberHint =>
      'Introduce un número de teléfono válido para enviar el recibo.';

  @override
  String get send => 'Enviar';

  @override
  String get emailNotAvailable => 'Dirección de correo no disponible.';

  @override
  String get newSale => 'Nueva venta';

  @override
  String get orderDetails => 'Detalles del pedido';

  @override
  String get orderNumber => 'Pedido #';

  @override
  String get quantity => 'Cantidad';

  @override
  String get total => 'Total';

  @override
  String get customer => 'Cliente';

  @override
  String get viewDetails => 'Ver detalles';

  @override
  String get walkInCustomer => 'Cliente sin cita';

  @override
  String get manage => 'Gestionar';

  @override
  String get customers => 'Clientes';

  @override
  String get deleteCustomer => '¿Eliminar cliente?';

  @override
  String get searchCustomers => 'Buscar por nombre o teléfono...';

  @override
  String get noCustomersFound => 'No se encontraron clientes';

  @override
  String get repayCredit => 'Pagar crédito';

  @override
  String get repay => 'Pagar';

  @override
  String get phone => 'Teléfono';

  @override
  String get address => 'Dirección';

  @override
  String get repeatCustomer => 'Cliente recurrente';

  @override
  String get favoriteProducts => 'Productos favoritos';

  @override
  String get noPurchasesYet => 'Aún no hay compras';

  @override
  String get addCustomer => 'Añadir cliente';

  @override
  String get updateCustomer => 'Actualizar cliente';

  @override
  String pointsEarned(Object points) {
    return '+$points pts';
  }

  @override
  String get reports => 'Informes';

  @override
  String get noDataToExport => 'No hay datos para exportar.';

  @override
  String get recentTransactions => 'Transacciones recientes';

  @override
  String get noTransactionsPeriod => 'No hay transacciones en este período.';

  @override
  String get bestSellingProducts => 'Productos más vendidos';

  @override
  String get profitWord => 'beneficio';

  @override
  String get firebaseBackups => 'Copias de seguridad de Firebase';

  @override
  String get noBackupsFound => 'No se encontraron copias de seguridad';

  @override
  String get restoreBackup => 'Restaurar copia de seguridad';

  @override
  String get restoreBackupConfirm =>
      'Esto reemplazará los datos locales. ¿Continuar?';

  @override
  String get backupHistory => 'Historial de copias de seguridad';

  @override
  String get notificationSettings => 'Configuración de notificaciones';

  @override
  String get enableNotifications => 'Activar notificaciones';

  @override
  String get lowStockWarnings => 'Avisos de stock bajo';

  @override
  String get dailySalesReminder => 'Recordatorio de ventas diarias';

  @override
  String get exportLocalBackup => 'Exportar copia local';

  @override
  String get backupToFirebase => 'Copia de seguridad en Firebase';

  @override
  String get restoreFromFirebase => 'Restaurar desde Firebase';

  @override
  String get notificationSettingsComingSoon =>
      '¡Configuración de notificaciones próximamente!';

  @override
  String get settings => 'Configuración';

  @override
  String get appearance => 'Apariencia';

  @override
  String get language => 'Idioma';

  @override
  String get currency => 'Moneda';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get selectLanguage => 'Seleccionar idioma';

  @override
  String get selectCurrency => 'Seleccionar moneda';

  @override
  String get searchCurrency => 'Buscar moneda...';

  @override
  String get searchLanguage => 'Buscar idioma...';

  @override
  String get general => 'General';

  @override
  String get account => 'Cuenta';

  @override
  String get theme => 'Tema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get systemDefault => 'Predeterminado del sistema';

  @override
  String get about => 'Acerca de';

  @override
  String get shopTools => 'Herramientas de la tienda';

  @override
  String get shopToolsSubtitle =>
      'Garantía, paquetes, informes y configuración de cuenta';

  @override
  String get editProfile => 'Editar perfil';

  @override
  String get unableToLoadProfile =>
      'No se pudo cargar el perfil. Inténtalo de nuevo.';

  @override
  String get accessDenied => 'Acceso denegado';

  @override
  String get accessDeniedMessage =>
      'You do not have permission to access this page.\nPlease contact your administrator.';

  @override
  String get goBack => 'Volver';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get submit => 'Enviar';

  @override
  String get delete => 'Eliminar';

  @override
  String get edit => 'Editar';

  @override
  String get view => 'Ver';

  @override
  String get close => 'Cerrar';

  @override
  String get update => 'Actualizar';

  @override
  String errorGeneric(Object error) {
    return 'Error: $error';
  }

  @override
  String get continueAction => 'Continuar';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get ok => 'Aceptar';

  @override
  String get onboardingTitle => 'Bienvenido a Mobile Shop';

  @override
  String get onboardingSubtitle =>
      'Elige tu idioma y moneda para personalizar la aplicación.';

  @override
  String get chooseLanguage => 'Elegir idioma';

  @override
  String get chooseCurrency => 'Elegir moneda';

  @override
  String get getStarted => 'Comenzar';

  @override
  String get languageNameEnglish => 'Inglés';

  @override
  String get languageNameUrdu => 'Urdu';

  @override
  String get languageNameArabic => 'Árabe';

  @override
  String get languageNameSpanish => 'Español';

  @override
  String get languageNameFrench => 'Francés';

  @override
  String get languageNameGerman => 'Alemán';

  @override
  String get languageNameChinese => 'Chino';

  @override
  String get languageNameTurkish => 'Turco';
}

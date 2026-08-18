import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/customer.dart';
import '../services/customer_service.dart';
import 'app_providers.dart';

/// Provider for customer service (from PosService)
final customerServiceProvider = Provider<CustomerService>((ref) {
  return ref.watch(posServiceProvider).when(
    loading: () => CustomerService(),
    error: (_, __) => CustomerService(),
    data: (service) => service.customerService,
  );
});

/// State class for customer management
class CustomerListState {
  final List<Customer> customers;
  final String searchQuery;

  const CustomerListState({
    this.customers = const [],
    this.searchQuery = '',
  });

  List<Customer> get filteredCustomers {
    if (searchQuery.isEmpty) return customers;
    final lower = searchQuery.toLowerCase();
    return customers.where((c) {
      return c.name.toLowerCase().contains(lower) ||
          c.phone.contains(lower);
    }).toList();
  }

  CustomerListState copyWith({
    List<Customer>? customers,
    String? searchQuery,
  }) {
    return CustomerListState(
      customers: customers ?? this.customers,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

/// State notifier for customer list
class CustomerListNotifier extends StateNotifier<CustomerListState> {
  final CustomerService _service;

  CustomerListNotifier(this._service) : super(const CustomerListState());

  void loadCustomers() {
    state = state.copyWith(customers: _service.customers);
  }

  void search(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void addCustomer({
    required String name,
    required String phone,
    String? email,
    String? address,
  }) {
    _service.addCustomer(name: name, phone: phone, email: email, address: address);
    loadCustomers();
  }

  void updateCustomer(Customer updated) {
    _service.updateCustomer(updated);
    loadCustomers();
  }

  void deleteCustomer(String id) {
    _service.deleteCustomer(id);
    loadCustomers();
  }
}

/// Provider for customer list state
final customerListProvider = StateNotifierProvider<CustomerListNotifier, CustomerListState>((ref) {
  final service = ref.watch(customerServiceProvider);
  return CustomerListNotifier(service);
});


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yummy/models/cart_manager.dart';
import 'package:yummy/models/order_manager.dart';

class CheckoutPage extends StatefulWidget {
  final CartManager cartManager;
  final Function() didUpdate;
  final Function(Order) onSubmit;

  const CheckoutPage({
    super.key,
    required this.cartManager,
    required this.didUpdate,
    required this.onSubmit,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // TODO: Add State Properties
  final Map<int, Widget> myTab = const <int, Widget>{
    0: Text('Delivery'),
    2: Text('Self pick-up'),
  };
  Set<int> selectedSegment = {0};
  TimeOfDay? selectedTime;
  DateTime? selectedDate;
  final DateTime _firstDate = DateTime(DateTime.now().year - 2);
  final DateTime _lastDate = DateTime(DateTime.now().year + 1);
  final TextEditingController _nameController = TextEditingController();

  // TODO: Configure Date Format
  String formatDate(DateTime? dateTime) {
    if (dateTime == null) {
      return 'Select Date';
    }
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }

  // TODO: Configure Time of Day
  String formatTime(TimeOfDay? timeOfDay) {
    if (timeOfDay == null) {
      return 'Select Time';
    }
    final hour = timeOfDay.hour.toString().padLeft(2, '0');
    final minutes = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hour:$minutes';
  }

  // TODO: Set Selected Segment
  void onSegmentSelected(Set<int> segmentIndex) {
    setState(() {
      selectedSegment = segmentIndex;
    });
  }

  // TODO: Build Segmented Control
  Widget _buildOrderSegmentedType() {
    return SegmentedButton(
      showSelectedIcon: false,
      segments: const [
        ButtonSegment(
          value: 0,
          label: Text('Delivery'),
          icon: Icon(Icons.pedal_bike),
        ),
        ButtonSegment(
          value: 1,
          label: Text('Self-Pickup'),
          icon: Icon(Icons.local_mall),
        )
      ],
      selected: selectedSegment,
      onSelectionChanged: onSegmentSelected,
    );
  }

  // TODO: Build Name Textfield
  Widget _buildTextField() {
    return TextField(
      controller: _nameController,
      decoration: const InputDecoration(
        labelText: 'Contact Name',
        hintText: 'Your Name',
      ),
    );
  }

  // TODO: Select Date Picker
  void _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: _firstDate,
      lastDate: _lastDate,
      initialDate: selectedDate ?? DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // TODO: Select Time Picker
  void _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
        context: context,
        initialEntryMode: TimePickerEntryMode.input,
        initialTime: selectedTime ?? TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  // TODO: Build Order Summary
  Widget _buildOrderSummary(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return Expanded(
      child: ListView.builder(
        itemCount: widget.cartManager.items.length,
        itemBuilder: (context, index) {
          final item = widget.cartManager.itemAt(index);
          return Dismissible(
            key: Key(item.id),
            direction: DismissDirection.endToStart,
            background: Container(),
            secondaryBackground: const SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.delete),
                ],
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                widget.cartManager.removeItem(item.id);
              });
              widget.didUpdate();
            },
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  border: Border.all(
                    color: colorTheme.primary,
                    width: 2.0,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  child: Text('x${item.quantity}'),
                ),
              ),
              title: Text(item.name),
              subtitle: Text('Price: \$${item.price}'),
            ),
          );
        },
      ),
    );
  }

  // TODO: Build Submit Order Button
  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: widget.cartManager.isEmpty
          ? null
          : () {
              final selectedSegment = this.selectedSegment;
              final selectedDate = this.selectedDate;
              final selectedTime = this.selectedTime;
              final name = _nameController.text;
              final items = widget.cartManager.items;

              final order = Order(
                selectedSegment: selectedSegment,
                selectedTime: selectedTime,
                selectedDate: selectedDate,
                name: name,
                items: items,
              );
              widget.cartManager.resetCart();
              widget.onSubmit(order);
            },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          '''Submit Order - \$${widget.cartManager.totalCost.toStringAsFixed(2)}''',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Order Details',
              style: textTheme.headlineSmall,
            ),
            // TODO: Add Segmented Control
            const SizedBox(
              height: 16,
            ),
            _buildOrderSegmentedType(),
            // TODO: Add Name Textfield
            const SizedBox(
              height: 16,
            ),
            _buildTextField(),
            // TODO: Add Date and Time Picker
            const SizedBox(height: 16.0),
            Row(
              children: [
                TextButton(
                  child: Text(formatDate(selectedDate)),
                  onPressed: () => _selectDate(context),
                ),
                TextButton(
                  child: Text(formatTime(selectedTime)),
                  onPressed: () => _selectTime(context),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // TODO: Add Order Summary
            const Text('Order Summary'),
            _buildOrderSummary(context),
            // TODO: Add Submit Order Button
            _buildSubmitButton()
          ],
        ),
      ),
    );
  }
}

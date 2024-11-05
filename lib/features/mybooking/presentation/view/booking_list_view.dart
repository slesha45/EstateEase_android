import 'package:final_assignment/core/common/provider/theme_view_model_provider.dart';
import 'package:final_assignment/features/mybooking/presentation/viewmodel/booking_list_view_model.dart';
import 'package:final_assignment/features/mybooking/presentation/widgets/dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class BookingListView extends ConsumerWidget {
  const BookingListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bookingListViewModelProvider);
    final isDark =
        ref.watch(themeViewModelProvider); // Watch the theme provider

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Booking List'),
        backgroundColor:
            isDark ? Colors.grey : Colors.brown, // AppBar color based on theme
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text('Error: ${state.error}'))
              : state.bookings.isEmpty
                  ? const Center(child: Text('No bookings available'))
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        final columnWidth = constraints.maxWidth / 4;

                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              border: TableBorder.all(
                                color: isDark
                                    ? Colors.white.withOpacity(0.3)
                                    : Colors.grey.withOpacity(
                                        0.3), // Border color based on theme
                                width: 1.0,
                              ),
                              columnSpacing: 0.0,
                              headingRowHeight: 60,
                              dataRowHeight: 56,
                              // Heading color based on theme
                              columns: [
                                DataColumn(
                                  label: SizedBox(
                                    width: columnWidth,
                                    child: const Text(
                                      'Property',
                                      style: TextStyle(
                                        color: Colors.brown,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: SizedBox(
                                    width: columnWidth,
                                    child: const Text(
                                      'Time',
                                      style: TextStyle(
                                        color: Colors.brown,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: SizedBox(
                                    width: columnWidth,
                                    child: const Text(
                                      'Date',
                                      style: TextStyle(
                                        color: Colors.brown,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: SizedBox(
                                    width: columnWidth - 10,
                                    child: const Text(
                                      'Action',
                                      style: TextStyle(
                                        color: Colors.brown,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              rows: List.generate(
                                state.bookings.length,
                                (index) {
                                  final booking = state.bookings[index];
                                  final formattedDate = DateFormat('yyyy-MM-dd')
                                      .format(booking.date);
                                  final color = index.isEven
                                      ? (isDark
                                          ? Colors.brown[800]
                                          : Colors.brown[50])
                                      : (isDark
                                          ? Colors.brown[900]
                                          : Colors
                                              .white); // Row color based on theme

                                  return DataRow(
                                    color: WidgetStateProperty.all(color),
                                    cells: [
                                      DataCell(SizedBox(
                                        width: columnWidth,
                                        child: const Text(
                                          'House on sale', // Replace with actual property name if needed
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )),
                                      DataCell(SizedBox(
                                        width: columnWidth,
                                        child: Text(
                                          booking.time,
                                          style: TextStyle(
                                            color: isDark
                                                ? Colors.white70
                                                : Colors.brown[
                                                    700], // Text color based on theme
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )),
                                      DataCell(SizedBox(
                                        width: columnWidth,
                                        child: Text(
                                          formattedDate,
                                          style: TextStyle(
                                            color: isDark
                                                ? Colors.white70
                                                : Colors.brown[
                                                    700], // Text color based on theme
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )),
                                      DataCell(SizedBox(
                                        width: columnWidth - 10,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // Show the Khalti Payment Dialog
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    const KhaltiPaymentDialog(),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.brown,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 15,
                                                vertical: 12,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              textStyle: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                            child: const Text('Pay'),
                                          ),
                                        ),
                                      )),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}

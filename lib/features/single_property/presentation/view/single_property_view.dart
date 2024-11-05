import 'package:final_assignment/features/mybooking/presentation/viewmodel/booking_list_view_model.dart';
import 'package:final_assignment/features/single_property/presentation/viewmodel/single_property_view_model.dart';
import 'package:final_assignment/features/single_property/presentation/widgets/my_single_property.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
class SinglePropertyView extends ConsumerStatefulWidget {
  final String propertyId;
 
  const SinglePropertyView({required this.propertyId, super.key});
 
  @override
  _SinglePropertyViewState createState() => _SinglePropertyViewState();
}
 
class _SinglePropertyViewState extends ConsumerState<SinglePropertyView> {
  @override
  void initState() {
    super.initState();
    _fetchPropertyDetails();
  }
 
  void _fetchPropertyDetails() {
    Future.microtask(() {
      ref
          .read(singlePropertyViewModelProvider.notifier)
          .getSingleProperty(widget.propertyId);
    });
  }
 
  @override
  Widget build(BuildContext context) {
    final propertyState = ref.watch(singlePropertyViewModelProvider);
 
    return Scaffold(
      body: propertyState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : propertyState.error != null
              ? Center(child: Text(propertyState.error!))
              : propertyState.singleProperty != null
                  ? SingleView(
                      singleProperty: propertyState.singleProperty!,
                      selectedQuantity: propertyState.selectedQuantity,
                      onAddToBag: () {
                        ref.read(bookingListViewModelProvider.notifier).getbookings(
                            propertyState.singleProperty!.id!,
                            propertyState.selectedQuantity,
                            propertyState.singleProperty!.propertyPrice);
                      },
                      onIncreaseQuantity: () {
                        ref
                            .read(singlePropertyViewModelProvider.notifier)
                            .updateSelectedQuantity(
                                propertyState.selectedQuantity + 1);
                      },
                      onDecreaseQuantity: () {
                        ref
                            .read(singlePropertyViewModelProvider.notifier)
                            .updateSelectedQuantity(
                                propertyState.selectedQuantity - 1);
                      },
                    )
                  : const Center(child: Text('Property not found')),
    );
  }
}

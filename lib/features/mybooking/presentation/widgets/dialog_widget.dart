import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
 
class KhaltiPaymentDialog extends StatefulWidget {
  const KhaltiPaymentDialog({Key? key}) : super(key: key);
 
  @override
  State<KhaltiPaymentDialog> createState() => _KhaltiPaymentDialogState();
}
 
class _KhaltiPaymentDialogState extends State<KhaltiPaymentDialog> {
  String referenceId = "";
 
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Payment Options"),
      content: SizedBox(
        width: 300, // Set width for the dialog
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    payWithKhaltiInApp();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Khalti"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Show booking successful dialog for cash on arrival
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Booking Successful"),
                          content: const Text(
                              "Your booking has been confirmed with Cash on Arrival."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close dialog
                                Navigator.pop(context); // Close previous dialog
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.brown[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Cash on Arrival"),
                ),
              ],
            ),
            if (referenceId.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  "Reference Id: $referenceId",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
 
  payWithKhaltiInApp() {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
        amount: 1000, // in paisa
        productIdentity: 'Booking',
        productName: 'Benelli TNT 600i',
        mobileReadOnly: false,
      ),
      preferences: [
        PaymentPreference.khalti,
      ],
      onSuccess: onSuccess,
      onFailure: onFailure,
      onCancel: onCancel,
    );
  }
 
  void onSuccess(PaymentSuccessModel success) {
    setState(() {
      referenceId = success.idx;
    });
  }
 
  void onFailure(PaymentFailureModel failure) {
    debugPrint(failure.toString());
  }
 
  void onCancel() {
    debugPrint('Cancelled');
  }
}

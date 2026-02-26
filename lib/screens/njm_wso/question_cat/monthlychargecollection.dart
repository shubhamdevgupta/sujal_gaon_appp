import 'package:flutter/material.dart';

class MonthlyChargeCollectionForm extends StatefulWidget {
  const MonthlyChargeCollectionForm({super.key});

  @override
  State<MonthlyChargeCollectionForm> createState() =>
      _MonthlyChargeCollectionFormState();
}

class _MonthlyChargeCollectionFormState
    extends State<MonthlyChargeCollectionForm> {

  String currentMonth =
      "${DateTime.now().month}/${DateTime.now().year}";

  int totalConnections = 120; // Auto fetched from IMIS
  String? chargesSetup;

  List<Map<String, dynamic>> households = [];

  final receiptFromController = TextEditingController();
  final receiptToController = TextEditingController();

  final depositAmountController = TextEditingController();
  DateTime? depositDate;

  final issueController = TextEditingController();

  // ================= CALCULATIONS =================

  int get totalBilledCount => households.length;

  double get totalBilledAmount =>
      households.fold(0,
              (sum, item) => sum + (item['billed'] ?? 0));

  double get totalCollectedAmount =>
      households.fold(0,
              (sum, item) => sum + (item['paid'] ?? 0));

  int get fullPaid =>
      households.where((e) =>
      e['paid'] == e['billed'] && e['paid'] > 0).length;

  int get partialPaid =>
      households.where((e) =>
      e['paid'] > 0 &&
          e['paid'] < e['billed']).length;

  int get notPaid =>
      households.where((e) => e['paid'] == 0).length;

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Monthly Charge Collection",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/icons/SJL_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [
              const SizedBox(height: 10),
              // ================= BASIC =================
              _sectionCard(
                icon: Icons.calendar_month,
                title: "Monthly Overview",
                children: [

                  _readOnly("Month", currentMonth),

                  _readOnly(
                      "Total Household Connections",
                      totalConnections.toString()),

                  _radioGroup(
                    "Monthly Charges Setup by VWSC?",
                    value: chargesSetup,
                    onChanged: (v) {
                      setState(() {
                        chargesSetup = v;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ================= HOUSEHOLD ENTRY =================
              if (chargesSetup == "Yes")
                _sectionCard(
                  icon: Icons.home,
                  title: "Household Entries",
                  children: [

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF1E88E5),
                            Color(0xFF0D47A1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: _addHouseholdDialog,
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Add New Household",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    if (households.isNotEmpty)
                      _householdTable(),
                  ],
                ),

              const SizedBox(height: 20),

              // ================= SUMMARY =================
              if (chargesSetup == "Yes")
                _sectionCard(
                  icon: Icons.summarize,
                  title: "Auto Summary",
                  children: [

                    _summaryCard(),

                  ],
                ),

              const SizedBox(height: 20),

              // ================= RECEIPT =================
              _sectionCard(
                icon: Icons.receipt,
                title: "Receipt Details",
                children: [

                  _input(
                    "Receipt From No.",
                    controller: receiptFromController,
                    keyboard: TextInputType.number,
                  ),

                  _input(
                    "Receipt To No.",
                    controller: receiptToController,
                    keyboard: TextInputType.number,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ================= DEPOSIT =================
              _sectionCard(
                icon: Icons.account_balance,
                title: "Bank Deposit Details",
                children: [

                  _input(
                    "Deposit Amount (₹)",
                    controller: depositAmountController,
                    keyboard: TextInputType.number,
                  ),

                  InkWell(
                    onTap: () async {
                      DateTime? picked =
                      await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:
                        DateTime(2000),
                        lastDate:
                        DateTime(2100),
                      );

                      if (picked != null) {
                        setState(() {
                          depositDate = picked;
                        });
                      }
                    },
                    child: _readOnly(
                      "Deposit Date",
                      depositDate == null
                          ? "Select Date"
                          : "${depositDate!.day}/${depositDate!.month}/${depositDate!.year}",
                    ),
                  ),

                  const SizedBox(height: 10),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF1E88E5),
                          Color(0xFF0D47A1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.upload_file,
                          color: Colors.white),
                      label: const Text(
                        "Upload Deposit Slip",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ================= ISSUES =================
              _sectionCard(
                icon: Icons.warning,
                title: "Issues & Actions",
                children: [

                  _input(
                    "Key Issues & Suggested Actions",
                    controller: issueController,
                    maxLines: 4,
                  ),
                ],
              ),

              const SizedBox(height: 30),

              _saveButton(),
            ],
          ),
        ),
      ),
    );
  }

  // ================= HOUSEHOLD DIALOG =================

  Widget _dialogInput(
      String label, {
        required TextEditingController controller,
        TextInputType keyboard = TextInputType.text,
      }) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Color(0xFF1976D2),
          fontWeight: FontWeight.w600,
        ),

        floatingLabelStyle: const TextStyle(
          color: Color(0xFF0D47A1),
          fontWeight: FontWeight.bold,
        ),

        filled: true,
        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        // 🔵 Slightly darker border
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.grey.shade500, // darker than 300
            width: 1.2,
          ),
        ),

        // 🔵 Strong focus border
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFF1976D2),
            width: 1.8,
          ),
        ),
      ),
    );
  }
  void _addHouseholdDialog() {
    final nameController = TextEditingController();
    final addressController = TextEditingController();
    final billedController = TextEditingController();
    final paidController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  // ================= HEADER =================
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF1E88E5),
                          Color(0xFF0D47A1),
                        ],
                      ),
                      borderRadius:
                      BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        "Add Household",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  _dialogInput(
                    "Owner Name",
                    controller: nameController,
                  ),

                  const SizedBox(height: 14),

                  _dialogInput(
                    "Address",
                    controller: addressController,
                  ),

                  const SizedBox(height: 14),

                  _dialogInput(
                    "Billed Amount (₹)",
                    controller: billedController,
                    keyboard:
                    TextInputType.number,
                  ),

                  const SizedBox(height: 14),

                  _dialogInput(
                    "Paid Amount (₹)",
                    controller: paidController,
                    keyboard:
                    TextInputType.number,
                  ),

                  const SizedBox(height: 22),

                  // ================= ACTION BUTTONS =================
                  Row(
                    children: [

                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton
                              .styleFrom(
                            side: const BorderSide(
                                color:
                                Color(0xFF1976D2)),
                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  12),
                            ),
                          ),
                          onPressed: () =>
                              Navigator.pop(
                                  context),
                          child:
                          const Text("Cancel"),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Container(
                          decoration:
                          BoxDecoration(
                            gradient:
                            const LinearGradient(
                              colors: [
                                Color(0xFF1E88E5),
                                Color(0xFF0D47A1),
                              ],
                            ),
                            borderRadius:
                            BorderRadius
                                .circular(12),
                          ),
                          child:
                          ElevatedButton(
                            style:
                            ElevatedButton
                                .styleFrom(
                              backgroundColor:
                              Colors
                                  .transparent,
                              shadowColor:
                              Colors
                                  .transparent,
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    12),
                              ),
                            ),
                            onPressed: () {
                              if (nameController
                                  .text
                                  .isEmpty ||
                                  billedController
                                      .text
                                      .isEmpty) {
                                return;
                              }

                              setState(() {
                                households.add({
                                  "name":
                                  nameController
                                      .text,
                                  "address":
                                  addressController
                                      .text,
                                  "billed":
                                  double.tryParse(
                                      billedController
                                          .text) ??
                                      0,
                                  "paid":
                                  double.tryParse(
                                      paidController
                                          .text) ??
                                      0,
                                });
                              });

                              Navigator.pop(
                                  context);
                            },
                            child: const Text(
                              "Add",
                              style: TextStyle(
                                color:
                                Colors.white,
                                fontWeight:
                                FontWeight
                                    .bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _householdTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20,
        headingRowColor: MaterialStateProperty.all(
          const Color(0xFF1976D2).withOpacity(0.1),
        ),
        columns: const [
          DataColumn(
              label: Text("S.No",
                  style: TextStyle(
                      fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text("Owner",
                  style: TextStyle(
                      fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text("Address",
                  style: TextStyle(
                      fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text("Billed",
                  style: TextStyle(
                      fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text("Paid",
                  style: TextStyle(
                      fontWeight: FontWeight.bold))),
        ],
        rows: List.generate(
          households.length,
              (index) {
            final item = households[index];

            return DataRow(
              cells: [
                DataCell(Text("${index + 1}")),
                DataCell(Text(item['name'] ?? "")),
                DataCell(Text(item['address'] ?? "")),
                DataCell(Text("₹ ${item['billed']}")),
                DataCell(Text("₹ ${item['paid']}")),
              ],
            );
          },
        ),
      ),
    );
  }

  // ================= COMMON UI =================

  Widget _sectionCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.95),
            Colors.blue.shade50.withOpacity(0.9),
          ],
        ),

        borderRadius: BorderRadius.circular(22),

        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.18),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  Icon(icon, color: const Color(0xFF1976D2)),
                  const SizedBox(width: 10),
                  Text(title,
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700)),
                ],
              ),

              const SizedBox(height: 12),

              Divider(
                thickness: 1,
                color: Colors.grey.shade300,
              ),
            ],
          ),
          const SizedBox(height: 18),

          ...children.map((e) =>
              Padding(
                padding:
                const EdgeInsets.only(
                    bottom: 14),
                child: e,
              )),
        ],
      ),
    );
  }

  Widget _input(String hint,
      {TextEditingController? controller,
        TextInputType keyboard = TextInputType.text,
        int maxLines = 1}) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Colors.grey.shade600, // darker border
            width: 1.2,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFF1976D2),
            width: 1.8,
          ),
        ),
      ),
    );
  }
  Widget _readOnly(
      String label, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius:
        BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Text("$label: ",
              style: const TextStyle(
                  fontWeight:
                  FontWeight.w600)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _radioGroup(
      String title,
      {required String? value,
        required Function(String)
        onChanged}) {
    return Row(
      children: [
        Text(title),
        const Spacer(),
        _radioButton("Yes", value,
            onChanged),
        const SizedBox(width: 12),
        _radioButton("No", value,
            onChanged),
      ],
    );
  }

  Widget _radioButton(String label,
      String? groupValue,
      Function(String) onChanged) {
    bool selected = label == groupValue;

    return InkWell(
      onTap: () => onChanged(label),
      child: Row(
        children: [
          Icon(
            selected
                ? Icons
                .radio_button_checked
                : Icons
                .radio_button_unchecked,
            color: const Color(
                0xFF1976D2),
          ),
          Text(label),
        ],
      ),
    );
  }
  Widget _summaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1.2,
        ),
      ),
      child: Column(
        children: [

          _summaryItem(
              "Households Billed",
              totalBilledCount.toString(),
              Colors.blue),

          _divider(),

          _summaryItem(
              "Total Billed",
              "₹ ${totalBilledAmount.toStringAsFixed(2)}",
              Colors.orange),

          _divider(),

          _summaryItem(
              "Total Collected",
              "₹ ${totalCollectedAmount.toStringAsFixed(2)}",
              Colors.green),

          _divider(),

          _summaryItem(
              "Fully Paid",
              fullPaid.toString(),
              Colors.green),

          _divider(),

          _summaryItem(
              "Partially Paid",
              partialPaid.toString(),
              Colors.amber),

          _divider(),

          _summaryItem(
              "Not Paid",
              notPaid.toString(),
              Colors.red),
        ],
      ),
    );
  }


  Widget _summaryItem(String label, String value, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Divider(
        color: Colors.grey.shade300,
        thickness: 1,
      ),
    );
  }


  Widget _saveButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1E88E5),
            Color(0xFF0D47A1),
          ],
        ),
        borderRadius:
        BorderRadius.circular(30),
      ),
      child: const Center(
        child: Text(
          "Submit Monthly Report",
          style: TextStyle(
              color: Colors.white,
              fontWeight:
              FontWeight.bold),
        ),
      ),
    );
  }
}
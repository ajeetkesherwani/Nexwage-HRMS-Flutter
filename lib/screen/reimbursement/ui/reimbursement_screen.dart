import 'package:flutter/material.dart';
import 'package:nexwage/util/image_resource/image_resource.dart';
import 'package:nexwage/widget/customImageView.dart';
import 'package:nexwage/widget/navigator_method.dart';
import 'package:provider/provider.dart';

import '../../../util/color/app_colors.dart';
import '../../../widget/commonAppBar.dart';
import '../../../widget/custom_text.dart';
import '../provider/reimbursement_provider.dart';
import 'new_reimbursement.dart';

class ReimbursementScreen extends StatefulWidget {
  const ReimbursementScreen({super.key});

  @override
  State<ReimbursementScreen> createState() => _ReimbursementScreenState();
}

class _ReimbursementScreenState extends State<ReimbursementScreen> {
  bool isRefreshing = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ReimbursementProvider>(context, listen: false)
          .getReimbursementData();
    });
  }

  Future<void> _handleRefresh() async {
    setState(() {
      isRefreshing = true;
    });

    await Provider.of<ReimbursementProvider>(context, listen: false)
        .getReimbursementData(isRefresh: true);

    setState(() {
      isRefreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReimbursementProvider>(
      builder: (context, provider, child) {
        final reimData = provider.getReimbursementModel?.data ?? [];

        return SafeArea(
          top: false,
          child: Scaffold(
            appBar: CommonAppBar(title: 'Reimbursement'),
            backgroundColor: ColorResource.white,
            body: Stack(
              children: [
                RefreshIndicator(
                  onRefresh: _handleRefresh,
                  child: Stack(
                    children: [
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: reimData.isEmpty
                              ? ListView(
                            physics:
                            const AlwaysScrollableScrollPhysics(),
                            children: [
                              const SizedBox(height: 180),
                              Center(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.receipt_long_outlined,
                                      size: 70,
                                      color: ColorResource.gray,
                                    ),
                                    const SizedBox(height: 12),
                                    CustomText(
                                      'No reimbursement found',
                                      size: 16,
                                      weight: FontWeight.w600,
                                      color: ColorResource.black,
                                    ),
                                    const SizedBox(height: 6),
                                    CustomText(
                                      'Pull down to refresh or add a new reimbursement.',
                                      size: 12,
                                      weight: FontWeight.w400,
                                      color: ColorResource.gray,
                                      align: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                              : Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: reimData.length,
                                  physics:
                                  const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final item = reimData[index];

                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10.0),
                                      child: ticketCard(
                                        image: AppImages.announcement,
                                        title: item.category?.name ??
                                            'Reimbursement',
                                        date:
                                        '${formatDate(item.startDate)} - ${formatDate(item.endDate)}',
                                        product: item.description ??
                                            'No Description',
                                        price:
                                        '₹${item.amount ?? '0'}',
                                        status: item.status ?? '',
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// Floating Add Button
                      Positioned(
                        right: 15,
                        bottom: 15,
                        child: GestureDetector(
                          onTap: () {
                            navPush(
                              context: context,
                              action: const NewReimbursement(),
                            );
                          },
                          child: Container(
                            height: 56,
                            width: 56,
                            decoration: BoxDecoration(
                              color: ColorResource.button1,
                              borderRadius: BorderRadius.circular(999),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.add,
                              color: ColorResource.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// Top Linear Loader while refresh
                if (isRefreshing)
                  const Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: LinearProgressIndicator(
                      color: ColorResource.button1,
                      minHeight: 2,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget ticketCard({
    required String image,
    required String title,
    required String date,
    required String product,
    required String price,
    required String status,
  }) {
    final statusColor = getStatusColor(status);
    final statusBgColor = getStatusBgColor(status);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: ColorResource.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: Color(0xFFF1F5F9),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: image,
            height: 45,
            width: 45,
          ),
          const SizedBox(width: 7),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title,
                  size: 14,
                  weight: FontWeight.w700,
                  overflow: TextOverflow.ellipsis,
                  color: ColorResource.black,
                ),
                const SizedBox(height: 5),
                CustomText(
                  date,
                  size: 11,
                  weight: FontWeight.w400,
                  color: ColorResource.gray,
                ),
                const SizedBox(height: 4),
                CustomText(
                  product,
                  size: 12,
                  weight: FontWeight.w400,
                  color: ColorResource.gray,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          /// Right Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomText(
                price,
                size: 14,
                weight: FontWeight.w700,
                color: ColorResource.black,
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: statusBgColor,
                ),
                child: CustomText(
                  formatStatus(status),
                  size: 10,
                  weight: FontWeight.w700,
                  color: statusColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Format status text
  String formatStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'approved':
        return 'Approved';
      case 'pending':
        return 'Pending';
      case 'rejected':
        return 'Rejected';
      default:
        return 'Unknown';
    }
  }

  /// Status text color
  Color getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  /// Status background color
  Color getStatusBgColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'approved':
        return Colors.green.withOpacity(0.12);
      case 'pending':
        return Colors.orange.withOpacity(0.12);
      case 'rejected':
        return Colors.red.withOpacity(0.12);
      default:
        return Colors.grey.withOpacity(0.12);
    }
  }

  /// Optional date formatter
  String formatDate(String? date) {
    if (date == null || date.isEmpty) return 'N/A';
    return date;
  }
}
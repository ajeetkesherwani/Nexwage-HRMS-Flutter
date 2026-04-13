import 'package:flutter/material.dart';
import 'package:nexwage/screen/profile/provider/profile_provider.dart';
import 'package:nexwage/util/color/app_colors.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:provider/provider.dart';

import '../../../util/image_resource/image_resource.dart';
import '../../../widget/customImageView.dart';
import '../../../widget/custom_text.dart';
import '../../document/ui/document_downloadscreen.dart';
class DocumentViewAllScreen extends StatefulWidget {
  const DocumentViewAllScreen({super.key});

  @override
  State<DocumentViewAllScreen> createState() => _DocumentViewAllScreenState();
}

class _DocumentViewAllScreenState extends State<DocumentViewAllScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProfileProvider>(context, listen: false).getAllDocument();
    });
  }

  Future<void> showDocumentDeleteDialog(
      BuildContext context,
      ProfileProvider profileProvider,
      String id,
      ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Delete Icon
                Container(
                  height: 72,
                  width: 72,
                  decoration: BoxDecoration(
                    color: ColorResource.redBackground,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    color: ColorResource.red,
                    size: 36,
                  ),
                ),

                const SizedBox(height: 20),

                CustomText(
                  'Delete Document?',
                  size: 22,
                  weight: FontWeight.w700,
                  color: ColorResource.black,
                ),

                const SizedBox(height: 12),

                CustomText(
                  'Are you sure you want to delete this document? Once deleted, it cannot be recovered.',
                  size: 14,
                  weight:FontWeight.w300,
                  color: ColorResource.gray,
                ),

                const SizedBox(height: 28),

                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                            height: 45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: CustomText(
                              'Cancel',
                              size: 16,
                              weight: FontWeight.w600,
                              color: ColorResource.black,
                            )
                        ),
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          Navigator.pop(context);

                          await profileProvider.deleteDocument(
                            id: id,
                            isRefresh: true,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor:
                              profileProvider.documentDeleteModel?.status == true
                                  ? Colors.green
                                  : Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              content: Text(
                                profileProvider.documentDeleteModel?.message ??
                                    "Something went wrong",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                            height: 45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorResource.red,
                              borderRadius: BorderRadius.circular(14),

                            ),
                            child: CustomText(
                              'Delete',
                              size: 16,
                              weight: FontWeight.w700,
                              color: ColorResource.white,
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool isRefreshing = false;

  Future<void> _handleRefresh() async {
    setState(() {
      isRefreshing = true;
    });

    await Provider.of<ProfileProvider>(context, listen: false)
        .getAllDocument(isRefresh: true);

    setState(() {
      isRefreshing = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        final documentList =
            profileProvider.getDocumentDataModel?.data ?? [];

        return SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: ColorResource.white,
            appBar: CommonAppBar(title: 'All View Document'),
            body: Stack(
              children: [
                RefreshIndicator(
                  onRefresh: _handleRefresh,
                  color: ColorResource.button1,
                  child: documentList.isEmpty
                      ? ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 100),
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.folder_open_rounded,
                                size: 42,
                                color: ColorResource.gray,
                              ),
                            ),
                            const SizedBox(height: 18),
                            CustomText(
                              "No documents available",
                              size: 18,
                              weight: FontWeight.w600,
                              color: ColorResource.black,
                            ),
                            const SizedBox(height: 8),
                            CustomText(
                              "Your uploaded documents will appear here.",
                              size: 14,
                              weight: FontWeight.w400,
                              color: ColorResource.gray,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                      : ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: documentList.length,
                    itemBuilder: (context, index) {
                      final docData = documentList[index];

                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFFF1F5F9),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.file_copy_rounded,
                                color: ColorResource.gray,
                              ),
                            ),

                            const SizedBox(width: 12),

                            /// Title
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    docData.documentTitle?.isNotEmpty ==
                                        true
                                        ? docData.documentTitle!
                                        : "Untitled Document",
                                    size: 15,
                                    weight: FontWeight.w600,
                                    color: ColorResource.black,
                                  ),
                                  const SizedBox(height: 4),
                                  CustomText(
                                    "Tap to download or delete",
                                    size: 12,
                                    weight: FontWeight.w400,
                                    color: ColorResource.gray,
                                  ),
                                ],
                              ),
                            ),

                            /// Download
                            GestureDetector(
                              onTap: () {
                                print(
                                    'Tapped download for ${docData.documentFile}');
                                DocumentDownload.downloadFile(
                                  context,
                                  docData.documentFile ?? "",
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8FAFC),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: CustomImageView(
                                  imagePath: AppImages.download,
                                  height: 18,
                                  width: 18,
                                ),
                              ),
                            ),

                            const SizedBox(width: 8),

                            /// Delete
                            GestureDetector(
                              onTap: () async {
                                await showDocumentDeleteDialog(
                                  context,
                                  profileProvider,
                                  docData.id.toString(),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF1F2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.delete_outline,
                                  color: ColorResource.red,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

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
}

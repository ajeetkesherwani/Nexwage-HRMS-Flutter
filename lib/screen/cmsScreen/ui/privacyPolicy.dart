
import 'package:flutter/material.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:provider/provider.dart';


import '../../../util/color/app_colors.dart';

import '../../../widget/custom_text.dart';
import '../provider/cmsProvider.dart';

class PrivaCyPolicy extends StatefulWidget {
  const PrivaCyPolicy({super.key});

  @override
  State<PrivaCyPolicy> createState() => _PrivaCyPolicyState();
}

class _PrivaCyPolicyState extends State<PrivaCyPolicy> {

  @override
  void initState() {
    super.initState();

    /// Call API after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CmsProvider>().fetchCmsData();
    });
  }

  /// Remove HTML tags safely
  String parseHtmlString(String htmlString) {
    final regex = RegExp(r'<[^>]*>');
    return htmlString.replaceAll(regex, '');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CmsProvider>(
      builder: (context, provider, child) {

        /// 1️⃣ Loading state
        if (provider.loading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        /// 2️⃣ Null / empty data check
        final cmsData = provider.getCmsData;
        final terms = cmsData?.data?.privacyPolicy;

        if (terms == null || terms.isEmpty) {
          return Scaffold(
            appBar: CommonAppBar(title: 'Privacy Policy'),
            body: const Center(
              child: CustomText(
                'No Terms & Conditions available.',
                size: 14,
              ),
            ),
          );
        }

        /// 3️⃣ Success state
        return Scaffold(
          backgroundColor: ColorResource.white,
          appBar: CommonAppBar(title: 'Privacy Policy'),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: CustomText(
              parseHtmlString(terms),
              size: 14,
            ),
          ),


        );
      },
    );
  }
}

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

  bool isRefreshing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CmsProvider>().fetchCmsData();
    });
  }

  String parseHtmlString(String htmlString) {
    final regex = RegExp(r'<[^>]*>');
    return htmlString.replaceAll(regex, '');
  }

  Future<void> _handleRefresh() async {
    setState(() {
      isRefreshing = true;
    });

    await Provider.of<CmsProvider>(context, listen: false)
        .fetchCmsData(isRefresh: true);

    setState(() {
      isRefreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CmsProvider>(
      builder: (context, provider, child) {

        final cmsData = provider.getCmsData;
        final terms = cmsData?.data?.privacyPolicy;

        return Scaffold(
          backgroundColor: ColorResource.white,
          appBar: CommonAppBar(title: 'Privacy Policy'),

          body: Stack(
            children: [

              /// ✅ Main Content + Pull to Refresh
              RefreshIndicator(
                onRefresh: _handleRefresh,
                child: provider.loading && !isRefreshing
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView(
                  physics: const AlwaysScrollableScrollPhysics(), // ✅ FIX
                  padding: const EdgeInsets.all(16),
                  children: [

                    if (terms == null || terms.isEmpty)
                      const Center(
                        child: CustomText(
                          'No Terms & Conditions available.',
                          size: 14,
                        ),
                      )
                    else
                      CustomText(
                        parseHtmlString(terms),
                        size: 14,
                      ),
                  ],
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
        );
      },
    );
  }
}
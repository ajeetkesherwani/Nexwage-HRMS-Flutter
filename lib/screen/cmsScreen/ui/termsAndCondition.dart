import 'package:flutter/material.dart';
import 'package:nexwage/widget/commonAppBar.dart';
import 'package:provider/provider.dart';
import '../../../util/color/app_colors.dart';
import '../../../widget/custom_text.dart';
import '../provider/cmsProvider.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({super.key});

  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {

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
        final terms = cmsData?.data?.termsCondition;

        return Scaffold(
          backgroundColor: ColorResource.white,
          appBar: CommonAppBar(title: 'Terms & Conditions'),

          body: Stack(
            children: [

              /// ✅ Pull to Refresh + Content
              RefreshIndicator(
                onRefresh: _handleRefresh,
                child: provider.loading && !isRefreshing
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
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

              /// ✅ Top Loader during refresh
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
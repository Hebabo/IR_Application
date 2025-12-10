import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:information_retrieval/core/const/assets_manager.dart';
import 'package:information_retrieval/core/const/string_manager.dart';
import 'package:information_retrieval/core/routes/app_routes.dart';
import 'package:information_retrieval/data/models/onboarding_model.dart';
import 'package:information_retrieval/features/onboarding/bloc/onboarding_bloc.dart';
import '../widgets/onboarding_page_item.dart';
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool _imagesLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precacheImages();
  }

  Future<void> _precacheImages() async {
    final imagePaths = [
      ImageAssets.onboarding1,
      ImageAssets.onboarding2,
      ImageAssets.onboarding3,
    ];

    await Future.wait(
      imagePaths.map((path) => precacheImage(AssetImage(path), context)),
    );

    if (mounted) {
      setState(() {
        _imagesLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_imagesLoaded) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final pages = [
      OnboardingModel(
        title: StringManager.onboarding1Title,
        description: StringManager.onboarding1Desc,
        imagePath: ImageAssets.onboarding1,
      ),
      OnboardingModel(
        title: StringManager.onboarding2Title,
        description: StringManager.onboarding2Desc,
        imagePath: ImageAssets.onboarding2,
      ),
      OnboardingModel(
        title: StringManager.onboarding3Title,
        description: StringManager.onboarding3Desc,
        imagePath: ImageAssets.onboarding3,
      ),
    ];

    final PageController controller = PageController();
    context.read<OnboardingBloc>().add(LoadOnboardingEvent(pagesLength: pages.length));

    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listener: (context, state) async {
        if (state is OnboardingCompleted) {
          Navigator.pushReplacementNamed(context, AppRoutes.search);
        }
      },
      builder: (context, state) {
        if (state is OnboardingLoaded) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                if (state.currentPageIndex < pages.length - 1)
                  TextButton(
                    onPressed: () {
                      context.read<OnboardingBloc>().add(SkipEvent());
                    },
                    child: const Text(
                      StringManager.skip,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: controller,
                    itemCount: pages.length,
                    onPageChanged: (index) {
                      context.read<OnboardingBloc>().add(ChangePageEvent(index));
                    },
                    itemBuilder: (context, index) {
                      final page = pages[index];
                      return OnboardingPageItem(model: page);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // back 
                      TextButton(
                        onPressed: state.currentPageIndex > 0
                            ? () {
                                controller.previousPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeOut,
                                );
                              }
                            : null,
                        child: Text(
                          StringManager.back,
                          style: TextStyle(
                            color: state.currentPageIndex > 0
                                ? Colors.black87
                                : Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),

                      // page indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          pages.length,
                          (i) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 6,
                            width: state.currentPageIndex == i ? 20 : 6,
                            decoration: BoxDecoration(
                              color: state.currentPageIndex == i
                                  ? Colors.black
                                  : Colors.black26,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),

                      // NEXT / START BUTTON
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 26,
                            vertical: 12,
                          ),
                        ),
                        onPressed: () {
                          if (state.currentPageIndex == pages.length - 1) {
                            context.read<OnboardingBloc>().add(CompleteOnboardingEvent());
                          } else {
                            controller.nextPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeOut,
                            );
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              state.currentPageIndex == pages.length - 1
                                  ? StringManager.getStarted
                                  : StringManager.next,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.arrow_right_alt,
                              size: 20,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}

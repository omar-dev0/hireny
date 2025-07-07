import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/widgets/custom_buttom.dart';
import 'package:hireny/utils/widgets/custome_appbar_drawer.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/widgets/sideBar.dart';
import '../../../../../routes/page_route.dart';
import 'cubit/ai_cubit.dart';

class AiContent extends StatefulWidget {
  const AiContent({super.key});

  @override
  State<AiContent> createState() => _AiContentState();
}

class _AiContentState extends State<AiContent> with TickerProviderStateMixin {
  bool _showContent = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _showContent = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<AiCubit>(context);
    return CustomScreen(
      title: 'Ai Tools',
      drawer: SideBarScreen(currentRoute: PagesRoute.aiTools),
      body: Center(
        child: SingleChildScrollView(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 800),
            opacity: _showContent ? 1.0 : 0.0,
            child: AnimatedSlide(
              offset: _showContent ? Offset.zero : const Offset(0, 0.2),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOut,
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Welcome to AI Tools',
                      style: AppFonts.mainText,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Here you can generate a lot of content with AI',
                      style: AppFonts.secMain,
                      textAlign: TextAlign.center,
                    ),
                    Lottie.asset(
                      'assets/animations/robot.json',
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),
                    CustomButtom(
                      title: 'Generate Resume',
                      onPressed: () {
                        cubit.generateAndDownloadResume();
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomButtom(
                      title: 'Generate Cover Letter',
                      onPressed: () {
                        cubit.geneateAndDownloadCoverLetter();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

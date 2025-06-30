import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:hireny/core/widgets/sideBar.dart';
import 'package:hireny/features/services/presentation/ui/widgets/service_card_org.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/widgets/custome_appbar_drawer.dart';


class ServicesView extends StatelessWidget {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> services = [
      {
        'name': 'Mobile App Design',
        'price': '\$750',
        'company': 'Design Studio',
        'companyLogo': 'https://i.pravatar.cc/40?img=10',
        'profiles': [
          'https://i.pravatar.cc/40?img=11',
          'https://i.pravatar.cc/40?img=12',
          'https://i.pravatar.cc/40?img=13',
        ],
      },
      {
        'name': 'Web Development',
        'price': '\$1200',
        'company': 'CodeCraft Inc.',
        'companyLogo': 'https://i.pravatar.cc/40?img=14',
        'profiles': [
          'https://i.pravatar.cc/40?img=15',
          'https://i.pravatar.cc/40?img=16',
        ],
      },
      {
        'name': 'SEO Optimization',
        'price': '\$400',
        'company': 'GrowthPro',
        'companyLogo': 'https://i.pravatar.cc/40?img=17',
        'profiles': [
          'https://i.pravatar.cc/40?img=18',
        ],
      },
      {
        'name': 'UI/UX Audit',
        'price': '\$300',
        'company': 'UX Experts',
        'companyLogo': 'https://i.pravatar.cc/40?img=19',
        'profiles': [
          'https://i.pravatar.cc/40?img=20',
          'https://i.pravatar.cc/40?img=21',
        ],
      },
      {
        'name': 'Mobile App Design',
        'price': '\$750',
        'company': 'Design Studio',
        'companyLogo': 'https://i.pravatar.cc/40?img=10',
        'profiles': [
          'https://i.pravatar.cc/40?img=11',
          'https://i.pravatar.cc/40?img=12',
          'https://i.pravatar.cc/40?img=13',
        ],
      },{
        'name': 'Mobile App Design',
        'price': '\$750',
        'company': 'Design Studio',
        'companyLogo': 'https://i.pravatar.cc/40?img=10',
        'profiles': [
          'https://i.pravatar.cc/40?img=11',
          'https://i.pravatar.cc/40?img=12',
          'https://i.pravatar.cc/40?img=13',
        ],
      },{
        'name': 'Mobile App Design',
        'price': '\$750',
        'company': 'Design Studio',
        'companyLogo': 'https://i.pravatar.cc/40?img=10',
        'profiles': [
          'https://i.pravatar.cc/40?img=11',
          'https://i.pravatar.cc/40?img=12',
          'https://i.pravatar.cc/40?img=13',
        ],
      },{
        'name': 'Mobile App Design',
        'price': '\$750',
        'company': 'Design Studio',
        'companyLogo': 'https://i.pravatar.cc/40?img=10',
        'profiles': [
          'https://i.pravatar.cc/40?img=11',
          'https://i.pravatar.cc/40?img=12',
          'https://i.pravatar.cc/40?img=13',
        ],
      },{
        'name': 'Mobile App Design',
        'price': '\$750',
        'company': 'Design Studio',
        'companyLogo': 'https://i.pravatar.cc/40?img=10',
        'profiles': [
          'https://i.pravatar.cc/40?img=11',
          'https://i.pravatar.cc/40?img=12',
          'https://i.pravatar.cc/40?img=13',
        ],
      },
    ];
    return CustomScreen(
      title: "Services",
      drawer: SideBarScreen(currentRoute: PagesRoute.myCourses),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            /// 🏷 Title
            FadeInDown(
              duration: const Duration(milliseconds: 600),
              child: Text(
                "Available Services (${services.length})",
                style: AppFonts.mainText,
              ),
            ),

            const SizedBox(height: 12),

            /// 🧾 Grid of Service Cards
            Expanded(
              child: GridView.builder(
                itemCount: services.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.80,
                ),
                itemBuilder: (context, index) {
                  final service = services[index];

                  return FadeInUp(
                    duration: Duration(milliseconds: 400 + index * 100),
                    child: InkWell(
                      onTap: (){},
                      child: ServiceCardOrg(
                        name: service['name'] ?? '',
                        price: service['price'] ?? '',
                        company: service['company'] ?? '',
                        companyLogo: service['companyLogo'] ?? '',
                        profiles: List<String>.from(service['profiles'] ?? []),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

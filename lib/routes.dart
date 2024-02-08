import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:focusweb/views/apps/CRM/contacts_page.dart';
import 'package:focusweb/views/apps/CRM/opportunities.dart';
import 'package:focusweb/views/apps/Location/Location.dart';
import 'package:focusweb/views/apps/calender.dart';
import 'package:focusweb/views/apps/chat_page.dart';
import 'package:focusweb/views/apps/contacts/edit_profile.dart';
import 'package:focusweb/views/apps/contacts/member_list.dart';
import 'package:focusweb/views/apps/contacts/profile.dart';
import 'package:focusweb/views/apps/ecommerce/add_product.dart';
import 'package:focusweb/views/apps/ecommerce/customers.dart';
import 'package:focusweb/views/apps/ecommerce/invoice_page.dart';
import 'package:focusweb/views/apps/ecommerce/product_detail.dart';
import 'package:focusweb/views/apps/ecommerce/products.dart';
import 'package:focusweb/views/apps/file/file_manager.dart';
import 'package:focusweb/views/apps/file/file_uploader.dart';
import 'package:focusweb/views/apps/kanban_page.dart';
import 'package:focusweb/views/apps/projects/create_project.dart';
import 'package:focusweb/views/apps/projects/project_detail.dart';
import 'package:focusweb/views/apps/projects/project_list.dart';

import 'package:focusweb/views/auth/forgot_password.dart';
import 'package:focusweb/views/auth/forgot_password_2.dart';
import 'package:focusweb/views/auth/locked.dart';
import 'package:focusweb/views/auth/login.dart';
import 'package:focusweb/views/auth/login_2.dart';
import 'package:focusweb/views/auth/register.dart';
import 'package:focusweb/views/auth/register_2.dart';
import 'package:focusweb/views/auth/reset_password.dart';
import 'package:focusweb/views/auth/reset_password_2.dart';
import 'package:focusweb/views/forms/basic_page.dart';
import 'package:focusweb/views/forms/form_mask.dart';
import 'package:focusweb/views/forms/quill_editor.dart';
import 'package:focusweb/views/forms/validation.dart';
import 'package:focusweb/views/forms/wizard.dart';
import 'package:focusweb/views/other/basic_table.dart';
import 'package:focusweb/views/other/google_map.dart';
import 'package:focusweb/views/other/sfmap_page.dart';
import 'package:focusweb/views/other/synsfusion_chart.dart';
import 'package:focusweb/views/starter.dart';
import 'package:focusweb/views/ui/buttons_page.dart';
import 'package:focusweb/views/ui/cards_page.dart';
import 'package:focusweb/views/ui/carousels.dart';
import 'package:focusweb/views/ui/dialogs.dart';
import 'package:focusweb/views/ui/drag_drop.dart';
import 'package:focusweb/views/ui/notifications.dart';
import 'package:focusweb/views/ui/reviews_page.dart';
import 'package:focusweb/views/ui/tabs_page.dart';

import 'helpers/services/auth_services.dart';
import 'views/apps/Employees/Employees.dart';
import 'views/auth/locked_2.dart';
import 'views/dashboard.dart';
import 'views/error_pages/coming_soon_page.dart';
import 'views/error_pages/error_404.dart';
import 'views/error_pages/error_500.dart';
import 'views/error_pages/maintenance_page.dart';
import 'views/extra_pages/faqs_page.dart';
import 'views/extra_pages/pricing.dart';
import 'views/extra_pages/time_line_page.dart';
import 'views/ui/landing_page.dart';
import 'views/ui/nft_dashboard.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return AuthService.isLoggedIn
        ? null
        : const RouteSettings(name: '/auth/login');
  }
}

getPageRoute() {
  return [
    GetPage(
        name: '/',
        page: () => const DashboardPage(),
        middlewares: [AuthMiddleware()]),

    GetPage(name: '/faqs', page: () => const FaqsPage()),

    GetPage(
        name: '/pricing',
        page: () => const Pricing(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/starter',
        page: () => const Starter(),
        middlewares: [AuthMiddleware()]),


    ///--------------- Ecommerce ---------------///
    GetPage(
        name: '/apps/ecommerce/products',
        page: () => const ProductPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/ecommerce/add_product',
        page: () => const AddProduct(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/ecommerce/product-detail',
        page: () => const ProductDetail(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/ecommerce/customers',
        page: () => const Customers(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/dashboard',
        page: () => const DashboardPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/apps/ecommerce/invoice',
        page: () => const InvoicePage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/timeline',
        page: () => const TimeLinePage(),
        middlewares: [AuthMiddleware()]),

    ///---------------- File ----------------///

    GetPage(
        name: '/apps/files',
        page: () => const FileManager(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/apps/file-uploader',
        page: () => const FileUploader(),
        middlewares: [AuthMiddleware()]),

    ///---------------- Ntf ----------------///

    GetPage(
        name: '/NFTDashboard',
        page: () => const NFTDashboardScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/Event',
        page: () => const Calender(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/Employees',
        page: () => const Employees(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/Location',
        page: () => const Location(),
        middlewares: [AuthMiddleware()]),

    ///---------------- KanBan ----------------///

    GetPage(
        name: '/kanban',
        page: () => const KanBanPage(),
        middlewares: [AuthMiddleware()]),

    ///---------------- Projects ----------------///
    GetPage(
        name: '/projects/project-list',
        page: () => const ProjectListPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/projects/project-detail',
        page: () => const ProjectDetail(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/projects/create-project',
        page: () => const CreateProject(),
        middlewares: [AuthMiddleware()]),

    ///---------------- Contacts ----------------///

    GetPage(
        name: '/contacts/profile',
        page: () => const ProfilePage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/contacts/members',
        page: () => const MemberList(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/contacts/edit-profile',
        page: () => const EditProfile(),
        middlewares: [AuthMiddleware()]),

    ///---------------- CRM ----------------///

    GetPage(
        name: '/crm/contacts',
        page: () => const ContactsPage(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/crm/opportunities',
        page: () => const OpportunitiesPage(),
        middlewares: [AuthMiddleware()]),

    ///---------------- Auth ----------------///

    GetPage(name: '/auth/login', page: () => const LoginPage()),
    GetPage(name: '/auth/login1', page: () => const Login2()),
    GetPage(name: '/auth/forgot_password', page: () => const ForgotPassword()),
    GetPage(
        name: '/auth/forgot_password1', page: () => const ForgotPassword2()),
    GetPage(name: '/auth/register', page: () => const Register()),
    GetPage(name: '/auth/register1', page: () => const Register2()),
    GetPage(name: '/auth/reset_password', page: () => const ResetPassword()),
    GetPage(name: '/auth/reset_password1', page: () => const ResetPassword2()),
    GetPage(
        name: '/auth/locked',
        page: () => const LockedPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/auth/locked1',
        page: () => const LockedPage2(),
        middlewares: [AuthMiddleware()]),

    ///---------------- UI ----------------///

    GetPage(
        name: '/ui/buttons',
        page: () => const ButtonsPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/ui/cards',
        page: () => const CardsPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/ui/tabs',
        page: () => const TabsPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/ui/dialogs',
        page: () => const Dialogs(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/ui/carousels',
        page: () => const Carousels(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/ui/drag-drop',
        page: () => const DragDropPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/ui/notification',
        page: () => const Notifications(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/ui/reviews',
        page: () => const ReviewsPage(),
        middlewares: [AuthMiddleware()]),
    // GetPage(
    //     name: '/ui/discover',
    //     page: () => const DiscoverJobs(),
    //     middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/ui/landing',
        page: () => const LandingPage(),
        middlewares: [AuthMiddleware()]),

    ///---------------- Error ----------------///

    GetPage(
        name: '/coming-soon',
        page: () => const ComingSoonPage(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/error-404',
        page: () => const Error404(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/error-500',
        page: () => const Error500(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/maintenance',
        page: () => const MaintenancePage(),
        middlewares: [AuthMiddleware()]),

    ///---------------- Chat ----------------///

    GetPage(
        name: '/chat',
        page: () => const ChatPage(),
        middlewares: [AuthMiddleware()]),

    ///---------------- Form ----------------///

    GetPage(
        name: '/form/basic',
        page: () => const BasicPage(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/form/validation',
        page: () => const ValidationPage(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/form/quill-editor',
        page: () => const QuillEditor(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/form/form-mask',
        page: () => const FormMaskPage(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/form/wizard',
        page: () => const Wizard(),
        middlewares: [AuthMiddleware()]),

    ///---------------- Other ----------------///

    GetPage(
        name: '/other/basic_tables',
        page: () => const BasicTable(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/other/syncfusion_charts',
        page: () => const SyncFusionChart(),
        middlewares: [AuthMiddleware()]),

    ///---------------- Maps ----------------///

    GetPage(
        name: '/maps/sf-maps',
        page: () => const SfMapPage(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/maps/google-maps',
        page: () => const GoogleMapPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/LoginPage',

        middlewares: [AuthMiddleware()], page: () =>  LoginPage()),
  ];

}

// class AuthMiddleware1 extends MyMiddleware {
//   @override
//   String handle(String routeName) {
//     return AuthService.isLoggedIn ? routeName : '/auth/login';
//   }
// }
//
// PageRouteBuilder generateRoute(BuildContext context, RouteSettings settings) {
//   MyRoutes.registerRoute(
//       MyRoute(name: '/pricing', builder: (_) => const Pricing()));
//   MyRoutes.registerRoute(
//       MyRoute(name: '/faqs', builder: (_) => const FaqsPage()));
//   MyRoutes.registerRoute(
//       MyRoute(name: '/starter', builder: (_) => const Starter()));
//
//   var routes = [
//     MyRoute(
//         name: '/dashboard',
//         builder: (_) => const DashboardPage(),
//         middlewares: [AuthMiddleware1()]),
//     // Ecommerce
//     MyRoute(
//         name: '/apps/ecommerce/products',
//         builder: (_) => const ProductPage(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/apps/ecommerce/add_product',
//         builder: (_) => const AddProduct(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/apps/ecommerce/product-detail',
//         builder: (_) => const ProductDetail(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/apps/ecommerce/customers',
//         builder: (_) => const Customers(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/apps/ecommerce/invoice',
//         builder: (_) => const InvoicePage(),
//         middlewares: [AuthMiddleware1()]),
//
//     //----------------File----------------//
//     MyRoute(
//         name: '/apps/files',
//         builder: (_) => const FileManager(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/apps/file-uploader',
//         builder: (_) => const FileUploader(),
//         middlewares: [AuthMiddleware1()]),
//
//     //----------------NFT----------------//
//     MyRoute(
//         name: '/nft/dashboard',
//         builder: (_) => const NftDashboard(),
//         middlewares: [AuthMiddleware1()]),
//
//     //-----------------Jobs-----------------//
//     MyRoute(
//         name: '/job/job-vacancee',
//         builder: (_) => const JobVacanceePage(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/job/job-candidate',
//         builder: (_) => const JobCandiadatePage(),
//         middlewares: [AuthMiddleware1()]),
//
//     //-----------------Profile-----------------//
//     MyRoute(
//         name: '/profile',
//         builder: (_) => const ProfilePage(),
//         middlewares: [AuthMiddleware1()]),
//
//     //----------------Auth----------------//
//     MyRoute(
//         name: '/auth/login',
//         builder: (_) => const LoginPage(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/auth/forgot-password',
//         builder: (_) => const ForgotPassword(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/auth/register',
//         builder: (_) => const Register(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/auth/reset_password',
//         builder: (_) => const ResetPassword(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/auth/locked',
//         builder: (_) => const LockedPage(),
//         middlewares: [AuthMiddleware1()]),
//
//     //----------------UI----------------//
//     MyRoute(
//         name: '/ui/buttons',
//         builder: (_) => const ButtonsPage(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/ui/cards',
//         builder: (_) => const CardsPage(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/ui/tabs',
//         builder: (_) => const TabsPage(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/ui/dialogs',
//         builder: (_) => const Dialogs(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/ui/carousels',
//         builder: (_) => const Carousels(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/ui/drag-drop',
//         builder: (_) => const DragDropPage(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/ui/notifications',
//         builder: (_) => const Notifications(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/ui/reviews',
//         builder: (_) => const ReviewsPage(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/ui/discover',
//         builder: (_) => const DiscoverJobs(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/ui/landing',
//         builder: (_) => const LandingPage(),
//         middlewares: [AuthMiddleware1()]),
//
//     //----------------ExtraPages----------------//
//     MyRoute(
//         name: '/coming-soon',
//         builder: (_) => const ComingSoonPage(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/error-404',
//         builder: (_) => const Error404(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/error-500',
//         builder: (_) => const Error500(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/maintenance',
//         builder: (_) => const MaintenancePage(),
//         middlewares: [AuthMiddleware1()]),
//
//     //----------------Chat----------------//
//
//     MyRoute(
//         name: '/chat',
//         builder: (_) => const ChatPage(),
//         middlewares: [AuthMiddleware1()]),
//
//     //----------------Form----------------//
//     MyRoute(
//         name: '/form/basic',
//         builder: (_) => const BasicPage(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/form/validation',
//         builder: (_) => const ValidationPage(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/form/quill-editor',
//         builder: (_) => const QuillEditor(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/form/form-mask',
//         builder: (_) => const FormMaskPage(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/form/wizard',
//         builder: (_) => const Wizard(),
//         middlewares: [AuthMiddleware1()]),
//
//     ///----------------Other----------------//
//
//     MyRoute(
//         name: '/other/basic_tables',
//         builder: (_) => const BasicTable(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/other/syncfusion_charts',
//         builder: (_) => const SyncFusionChart(),
//         middlewares: [AuthMiddleware1()]),
//
//     //----------------Maps----------------//
//     MyRoute(
//         name: '/maps/sf-maps',
//         builder: (_) => const SfMapPage(),
//         middlewares: [AuthMiddleware1()]),
//     MyRoute(
//         name: '/maps/google-maps',
//         builder: (_) => const GoogleMapPage(),
//         middlewares: [AuthMiddleware1()]),
//
//     MyRoute(
//         name: '/',
//         builder: (_) => const DashboardPage(),
//         middlewares: [AuthMiddleware1()]),
//   ];
//
//   //Dashboard
//   // MyRoutes.registerRoute();
//   //
//   // MyRoutes.registerRoute();
//
//   ///========== UI =================///
//
//   // UI Pages
//
//   // MyRoutes.registerRoute();
//
//   MyRoutes.registerRoutes(routes);
//
//   //Finding Routes
//   MyRoute? route = MyRouter.getSecuredRouteFromRouteName(settings.name ?? '/');
//   log(MyRoutes.routes[1].name);
//
//   Uri? settingsUri;
//   if (route != null && settings.name != route.name) {
//     settingsUri = Uri.parse(Uri.parse(route.name).path);
//     if (settingsUri.queryParameters['next'] == null) {
//       settingsUri = settingsUri.replace(
//           queryParameters: {'next': Uri.parse(settings.name ?? "").path});
//     }
//   }
//
//   return PageRouteBuilder(
//     settings: RouteSettings(
//       arguments: settings.arguments,
//       name: settingsUri?.toString() ?? settings.name,
//     ),
//     pageBuilder: (context, animation1, animation2) =>
//         route != null ? route.builder(context) : const DashboardPage(),
//     transitionDuration: Duration.zero,
//     reverseTransitionDuration: Duration.zero,
//   );
// }

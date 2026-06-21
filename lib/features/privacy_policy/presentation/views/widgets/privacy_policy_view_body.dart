import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/default_view_header.dart';

class PrivacyPolicyViewBody extends StatelessWidget {
  const PrivacyPolicyViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: kPagePadding.w,
          vertical: 12.h,
        ),
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
            child: const DefaultViewHeader(title: 'Privacy Policy'),
          ),
          const _PolicySection(
            title: '1. Introduction',
            body:
                'Monument ("we", "our", or "the App") respects your privacy. '
                'This Privacy Policy explains what information we collect, how '
                'we use it, and the choices you have. By using Monument, you '
                'agree to the collection and use of information in accordance '
                'with this policy.',
          ),
          const _PolicySection(
            title: '2. Information We Collect',
            body:
                'We collect the following categories of information:\n\n'
                '• Account Information: When you create an account, we collect '
                'your email address and a display name. Authentication is '
                'handled securely through Firebase Authentication.\n\n'
                '• User-Generated Content: Posts, comments, likes, and habits '
                'you create within the App are stored in our database (Cloud '
                'Firestore) so they can sync across your devices and be shown '
                'to other users where applicable (e.g. community posts).\n\n'
                '• Locally Stored Data: Certain app data, such as habit '
                'tracking history, may be stored locally on your device to '
                'allow offline access. This data remains on your device unless '
                'explicitly synced.\n\n'
                '• Communications: If you contact support or use email-based '
                'verification (OTP), your email address is used solely to '
                'deliver that communication.',
          ),
          const _PolicySection(
            title: '3. How We Use Your Information',
            body:
                'We use the information we collect to:\n\n'
                '• Create and manage your account\n'
                '• Provide core app functionality (habit tracking, community '
                'posts, comments)\n'
                '• Authenticate you securely and prevent unauthorized access\n'
                '• Send verification codes and important account notifications\n'
                '• Maintain and improve the App\'s reliability and performance\n'
                '• Respond to support requests',
          ),
          const _PolicySection(
            title: '4. Third-Party Services',
            body:
                'Monument uses the following third-party services to operate:\n\n'
                '• Firebase Authentication (Google LLC) — manages secure '
                'sign-in and account credentials.\n\n'
                '• Cloud Firestore (Google LLC) — stores app data such as '
                'posts, comments, and account information.\n\n'
                '• Email Delivery Provider — used to send one-time '
                'verification codes to your email address during sign-up or '
                'account verification.\n\n'
                'These providers may process data on servers located outside '
                'your country of residence. Each provider maintains its own '
                'privacy and security practices, in compliance with applicable '
                'data protection laws.',
          ),
          const _PolicySection(
            title: '5. Data Sharing and Disclosure',
            body:
                'We do not sell your personal information. We may share '
                'limited information only in the following circumstances:\n\n'
                '• With service providers (such as those listed above) solely '
                'to operate the App\n'
                '• If required by law, regulation, or legal process\n'
                '• To protect the rights, safety, or property of Monument, '
                'our users, or others\n'
                '• With your explicit consent\n\n'
                'Content you choose to post publicly within the community '
                'features (such as posts and comments) may be visible to '
                'other users of the App.',
          ),
          const _PolicySection(
            title: '6. Data Storage and Security',
            body:
                'We take reasonable technical and organizational measures to '
                'protect your information against unauthorized access, '
                'alteration, disclosure, or destruction. Data transmitted to '
                'our backend services is encrypted in transit. However, no '
                'method of electronic storage or transmission is 100% secure, '
                'and we cannot guarantee absolute security.',
          ),
          const _PolicySection(
            title: '7. Data Retention',
            body:
                'We retain your personal information for as long as your '
                'account is active or as needed to provide you services. If '
                'you delete your account, we will delete or anonymize your '
                'personal information within a reasonable period, except '
                'where retention is required to comply with legal obligations, '
                'resolve disputes, or enforce our agreements.',
          ),
          const _PolicySection(
            title: '8. Your Rights and Choices',
            body:
                'Depending on your location, you may have the right to:\n\n'
                '• Access the personal information we hold about you\n'
                '• Request correction of inaccurate data\n'
                '• Request deletion of your account and associated data\n'
                '• Withdraw consent where processing is based on consent\n\n'
                'You can request account deletion directly within the App '
                'under Profile settings, or by contacting us using the '
                'details below.',
          ),
          const _PolicySection(
            title: '9. Children\'s Privacy',
            body:
                'Monument is not directed at children under the age of 13, '
                'and we do not knowingly collect personal information from '
                'children under 13. If we become aware that we have '
                'inadvertently collected such information, we will take '
                'steps to delete it promptly.',
          ),
          const _PolicySection(
            title: '10. International Data Transfers',
            body:
                'Your information may be transferred to, stored, and '
                'processed in countries other than your own, including the '
                'United States, where our service providers operate data '
                'centers. We take steps to ensure appropriate safeguards are '
                'in place for such transfers.',
          ),
          const _PolicySection(
            title: '11. Changes to This Policy',
            body:
                'We may update this Privacy Policy from time to time. Changes '
                'will be reflected by an updated "Last Updated" date. We '
                'encourage you to review this policy periodically. Continued '
                'use of the App after changes constitutes acceptance of the '
                'revised policy.',
          ),
          const _PolicySection(
            title: '12. Contact Us',
            body:
                'If you have any questions, concerns, or requests regarding '
                'this Privacy Policy or your personal data, please contact us '
                'at:\n\nhazemco711@gmail.com',
          ),
          Gap(30.h),
        ],
      ),
    );
  }
}

class _PolicySection extends StatelessWidget {
  final String title;
  final String body;
  const _PolicySection({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 18.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.secondaryColor,
            ),
          ),
          Gap(8.h),
          Text(
            body,
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              height: 1.5,
              color: AppColors.secondaryColor.withValues(alpha: .85),
            ),
          ),
        ],
      ),
    );
  }
}

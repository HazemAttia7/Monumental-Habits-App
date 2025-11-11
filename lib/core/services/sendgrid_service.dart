import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

abstract class SendGridService {
  static final String _apiKey = dotenv.env['SENDGRID_API_KEY'] ?? '';
  static const String _endpoint = 'https://api.sendgrid.com/v3/mail/send';

  static Future<bool> sendMarketingEmail(String userEmail) async {
    final emailData = {
      "personalizations": [
        {
          "to": [
            {"email": userEmail},
          ],
          "subject":
              "🎉 Welcome! Your Exclusive 60% OFF Premium Offer (Expires Soon!)",
        },
      ],
      "from": {"email": "hazemco711@gmail.com", "name": "Monumental Habits"},
      "content": [
        {
          "type": "text/plain",
          "value": """
🎉 Welcome to Monumental Habits!

Hi there 👋,

Welcome to our community! We're thrilled to have you here.

Since you've opted in for special pricing, we wanted to make sure you didn't miss this incredible offer we've prepared just for you.

⏰ LIMITED TIME OFFER - EXPIRES IN 23:56:48
GET 60% OFF YOUR PREMIUM UPGRADE!

Included in your upgrade:
✓ Unlimited habits
✓ Access to all courses
✓ Access to all avatar illustrations

SPECIAL PRICING (60% OFF!):
- MONTHLY PLAN: \$19.00
- YEARLY PLAN: \$29.00 ⭐ MOST POPULAR
- LIFETIME PLAN: \$49.00 💎 BEST DEAL

Subscribe now: [subscribe link]

You're receiving this email because you opted in for special pricing and promotional updates.
If you’d like to unsubscribe, click here: [unsubscribe link]
          """,
        },
      ],
    };

    final response = await http.post(
      Uri.parse(_endpoint),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(emailData),
    );

    return response.statusCode == 202;
  }
}

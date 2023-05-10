import 'dart:developer';
import 'package:mailgun_mailer/src/mailer.dart';
import 'package:mailgun_mailer/src/model/request.dart';

void main() async {
  final apiKey = '< APIKEY >';
  final domain = '< DOMAIN >';
  try {
    final mailService = MailgunMailer(
      apiKey: apiKey,
      domain: domain,
    );

    final email = MailRequest(
      content: 'Hola Mundo con MailGun Mailer !!!',
      from: 'ejemplo <ejemplo@gmail.com>',
      to: [' ejemplo@gmail.com'],
      subject: 'Hola desde MailGun Mailer !!!',
    );

    await mailService.send(email);
  } catch (e) {
    log('Error: $e');
  }
}

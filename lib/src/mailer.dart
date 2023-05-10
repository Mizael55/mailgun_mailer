import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mailgun_mailer/src/model/request.dart';

class MailgunMailer {
  final String domain;
  final String apiKey;

  MailgunMailer({required this.domain, required this.apiKey});

  Future<void> send(MailRequest email) async {
    var client = http.Client();
    try {
      var request = http.MultipartRequest(
          'POST',
          Uri(
              userInfo: 'api:$apiKey',
              scheme: 'https',
              host: 'api.mailgun.net',
              path: '/v3/$domain/messages'));

      request.fields['subject'] = email.subject ?? '';
      request.fields['html'] = email.html ?? '';
      request.fields['text'] = email.text ?? '';
      request.fields['from'] = email.from;
      if (email.to.isNotEmpty) {
        request.fields['to'] = email.to.join(", ");
      }
      if (email.content.isNotEmpty) {
        request.fields['text'] = email.content;
      }
      if (email.cc.isNotEmpty) {
        request.fields['cc'] = email.cc.join(", ");
      }
      if (email.bcc.isNotEmpty) {
        request.fields['bcc'] = email.bcc.join(", ");
      }
      request.fields['template'] = email.template ?? '';

      if (email.options != null) {
        if (email.options!.containsKey('template_variables')) {
          request.fields['h:X-Mailgun-Variables'] =
              jsonEncode(email.options!['template_variables']);
        }
      }
      if (email.attachments.isNotEmpty) {
        request.headers["Content-Type"] = "application/json";
        for (var i = 0; i < email.attachments.length; i++) {
          var attachment = email.attachments[i];
          if (attachment is File) {
            request.files.add(await http.MultipartFile.fromPath(
                'attachment', attachment.path));
          }
        }
      }
      
      String basicAuth = 'Basic ${base64Encode(utf8.encode('api:$apiKey'))}';
      request.headers['authorization'] = basicAuth;

      await client.send(request);
    } catch (e) {
      log('Error Dios mio: $e');
    }
  }
}

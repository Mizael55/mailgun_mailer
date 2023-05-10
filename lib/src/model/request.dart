
class MailRequest {
  final String from;
  final String content;
  final List<String> to;
  final List<String> cc;
  final List<String> bcc;
  final List<dynamic> attachments;
  final String? subject;
  final String? html;
  final String? text;
  final String? template;
  final Map<String, dynamic>? options;

  MailRequest({
    required this.from,
    required this.content,
    this.to = const [],
    this.cc = const [],
    this.bcc = const [],
    this.attachments = const [],
    this.subject,
    this.html,
    this.text,
    this.template,
    this.options,
  });

  Map<String, dynamic> toJson() => {
        'from': from,
        'content': content,
        'to': to,
        'cc': cc,
        'bcc': bcc,
        'attachments': attachments,
        'subject': subject,
        'html': html,
        'text': text,
        'template': template,
        'options': options,
      };
}
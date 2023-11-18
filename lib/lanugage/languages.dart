import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'message': 'Language?',
          'name': 'English',
          'signin': 'Sign In',
          'createaccount': 'Create an Account',
          'slogan':
              'Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep'
        },
        'ur_PK': {
          'message': 'زبان؟',
          'name': 'اردو',
          'signin': 'لاگ ان کریں',
          'createaccount': 'رجسٹر کریں',
          'slogan':
              '1,000 سے زیادہ ریستوراں سے بہترین کھانے کی اشیاء دریافت کریں اور آپ کی دہلیز پر تیز ترسیل'
        },
      };
}

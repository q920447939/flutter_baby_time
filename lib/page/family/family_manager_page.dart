import 'package:flutter/cupertino.dart';
import 'package:flutter_baby_time/widget/base_stack/base_stack.dart';
import 'package:flutter_baby_time/widget/button/default_button.dart';
import 'package:flutter_baby_time/widget/container/container_wrapper_card.dart';
import 'package:flutter_baby_time/widget/future/future_.dart';
import 'package:flutter_baby_time/widget/gap/gap_height.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../dao/family/family_dao.dart';
import '../../model/baby/BabyInfoRespVO.dart';
import 'family_create_or_add_manager_page.dart';
import 'family_select_exists_page.dart';

class FamilyManagerPage extends StatefulWidget {
  const FamilyManagerPage({super.key});

  @override
  State<FamilyManagerPage> createState() => _FamilyManagerPageState();
}

class _FamilyManagerPageState extends State<FamilyManagerPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<FamilyRespVo>?> fetch() async {
    return await FamilyDao.get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureLoading(
      future: fetch(),
      builder: (c, List<FamilyRespVo>? data) {
        return FamilyCreateOrAddManagerPage(
          data: data ?? [],
        );
      },
    );
  }
}

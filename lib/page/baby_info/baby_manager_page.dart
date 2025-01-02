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

import '../../dao/baby/baby_dao.dart';
import '../../dao/family/family_dao.dart';
import '../../model/baby/BabyInfoRespVO.dart';
import 'baby_create_or_add_manager_page.dart';

class BabyManagerPage extends StatefulWidget {
  const BabyManagerPage({super.key});

  @override
  State<BabyManagerPage> createState() => _BabyManagerPageState();
}

class _BabyManagerPageState extends State<BabyManagerPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<BabyInfoRespVo>?> fetch() async {
    return await BabyDao.fetchAllBaby();
  }

  @override
  Widget build(BuildContext context) {
    return FutureLoading(
      future: fetch(),
      builder: (c, List<BabyInfoRespVo>? data) {
        return BabyCreateOrAddManagerPage(
          data: data ?? [],
        );
      },
    );
  }
}

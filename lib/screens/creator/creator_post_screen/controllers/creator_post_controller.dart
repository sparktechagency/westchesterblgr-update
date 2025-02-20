import 'package:get/get.dart';

import '../../../../models/creator_status_model.dart';
import '../../../../services/repository/creator_status_repository/creator_status_repository.dart';

class CreatorPostController extends GetxController {
  final CreatorStatusRepository _creatorStatusRepository =
      CreatorStatusRepository();
  var creatorStatus = CreatorStatus(allEvents: [], allJobs: []).obs;
  var isLoading = true.obs;

  Future<void> fetchCreatorStatus() async {
    try {
      isLoading(true);
      final status = await _creatorStatusRepository.fetchCreatorStatus();
      if (status != null) {
        creatorStatus.value = status;
      }
    } catch (e) {
      print("Error in fetchCreatorStatus: $e");
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    fetchCreatorStatus();
    super.onInit();
  }
}

import 'package:athar_project/admin/Complaint_hmla_Model.dart';
import 'package:get/get.dart';

class ComplaintsController extends GetxController {
  RxList<Complaint_hmla_Model> complaints = <Complaint_hmla_Model>[
    Complaint_hmla_Model(
      id: '1',
      title: 'اقتراح',
      description: 'اقتراح تحسين النظام التطوعي.',
      volunteerName: 'محمد العلي',
      campaignName: 'حملة رمضان',
    ),
    Complaint_hmla_Model(
      id: '2',
      title: 'شكوى',
      description: 'المتطوع لم يحضر في الوقت المحدد.',
      volunteerName: 'أحمد خالد',
      campaignName: 'حملة تنظيف الشوارع',
    ),
  ].obs;

  void deleteComplaint(String id) {
    complaints.removeWhere((item) => item.id == id);
  }

  void deleteAll() {
    complaints.clear();
  }

  void goToComplaintDetails(Complaint_hmla_Model complaint) {
    Get.toNamed('/complaint-details', arguments: complaint);
  }
}

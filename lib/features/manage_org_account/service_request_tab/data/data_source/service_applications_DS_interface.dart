import 'package:hireny/result.dart';

abstract class ServiceApplicationsDSInterface{
  Future<Result<void>> getServiceApplications ();
  Future<Result<void>> deleteServiceApplication(int id);
}
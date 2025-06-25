import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/seeker/view/screens/job_detailes/cubit/state/job_detailes_state.dart';
import 'package:injectable/injectable.dart';
@injectable
class JobDetailesCubit extends Cubit<JobDatailesState>{
  @factoryMethod
  JobDetailesCubit() : super(InitJobDetailes());

}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/manage_org_account/reviews_tab/presentation/manager/review_states.dart';
import 'package:injectable/injectable.dart';


// @injectable
class ReviewCubit extends Cubit<ReviewStates> {
  ReviewCubit() : super(InitialState());



}

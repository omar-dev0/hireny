import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/view/profile/ai_tools/cubit/state/states.dart';
import 'package:injectable/injectable.dart';

@injectable
class AiCubit extends Cubit<AIState> {
  @factoryMethod
  AiCubit() : super(AIInitState());
}

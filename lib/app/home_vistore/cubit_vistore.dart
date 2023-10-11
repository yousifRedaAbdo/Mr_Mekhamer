import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohamed_mekhemar/app/home_vistore/states_vistore.dart';
import 'package:mohamed_mekhemar/app/home_vistore/dio_helper.dart';
import 'package:mohamed_mekhemar/app/home_vistore/vistore_model.dart';

class VistorCubit extends Cubit<VistorStates> {
  VistorCubit() : super(VistorInisialState());

  static VistorCubit get(context) => BlocProvider.of(context);

  VistorModel? vistorModel;
  void getVistoreData() {
    emit(VistorLoadingHomeDataState());
    dioHelper
        .getdata(
      url: 'mohamedmekhemar/signleteacher/apis.php?function=loginasguest',
    )
        .then((value) {
      vistorModel = VistorModel.fromJson(value.data);
      emit(VistorSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(VistorErrorHomeDataState());
    });
  }
}

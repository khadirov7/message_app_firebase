import 'dart:isolate';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app_solid/data/models/file_data_model.dart';
import 'package:open_filex/open_filex.dart';
import '../../data/models/file_status_model.dart';
import '../../services/file_manager_services.dart';
import 'file_state.dart';


class FileManagerCubit extends Cubit<FileManagerState> {
  FileManagerCubit()
      : super(
    const FileManagerState(
      progress: 0.0,
      newFileLocation: "",
    ),
  );

  Future<void> downloadFile(FileDataModel fileDataModel) async {
    final Dio dio = Dio();

    final fileStatusModel = await getStatus(fileDataModel);

    if (fileStatusModel.isExist) {
      OpenFilex.open(fileStatusModel.newFileLocation);
    } else {
      await dio.download(
        fileDataModel.urlFile,
        fileStatusModel.newFileLocation,
        onReceiveProgress: (count, total) {
          emit(state.copyWith(progress: count / total));
        },
      );

      await FileManagerService.init();

      emit(
        state.copyWith(
          progress: 1.0,
          newFileLocation: fileStatusModel.newFileLocation,
        ),
      );
    }
  }

  Future<FileStatusModel> getStatus(FileDataModel fileDataModel) async {
    return await Isolate.run(() async {
      return await FileManagerService.checkFile(fileDataModel);
    });
  }
}

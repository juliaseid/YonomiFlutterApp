import 'package:yonomi_platform_sdk/yonomi-sdk.dart';
import 'package:yonomi_flutter_app/request.dart';
import 'package:yonomi_device_widgets/providers/widget_state.dart';
import 'package:yonomi_device_widgets/ui/string_constants.dart';

typedef GetDeviceListMethod = Future<List<Device>> Function(Request request);

class DeviceList {
  late Request _request;

  List<Device>? _deviceList;
  WidgetState _state = WidgetState.idle;
  String _errorMsg = StringConstants.AN_ERROR_OCCURRED;
  bool _isDisposed = false;

  DeviceList(Request request,
      {GetDeviceListMethod getDeviceList = DevicesRepository.getDevices}) {
    this._request = request;
    fetchData(getDeviceList: getDeviceList);
  }

  Future<void> fetchData(
      {GetDeviceListMethod getDeviceList =
          DevicesRepository.getDevices}) async {
    setState = WidgetState.loading;

    try {
      _deviceList = await getDeviceList(_request);
      setState = WidgetState.idle;
    } catch (error) {
      setErrorState(error.toString());
    }
  }

  List<Device>? get myDevices => _deviceList;

  set setState(WidgetState newState) {
    if (!this._isDisposed) {
      _state = newState;
    }
  }

  void dispose() {
    this._isDisposed = true;
  }

  void setErrorState(String errorMsg) {
    _setErrorMessage = errorMsg;
    setState = WidgetState.error;
  }

  set _setErrorMessage(String errorMsg) {
    if (errorMsg.isEmpty) errorMsg = "An error occurred.";
    _errorMsg = errorMsg;
  }

  bool get isInErrorState => _state == WidgetState.error;

  bool get isLoading => _state == WidgetState.loading;

  bool get isPerformingAction => _state == WidgetState.performingAction;

  bool get isBusy =>
      (_state == WidgetState.loading || _state == WidgetState.performingAction);

  String get getErrorMessage => _errorMsg;
}

//How to handle reqeusts that aren't built into the SDK methods? I guess just a regular API call specifying endpoint and headers as properties of Request class
//This is what we'll have to use for now for "allDevices", but the advantage is being able to specify a minimal device view that won't require state handling
//That way, all state management will happen at DetailScreen level, keeping Provider out of "allDevices" screen
//How to build a custom UI widget? IDK. I hope it is easy.
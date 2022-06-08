class ApiResponse<T> {
  String? message;
  T? data;
  Status? status;

  ApiResponse.initial(this.message) : status = Status.INITIAL;
  ApiResponse.loading(this.message) : status = Status.LOADING;
  ApiResponse.error(this.message) : status = Status.ERROR;
  ApiResponse.success(this.data) : status = Status.SUCCESS;
}

enum Status { INITIAL, LOADING, SUCCESS, ERROR }

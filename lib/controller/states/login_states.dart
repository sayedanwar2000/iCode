abstract class LoginStates {}

class InitialLoginStates extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginErrorState extends LoginStates {}

class LoginSuccessState extends LoginStates {}

class GetAvailableBiometricsLoading extends LoginStates {}

class GetAvailableBiometricsSuccess extends LoginStates {}

class GetAvailableBiometricsError extends LoginStates {}

abstract class AuthStates {}

class InitState extends AuthStates{}

class EmitState extends AuthStates{}

class CreateUserLoadingState extends AuthStates{}
class CreateUserSuccessState extends AuthStates{}
class CreateUserWrongState extends AuthStates{}
class CreateUserErrorState extends AuthStates{}

class CreateProviderLoadingState extends AuthStates{}
class CreateProviderSuccessState extends AuthStates{}
class CreateProviderWrongState extends AuthStates{}
class CreateProviderErrorState extends AuthStates{}

class LoginLoadingState extends AuthStates{}
class LoginSuccessState extends AuthStates{}
class LoginWrongState extends AuthStates{}
class LoginErrorState extends AuthStates{}

class VerifyLoadingState extends AuthStates{}
class VerifySuccessState extends AuthStates{}
class VerifyWrongState extends AuthStates{}
class VerifyErrorState extends AuthStates{}
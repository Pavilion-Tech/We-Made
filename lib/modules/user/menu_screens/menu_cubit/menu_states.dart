abstract class MenuStates{}

class InitState extends MenuStates{}
class ImageWrong extends MenuStates{}
class JustEmitState extends MenuStates{}
class GetCurrentLocationState extends MenuStates{}
class GetCurrentLocationLoadingState extends MenuStates{}

class UpdateProfileLoadingState extends MenuStates{}
class UpdateProfileSuccessState extends MenuStates{}
class UpdateProfileWrongState extends MenuStates{}
class UpdateProfileErrorState extends MenuStates{}

class GetUserSuccessState extends MenuStates {}
class GetUserWrongState extends MenuStates {}
class GetUserErrorState extends MenuStates {}

class GetAddressesSuccessState extends MenuStates {}
class GetAddressesWrongState extends MenuStates {}
class GetAddressesErrorState extends MenuStates {}

class UpdateAddressesLoadingState extends MenuStates {}
class UpdateAddressesSuccessState extends MenuStates {}
class UpdateAddressesWrongState extends MenuStates {}
class UpdateAddressesErrorState extends MenuStates {}

class AllOrderLoadingState extends MenuStates {}
class AllOrderSuccessState extends MenuStates {}
class AllOrderWrongState extends MenuStates {}
class AllOrderErrorState extends MenuStates {}

class SingleOrderSuccessState extends MenuStates {}
class SingleOrderWrongState extends MenuStates {}
class SingleOrderErrorState extends MenuStates {}

class ChatHistorySuccessState extends MenuStates {}
class ChatHistoryWrongState extends MenuStates {}
class ChatHistoryErrorState extends MenuStates {}

class AskRequestLoadingState extends MenuStates{}
class AskRequestSuccessState extends MenuStates{}
class AskRequestWrongState extends MenuStates{}
class AskRequestErrorState extends MenuStates{}

class StaticPageSuccessState extends MenuStates {}
class StaticPageWrongState extends MenuStates {}
class StaticPageErrorState extends MenuStates {}
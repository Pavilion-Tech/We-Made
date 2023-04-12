abstract class UserStates{}
class InitState extends UserStates{}
class EmitState extends UserStates{}
class ChangeIndexState extends UserStates{}


class GetCurrentLocationLoadingState extends UserStates{}
class GetCurrentLocationState extends UserStates{}


class CartSuccessState extends UserStates{}
class CartWrongState extends UserStates{}
class CartErrorState extends UserStates{}

class UpdateCartLoadingState extends UserStates{}
class UpdateCartSuccessState extends UserStates{}
class UpdateCartWrongState extends UserStates{}
class UpdateCartErrorState extends UserStates{}



class DeleteCartLoadingState extends UserStates{}
class DeleteCartSuccessState extends UserStates{}
class DeleteCartWrongState extends UserStates{}
class DeleteCartErrorState extends UserStates{}

class CheckoutLoadingState extends UserStates{}
class CheckoutSuccessState extends UserStates{}
class CheckoutWrongState extends UserStates{}
class CheckoutErrorState extends UserStates{}


class AddCartLoadingState extends UserStates{}
class AddCartSuccessState extends UserStates{}
class AddCartWrongState extends UserStates{}
class AddCartErrorState extends UserStates{}

class HomeSuccessState extends UserStates{}
class HomeWrongState extends UserStates{}
class HomeErrorState extends UserStates{}

class GetSearchLoadingState extends UserStates{}
class GetSearchSuccessState extends UserStates{}
class GetSearchWrongState extends UserStates{}
class GetSearchErrorState extends UserStates{}

class CategoryLoadingState extends UserStates{}
class CategorySuccessState extends UserStates{}
class CategoryWrongState extends UserStates{}
class CategoryErrorState extends UserStates{}

class AddFavLoadingState extends UserStates{}
class GetFavLoadingState extends UserStates{}
class GetFavSuccessState extends UserStates{}
class GetFavWrongState extends UserStates{}
class GetFavErrorState extends UserStates{}

class ProviderProductsLoadingState extends UserStates{}
class ProviderProductsSuccessState extends UserStates{}
class ProviderProductsWrongState extends UserStates{}
class ProviderProductsErrorState extends UserStates{}

class CouponLoadingState extends UserStates{}
class CouponSuccessState extends UserStates{}
class CouponWrongState extends UserStates{}
class CouponErrorState extends UserStates{}
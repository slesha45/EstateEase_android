import 'package:final_assignment/app/navigator/navigator.dart';

import 'package:final_assignment/features/single_property/presentation/view/single_property_view.dart';
 
class SinglePropertyViewNavigator{}
 
mixin SinglePropertyViewRoute{
  void navigateToSinglePropertyView(){
    NavigateRoute.pushRoute(const SinglePropertyView( propertyId: '',));
  }
 
}
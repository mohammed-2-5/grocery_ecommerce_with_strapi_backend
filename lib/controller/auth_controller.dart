import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:grocery_ecommerce/core/services/remote_services/auth_services.dart';
import 'package:grocery_ecommerce/model/user_model.dart';

import '../core/services/local_services/local_services.dart';
import '../core/services/remote_services/api_services.dart';

class AuthController extends GetxController {

  static AuthController instance = Get.find();
  RxBool isLoggedIn = false.obs;
  Rxn<User> user = Rxn<User>();
  LocalServices localServices = LocalServices();

  @override
  void onInit() async {
    await localServices.init();

    super.onInit();
  }
  void signUp({required String fullName, required String email, required String password}) async {
    try {
      EasyLoading.show(status: 'Loading...', dismissOnTap: false);

      // Call the signUp API and get the response
      final result = await AuthServices().signUp(email: email, password: password);

      print("SignUp Response Status Code: ${result.statusCode}");
      print("SignUp Response Body: ${result.data}");

      if (result.statusCode == 200 || result.statusCode == 201) {
        // Ensure token extraction is correct
        String token = result.data['jwt'];
        print("Extracted Token: $token");

        // Call the createProfile API
        final userResult = await AuthServices().createProfile(fullName: fullName, token: token);

        print("Create Profile Response Status Code: ${userResult.statusCode}");
        print("Create Profile Response Body: ${userResult.data}");

        if (userResult.statusCode == 200) {
          user.value = User.fromJson(userResult.data);
          await localServices.addToken(token: token);
          await localServices.addUser(user: user.value!);

          EasyLoading.showSuccess("Welcome to MyGrocery!");
          Navigator.of(Get.overlayContext!).pop();
        } else {
          EasyLoading.showError('Something went wrong. Try again!');
        }
      } else {
        EasyLoading.showError('Something went wrong. Try again!');
      }
    } catch (e) {
      EasyLoading.showError('Something went wrong. Try again!');
      print("Error in SignUp: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  void signIn({required String email, required String password}) async {
    try {
      // Show loading indicator
      EasyLoading.show(
        status: 'Loading...',
        dismissOnTap: false,
      );

      // Step 1: Call the sign-in API
      var result = await AuthServices().signIn(
        email: email,
        password: password,
      );

      // Step 2: Check the response status code
      if (result.statusCode == 200) {
        // Step 3: Extract the token from the response
        String token = result.data['jwt']; // Using 'data' instead of 'body'

        // Step 4: Call the getProfile API to fetch user details
        var userResult = await AuthServices().getProfile(token: token);

        // Step 5: Check the response status code for getProfile
        if (userResult.statusCode == 200) {
          // Parse the user data into a model
          user.value = userFromJson(userResult.data); // Use 'data' instead of 'body'

          // Step 6: Store the token and user details locally
          await localServices.addToken(token: token);
          await localServices.addUser(user: user.value!);

          // Step 7: Show success message and navigate back
          EasyLoading.showSuccess("Welcome to MyGrocery!");
          Navigator.of(Get.overlayContext!).pop();
        } else {
          // Show error if profile fetch fails
          EasyLoading.showError('Failed to fetch user profile. Try again!');
        }
      } else {
        // Show error if sign-in fails
        EasyLoading.showError('Username/password incorrect. Try again!');
      }
    } catch (e) {
      // Step 8: Handle exceptions and print error details
      debugPrint(e.toString());
      EasyLoading.showError('Something went wrong. Please try again!');
    } finally {
      // Step 9: Dismiss the loading indicator
      EasyLoading.dismiss();
    }
  }


  void signOut() async {
    user.value = null;
    await localServices.clear();
  }
}
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../controller/controller.dart';
import '../../core/const.dart';
import '../auth/sign_in_screen.dart';
import 'account_card.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 20),
          Obx(() => Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 36,
                    child: CircleAvatar(
                      radius: 35,
                      child: authController.user.value?.image == null
                          ? const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.white,
                            )
                          : Builder(
                              builder: (context) {
                                final imageUrl =
                                    authController.user.value!.image!;
                                if (kDebugMode) {
                                  print("Image URL: $imageUrl");
                                } // Debugging: Print the URL

                                return ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: apiUrl + imageUrl,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) {
                                      if (kDebugMode) {
                                        print("Error loading image: $error");
                                      } // Debugging
                                      return const Icon(
                                        Icons.error,
                                        size: 40,
                                        color: Colors.red,
                                      );
                                    },
                                    fit: BoxFit.cover,
                                    width: 70,
                                    height: 70,
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authController.user.value?.fullName ??
                            "Sign in your account",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                ],
              )),
          const SizedBox(height: 50),
          AccountCard(
              title: "Profile Info",
              onClick: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()));
              }),
          AccountCard(title: "Notification", onClick: () {}),
          AccountCard(title: "Settings", onClick: () {}),
          AccountCard(title: "About Us", onClick: () {}),
          AccountCard(title: "Terms of Service", onClick: () {}),
          Obx(() => AccountCard(
              title: authController.user.value == null ? "Sign In" : "Sign Out",
              onClick: () {
                if (authController.user.value != null) {
                  authController.signOut();
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()));
                }
              }))
        ],
      ),
    );
  }
}

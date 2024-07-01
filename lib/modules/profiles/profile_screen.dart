import 'package:cvscreen/models/user/user.dart';
import 'package:cvscreen/shared/components/components.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.userModel,
  });
  final User userModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              signOut(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 64.0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: const CircleAvatar(
                radius: 60.0,
                backgroundImage: NetworkImage(
                  'https://fakestoreapi.com/icons/logo.png',
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              userModel.username ?? 'no user name',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'User Data',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        buildItem(
                          context,
                          'firstname: ',
                          userModel.name?.firstname,
                          'no name',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        buildItem(
                          context,
                          'lastname: ',
                          userModel.name?.lastname,
                          'no name',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        buildItem(
                          context,
                          'email: ',
                          userModel.email,
                          'no email',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        buildItem(
                          context,
                          'phone: ',
                          userModel.phone,
                          'no phone',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'User Address',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        buildItem(
                          context,
                          'city: ',
                          userModel.address?.city,
                          'no city',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        buildItem(
                          context,
                          'street: ',
                          userModel.address?.street,
                          'no street',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        buildItem(
                          context,
                          'number: ',
                          userModel.address?.number.toString(),
                          'no number',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        buildItem(
                          context,
                          'zipcode: ',
                          userModel.address?.zipcode,
                          'no zipcode',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItem(context, firstPart, model, lastPart) => Row(
        children: [
          Text(
            firstPart,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            model ?? lastPart,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      );
}

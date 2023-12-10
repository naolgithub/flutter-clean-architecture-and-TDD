import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/agify_bloc.dart';
import '../bloc/agify_event.dart';
import '../bloc/agify_state.dart';

class AgifyPage extends StatelessWidget {
  const AgifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1D1E22),
        title: const Text(
          'Agify',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Enter agified name',
                fillColor: const Color(0xffF3F3F3),
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (query) {
                context.read<AgifyBloc>().add(OnNameChanged(query));
              },
            ),
            const SizedBox(height: 32.0),
            BlocBuilder<AgifyBloc, AgifyState>(
              builder: (context, state) {
                if (state is AgifyLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is AgifyLoaded) {
                  return Column(
                    key: const Key('Agify_data'),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Agified Name :',
                            style: TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            state.result.name,
                            style: const TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                          // Image(
                          //   image: NetworkImage(
                          //     Urls.AgifyIcon(
                          //       state.result.iconCode,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      // const SizedBox(height: 8.0),
                      // Text(
                      //   // '${state.result.main} | ${state.result.description}',
                      //   state.result.name,
                      //   style: const TextStyle(
                      //     fontSize: 16.0,
                      //     letterSpacing: 1.2,
                      //   ),
                      // ),
                      const SizedBox(height: 24.0),
                      Table(
                        defaultColumnWidth: const FixedColumnWidth(150.0),
                        border: TableBorder.all(
                          // color: Colors.grey,
                          color: Colors.cyan,
                          style: BorderStyle.solid,
                          // width: 1,
                          width: 1,
                        ),
                        children: [
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Agified Name',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  state.result.name.toString(),
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ), // Will be change later
                            ],
                          ),
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Agified Age',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  state.result.age.toString(),
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ), // Will be change later
                            ],
                          ),
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Agified Count',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  state.result.count.toString(),
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ), // Will be change later
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                }
                if (state is AgifyLoadFailure) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}

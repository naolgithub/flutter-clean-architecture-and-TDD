import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/country_data_bloc.dart';
import '../bloc/country_data_event.dart';
import '../bloc/country_data_state.dart';

class CountryDataPage extends StatefulWidget {
  const CountryDataPage({super.key});

  @override
  State<CountryDataPage> createState() => _CountryDataPageState();
}

class _CountryDataPageState extends State<CountryDataPage> {
  final contoller = TextEditingController();
  late String inputStr;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1D1E22),
        title: const Text(
          'Country Data',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: contoller,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter country name',
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
                  inputStr = query;
                  context.read<CountryDataBloc>().add(OnCountryChanged(query));
                },
                onSubmitted: (query) {
                  // context.read<CountryDataBloc>().add(OnCountryChanged(query));
                  contoller.text.isNotEmpty ? addWeather() : null;
                },
              ),
              const SizedBox(height: 32.0),
              BlocBuilder<CountryDataBloc, CountryDataState>(
                builder: (context, state) {
                  if (state is CountryDataLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is CountryDataLoaded) {
                    return Column(
                      key: const Key('CountryData_data'),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.result.commonName,
                              style: const TextStyle(
                                fontSize: 22.0,
                              ),
                            ),
                            const SizedBox(
                              width: 130,
                            ),
                            Text(
                              state.result.flag,
                              style: const TextStyle(
                                fontSize: 28.0,
                              ),
                            ),
                            // Image(
                            //   image: NetworkImage(
                            //     Urls.CountryDataIcon(
                            //       state.result.iconCode,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          state.result.officialName,
                          style: const TextStyle(
                            fontSize: 16.0,
                            letterSpacing: 1.2,
                          ),
                        ),
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
                                    'Status',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    state.result.status.toString(),
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      letterSpacing: 1.2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Capital City',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    state.result.capitalCity.toString(),
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
                                    'Independent',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    state.result.independent.toString(),
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
                                    'Un member',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    state.result.unMember.toString(),
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
                                    'Region',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    state.result.region.toString(),
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
                                    'Subregion',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    state.result.subregion.toString(),
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
                                    'Time Zone',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    state.result.timeZone.toString(),
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
                                    'Start of week',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    state.result.startOfWeek.toString(),
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
                                    'Latitude',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    state.result.latitude.toString(),
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
                                    'Longitude',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    state.result.longitude.toString(),
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
                                    'Population',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    state.result.population.toString(),
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
                                    'Landlocked',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    state.result.landLocked.toString(),
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
                                    'Area',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    state.result.area.toString(),
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      letterSpacing: 1.2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ), // Will be change later
                              ],
                            ),

                            //
                          ],
                        ),
                      ],
                    );
                  }
                  if (state is CountryDataLoadFailure) {
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
      ),
    );
  }

  void addWeather() {
    contoller.clear();
    BlocProvider.of<CountryDataBloc>(context).add(OnCountryChanged(inputStr));
  }
}

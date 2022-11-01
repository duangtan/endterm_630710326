import 'package:endterm_630710326/models/country.dart';
import 'package:endterm_630710326/pages/VoteResultPage/voteresultpage.dart';
import 'package:endterm_630710326/services/api.dart';
import 'package:flutter/material.dart';

class VoteHomePage extends StatefulWidget {
  const VoteHomePage({Key? key}) : super(key: key);

  @override
  State<VoteHomePage> createState() => _VoteHomePageState();
}

class _VoteHomePageState extends State<VoteHomePage> {
  List<Country>? _countryList;
  var _isLoading = false;
  String? _errMessage;
  void handleClickViewResult(){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context)=>const VoteResultPage()
        )
    );
  }
  @override
  void initState() {
    super.initState();
    _fetchCountryData();
  }
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: //Image.asset('assets/images/bg.png',height: 50,width: 150,),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/logo.jpg',height: 100),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  //Stack(
                  //children: [
                  if (_countryList != null)
                    ListView.builder(
                      itemBuilder: _buildListItem,
                      itemCount: _countryList!.length,
                    ),
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator()),
                  if (_errMessage != null && !_isLoading)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Text(_errMessage!),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _fetchCountryData();
                            },
                            child: const Text('RETRY'),
                          )
                        ],
                      ),
                    ),
                  //],
                  //),
                ],
              ),

              /*Expanded(
                child:
                Stack(
                  children: [
                    if (_countryList != null)
                      ListView.builder(
                        itemBuilder: _buildListItem,
                        itemCount: _countryList!.length,
                      ),
                    if (_isLoading)
                      const Center(child: CircularProgressIndicator()),
                    if (_errMessage != null && !_isLoading)
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Text(_errMessage!),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _fetchCountryData();
                              },
                              child: const Text('RETRY'),
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),*/
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: handleClickViewResult,
                    style: ElevatedButton.styleFrom(
                      primary:Colors.white,
                      minimumSize: Size(0,55),
                    ),
                    child: const Text('VIEW RESULT',style: TextStyle(color: Colors.redAccent),),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

    );
  }
  void _fetchCountryData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var data = await Api().fetch('');
      setState(() {
        _countryList = data
            .map<Country>((item) => Country.fromJson(item))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Widget _buildListItem(BuildContext context, int index) {
    var Country = _countryList![index];
    return Card(
        child: Row(
          children: [
            Image.network(
              'http://103.74.252.66:8888'+Country.flagImage,
              width: 20.0,
              height: 20.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8.0),
            Text(Country.team),
          ],
        ),

    );

  }
}

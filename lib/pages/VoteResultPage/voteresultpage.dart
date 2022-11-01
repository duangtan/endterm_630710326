import 'package:endterm_630710326/models/country.dart';
import 'package:endterm_630710326/pages/world%20cup%20home/world_cup_home.dart';
import 'package:endterm_630710326/services/api.dart';
import 'package:flutter/material.dart';

class VoteResultPage extends StatefulWidget {
  const VoteResultPage({Key? key}) : super(key: key);

  @override
  State<VoteResultPage> createState() => _VoteResultPageState();
}

class _VoteResultPageState extends State<VoteResultPage> {
  List<Country>? _countryList;
  var _isLoading = false;
  String? _errMessage;
  void handleClickHome(){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context)=>const VoteHomePage()
        )
    );
  }
  @override
  void initState() {
    super.initState();
    _fetchCountryData();
  }
  Widget build(BuildContext context) {
    return
    Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: handleClickHome,
              child: Icon(Icons.arrow_back)),
          title: Text('VOTE RESULT'),
        ),

    //backgroundColor: Colors.black,
    body: Stack(
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
                  )
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
            width: 50.0,
            height: 30.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 8.0),
          //Column(
            //children: [
              Text(Country.team),
              //Text('GROUP '+Country.group),
            //],
          //),

        ],
      ),

    );

  }
}

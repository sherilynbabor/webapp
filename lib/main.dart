import 'package:flutter/material.dart';

void main() {
  runApp(Agriyouwebapp());
}

class Agriyouwebapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AGRIYOU',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomePage(),
    );
  }
}

//
// ============================
// HOME PAGE
// ============================
//
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/logo.png"),
            fit: BoxFit.cover,
            opacity: 0.25,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "AGRIYOU",
                style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                "Smart Crop Timeline Assistant",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  backgroundColor: Colors.green.shade700,
                ),
                child: Text("Get Started", style: TextStyle(fontSize: 18)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AgriYouHome()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
// ============================
// MAIN AGRIYOU PAGE
// ============================
//
class AgriYouHome extends StatefulWidget {
  @override
  _AgriYouHomeState createState() => _AgriYouHomeState();
}

class _AgriYouHomeState extends State<AgriYouHome> {
  String? selected;
  String region = "";
  String timelineText = '';

  final Map<String, Map<String, String>> crops = {
    'rice': {
      'name': 'Rice',
      'total': '100–120 days',
      'timeline': '🌾 RICE TIMELINE\n\n'
          '1. Land Prep – 1 week\n'
          '2. Seedling – 7–14 days\n'
          '3. Vegetative – 30–45 days\n'
          '4. Reproductive – 30 days\n'
          '5. Ripening – 30 days\n\n'
          'Recommendations:\n• Level fields.\n• Maintain water depth.',
      'image': 'assets/rice.jpg'
    },
    'corn': {
      'name': 'Corn',
      'total': '90–100 days',
      'timeline': '🌽 CORN TIMELINE\n\n'
          '1. Germination – 7 days\n'
          '2. Seedling – 14 days\n'
          '3. Vegetative – 30 days\n'
          '4. Pollination – 10–14 days\n'
          '5. Maturity – 30 days',
      'image': 'assets/corn.jpg'
    },
    'tomato': {
      'name': 'Tomato',
      'total': '60–85 days',
      'timeline': '🍅 TOMATO TIMELINE\n\n'
          '1. Germination – 7–14 days\n'
          '2. Seedling – 4–6 weeks\n'
          '3. Flowering – 2 weeks\n'
          '4. Fruiting – 3–4 weeks',
      'image': 'assets/tomato.jpg'
    },
    'eggplant': {
      'name': 'Eggplant',
      'total': '100–140 days',
      'timeline': '🍆 EGGPLANT TIMELINE\n\n'
          '1. Germination – 7–14 days\n'
          '2. Seedling – 3–4 weeks\n'
          '3. Vegetative – 40–60 days\n'
          '4. Flowering – 15 days\n'
          '5. Harvest – 20–40 days',
      'image': 'assets/egg.jpg'
    },
    'potato': {
      'name': 'Potato',
      'total': '70–120 days',
      'timeline': '🥔 POTATO TIMELINE\n\n'
          '1. Sprouting – 10–14 days\n'
          '2. Vegetative – 30–40 days\n'
          '3. Tuber Formation – 20–30 days\n'
          '4. Maturation – 20–40 days',
      'image': 'assets/potato.jpg'
    },
    'carrots': {
      'name': 'Carrots',
      'total': '70–90 days',
      'timeline': '🥕 CARROT TIMELINE\n\n'
          '1. Germination – 10–20 days\n'
          '2. Early Growth – 3–4 weeks\n'
          '3. Root Development – 4–6 weeks\n'
          '4. Maturation – 2–3 weeks',
      'image': 'assets/carrot.jpg'
    },
  };

  void showTimeline() {
    if (selected == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please select a crop.')));
      return;
    }

    var item = crops[selected]!;
    var text = item['timeline']!;
    if (region.trim().isNotEmpty) text += '\n\nRegion / notes: $region';

    setState(() => timelineText = text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Crop Timeline")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: LayoutBuilder(builder: (context, size) {
          bool narrow = size.maxWidth < 700;

          return narrow
              ? SingleChildScrollView(child: Column(children: buildInputs()))
              : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Column(children: buildInputs())),
              SizedBox(width: 16),
              SizedBox(width: 350, child: previewCard()),
            ],
          );
        }),
      ),
    );
  }

  List<Widget> buildInputs() {
    return [
      Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(children: [
            DropdownButtonFormField<String>(
              value: selected,
              onChanged: (v) => setState(() {
                selected = v;
                timelineText = '';
              }),
              decoration: InputDecoration(labelText: "Select crop"),
              items: crops.entries
                  .map((e) =>
                  DropdownMenuItem(value: e.key, child: Text(e.value['name']!)))
                  .toList(),
            ),
            SizedBox(height: 12),
            TextFormField(
              decoration:
              InputDecoration(labelText: "Region / notes (optional)"),
              onChanged: (v) => region = v,
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: showTimeline,
              child: Text("Show Timeline"),
            ),
            SizedBox(height: 12),
            Container(
              height: 260,
              child: SingleChildScrollView(
                child: Text(
                  timelineText.isEmpty
                      ? "Timeline will appear here..."
                      : timelineText,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            )
          ]),
        ),
      ),
    ];
  }

  Widget previewCard() {
    String img = "assets/logo.png";
    String name = "No crop selected";
    String total = "";

    if (selected != null) {
      img = crops[selected]!['image']!;
      name = crops[selected]!['name']!;
      total = crops[selected]!['total']!;
    }

    return Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              img,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 220,
                color: Colors.grey[200],
                child: Center(child: Text("No image")),
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(name,
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(total, style: TextStyle(color: Colors.grey[700])),
              ]),
              Text("AGRIYOU", style: TextStyle(color: Colors.green)),
            ],
          )
        ]),
      ),
    );
  }
}




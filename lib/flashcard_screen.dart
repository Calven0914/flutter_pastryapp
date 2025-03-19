import 'package:flutter/material.dart';

class FlashcardScreen extends StatefulWidget {
  final String pastry;
  const FlashcardScreen({Key? key, required this.pastry}) : super(key: key);

  @override
  _FlashcardScreenState createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  final Map<String, List<String>> pastrySteps = {
      'Croissant': [
    'Step 1: Mix 250g flour, 10g sugar, 5g salt, and 10g yeast in a bowl.',
    'Step 2: Add 100ml water and 50g melted butter. Knead until smooth.',
    'Step 3: Let the dough rest for 1 hour to rise.',
    'Step 4: Roll the dough and fold in 150g cold butter.',
    'Step 5: Shape the dough into croissants and let rest for 30 minutes.',
    'Step 6: Bake at 180°C for 15-20 minutes.',
    'Enjoy your Croissant!',
  ],
  'Baguette': [
    'Step 1: Mix 500g flour, 10g salt, and 5g dry yeast in a large bowl.',
    'Step 2: Add 350ml water and knead until the dough is smooth.',
    'Step 3: Let the dough rise for 1 hour, then punch it down and shape it.',
    'Step 4: Allow the dough to rest for 30 minutes before baking.',
    'Step 5: Score the top of the dough and bake at 220°C for 25-30 minutes.',
    'Enjoy your Baguette!',
  ],
  'Macaron': [
    'Step 1: Whisk 110g egg whites and 30g sugar until stiff peaks form.',
    'Step 2: Sift 200g powdered sugar and 125g almond flour into the egg whites.',
    'Step 3: Gently fold the mixture until smooth, then pipe into circles on a baking tray.',
    'Step 4: Let the macaron shells rest for 30 minutes.',
    'Step 5: Bake at 150°C for 15-20 minutes, then let cool completely.',
    'Step 6: Sandwich with your favorite filling (e.g., buttercream, ganache).',
    'Enjoy your Macaron!',
  ],
  'Donut': [
    'Step 1: Mix 500g flour, 10g salt, 60g sugar, 10g yeast, and 200ml milk in a bowl.',
    'Step 2: Add 2 eggs and 50g melted butter, then knead until smooth.',
    'Step 3: Let the dough rise for 1 hour.',
    'Step 4: Roll out the dough and cut out donut shapes.',
    'Step 5: Fry at 180°C for 2-3 minutes on each side.',
    'Step 6: Coat with powdered sugar or glaze.',
    'Enjoy your Donut!',
  ],
  'Apple Pie': [
    'Step 1: Prepare the crust with 300g flour, 150g butter, and 80g sugar.',
    'Step 2: Roll out the dough and place it in a pie dish.',
    'Step 3: Slice 5 apples, toss with 100g sugar, 1 tsp cinnamon, and 1 tbsp lemon juice.',
    'Step 4: Fill the crust with apple mixture and cover with another dough layer.',
    'Step 5: Bake at 180°C for 40 minutes.',
    'Enjoy your Apple Pie!',
  ],
  'Brownie': [
    'Step 1: Melt 200g dark chocolate and 100g butter together.',
    'Step 2: Whisk 2 eggs and 200g sugar until light and fluffy.',
    'Step 3: Add the melted chocolate and 100g flour to the egg mixture.',
    'Step 4: Pour into a baking tin and bake at 180°C for 20-25 minutes.',
    'Enjoy your Brownie!',
  ],
  'Castagnole': [
    'Step 1: Mix 250g flour, 100g sugar, 1 egg, and 50g butter in a bowl.',
    'Step 2: Add 1 tsp of vanilla extract and 10g yeast.',
    'Step 3: Shape into small balls and fry at 170°C for 3-4 minutes.',
    'Step 4: Roll in sugar and serve.',
    'Enjoy your Castagnole!',
  ],
  'Cannoli': [
    'Step 1: Mix 250g flour, 50g sugar, 1 egg, 30g butter, and a pinch of salt.',
    'Step 2: Roll out the dough and cut into circles, then roll around cannoli tubes.',
    'Step 3: Fry at 180°C for 3-4 minutes.',
    'Step 4: Fill with ricotta cheese and powdered sugar mixture.',
    'Step 5: Dust with powdered sugar.',
    'Enjoy your Cannoli!',
  ],
  'Sfogliatelle': [
    'Step 1: Mix 300g flour, 50g butter, and a pinch of salt.',
    'Step 2: Add 100ml water and knead until smooth.',
    'Step 3: Roll the dough and fold multiple layers to create thin sheets.',
    'Step 4: Fill with ricotta, candied fruit, and sugar.',
    'Step 5: Bake at 200°C for 20 minutes.',
    'Enjoy your Sfogliatelle!',
  ],
  'Mocha Roll': [
    'Step 1: Prepare the chocolate batter by mixing 200g flour, 100g cocoa powder, and 100g sugar.',
    'Step 2: Add 4 eggs and 100g butter, then mix until smooth.',
    'Step 3: Bake at 180°C for 12-15 minutes.',
    'Step 4: Roll while still warm with whipped cream or filling.',
    'Enjoy your Mocha Roll!',
  ],
  'Anpan': [
    'Step 1: Prepare the dough by mixing 500g flour, 50g sugar, 10g yeast, and 300ml warm water.',
    'Step 2: Add 1 egg and knead until smooth.',
    'Step 3: Divide into balls, stuff with red bean paste, and shape into rolls.',
    'Step 4: Bake at 180°C for 20 minutes.',
    'Enjoy your Anpan!',
  ],
  'Taiyaki': [
    'Step 1: Make the batter by mixing 250g flour, 50g sugar, and 1 egg.',
    'Step 2: Pour batter into Taiyaki molds and add red bean paste or custard.',
    'Step 3: Close the molds and fry until golden brown.',
    'Enjoy your Taiyaki!',
  ],
    // Extra pastry for future
  };

  final Map<String, String> pastryImages = {
    'Croissant': 'images/crois.jpg',
    'Baguette': 'images/bagu.jpg',
    'Macaron': 'images/maca.jpg',
    'Mocha Roll': 'images/macha.jpeg',
    'Donut': 'images/donut.jpg',
    'Apple Pie': 'images/applepie.jpg',
    'Brownie': 'images/brownie.jpg',
    'Castagnole': 'images/castagnole.jpg',
    'Cannoli': 'images/cannoli.jpg',
    'Sfogliatelle': 'images/sfo.jpg',
    'Anpan': 'images/anpan.jpg',
    'Taiyaki': 'images/taiyaki.jpg',
  };

  late List<String> steps;
  int currentStepIndex = 0;

  @override
  void initState() {
    super.initState();
    steps = pastrySteps[widget.pastry] ?? [];
  }

  void _nextStep() {
    if (currentStepIndex < steps.length - 1) {
      setState(() {
        currentStepIndex++;
      });
    }
  }

  void _prevStep() {
    if (currentStepIndex > 0) {
      setState(() {
        currentStepIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = pastryImages[widget.pastry] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Cooking ${widget.pastry}'),
      ),
      body: steps.isEmpty
          ? Center(
              child: Text(
                'No steps available for ${widget.pastry}.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
              ),
            )
          : Column(
              children: [
                imageUrl.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          // Add your image zoom functionality here
                        },
                        child: Image.asset(
                          imageUrl,
                          height: 250,
                          width: 250,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const SizedBox(height: 250),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Text(
                        'Step ${currentStepIndex + 1}:',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 28),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        steps[currentStepIndex],
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Step progress indicator
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: LinearProgressIndicator(
                    value: (currentStepIndex + 1) / steps.length,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _prevStep,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        textStyle: TextStyle(fontSize: 20),
                      ),
                      child: const Text('Previous'),
                    ),
                    ElevatedButton(
                      onPressed: _nextStep,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        textStyle: TextStyle(fontSize: 20),
                      ),
                      child: const Text('Next'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
    );
  }
}

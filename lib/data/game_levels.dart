import 'dart:math';
import 'package:recycle_game/models/recyclable_item.dart';

class GameLevel {
  final int timeLimit; // in seconds
  final List<RecyclableItem> items;

  GameLevel({required this.timeLimit, required this.items});
}

// Tüm kullanılabilir item havuzu (asset dosyalarına göre)
final List<RecyclableItem> allItems = [
  // Paper
  RecyclableItem(name: 'Wedding Invitation', imagePath: 'assets/images/wastes/paper/wedding_invitation.png', type: 'paper'),
  RecyclableItem(name: 'Origami', imagePath: 'assets/images/wastes/paper/origami.png', type: 'paper'),
  RecyclableItem(name: 'Handkerchief', imagePath: 'assets/images/wastes/paper/handkerchief.png', type: 'paper'),
  RecyclableItem(name: 'Paper Carton', imagePath: 'assets/images/wastes/paper/paper_carton.png', type: 'paper'),
  RecyclableItem(name: 'Flyer', imagePath: 'assets/images/wastes/paper/flyer.png', type: 'paper'),
  RecyclableItem(name: 'Paper Map', imagePath: 'assets/images/wastes/paper/paper_map.png', type: 'paper'),
  RecyclableItem(name: 'Paper Poster', imagePath: 'assets/images/wastes/paper/paper_poster.png', type: 'paper'),
  RecyclableItem(name: 'Paper Receipt', imagePath: 'assets/images/wastes/paper/paper_receipt.png', type: 'paper'),
  RecyclableItem(name: 'Paper Packaging', imagePath: 'assets/images/wastes/paper/paper_packaging.png', type: 'paper'),
  RecyclableItem(name: 'Paper Cup', imagePath: 'assets/images/wastes/paper/paper_cup.png', type: 'paper'),
  RecyclableItem(name: 'Sticky Note', imagePath: 'assets/images/wastes/paper/sticky_note.png', type: 'paper'),
  RecyclableItem(name: 'Paper Towel', imagePath: 'assets/images/wastes/paper/paper_towel.png', type: 'paper'),
  RecyclableItem(name: 'Envelope', imagePath: 'assets/images/wastes/paper/envelope.png', type: 'paper'),
  RecyclableItem(name: 'Brochure', imagePath: 'assets/images/wastes/paper/brochure.png', type: 'paper'),
  RecyclableItem(name: 'Paper Bag', imagePath: 'assets/images/wastes/paper/paper_bag.png', type: 'paper'),
  RecyclableItem(name: 'Package', imagePath: 'assets/images/wastes/paper/package.png', type: 'paper'),
  RecyclableItem(name: 'Notebook', imagePath: 'assets/images/wastes/paper/notebook.png', type: 'paper'),
  RecyclableItem(name: 'Book', imagePath: 'assets/images/wastes/paper/book.png', type: 'paper'),
  RecyclableItem(name: 'Magazine', imagePath: 'assets/images/wastes/paper/magazine.png', type: 'paper'),
  RecyclableItem(name: 'Newspaper', imagePath: 'assets/images/wastes/paper/newspaper.png', type: 'paper'),
  // Plastic
  RecyclableItem(name: 'Plastic Flower', imagePath: 'assets/images/wastes/plastic/plastic_flower.png', type: 'plastic'),
  RecyclableItem(name: 'Plastic Tape', imagePath: 'assets/images/wastes/plastic/plastic_tape.png', type: 'plastic'),
  RecyclableItem(name: 'Plastic Folder', imagePath: 'assets/images/wastes/plastic/plastic_folder.png', type: 'plastic'),
  RecyclableItem(name: 'Plastic Coaster', imagePath: 'assets/images/wastes/plastic/plastic_coaster.png', type: 'plastic'),
  RecyclableItem(name: 'Plastic Container 1', imagePath: 'assets/images/wastes/plastic/plastic_container_1.png', type: 'plastic'),
  RecyclableItem(name: 'Plastic Shampoo', imagePath: 'assets/images/wastes/plastic/plastic_shampoo.png', type: 'plastic'),
  RecyclableItem(name: 'Plastic Jam', imagePath: 'assets/images/wastes/plastic/plastic_jam.png', type: 'plastic'),
  RecyclableItem(name: 'Plastic Detergent', imagePath: 'assets/images/wastes/plastic/plastic_detergent.png', type: 'plastic'),
  RecyclableItem(name: 'Plastic Straw', imagePath: 'assets/images/wastes/plastic/plastic_straw.png', type: 'plastic'),
  RecyclableItem(name: 'Plastic Knife', imagePath: 'assets/images/wastes/plastic/plastic_knife.png', type: 'plastic'),
  RecyclableItem(name: 'Plastic Spoon', imagePath: 'assets/images/wastes/plastic/plastic_spoon.png', type: 'plastic'),
  RecyclableItem(name: 'Plastic Fork', imagePath: 'assets/images/wastes/plastic/plastic_fork.png', type: 'plastic'),
  RecyclableItem(name: 'Plastic Container', imagePath: 'assets/images/wastes/plastic/plastic_container.png', type: 'plastic'),
  RecyclableItem(name: 'Plastic Rubber', imagePath: 'assets/images/wastes/plastic/plastic_rubber.png', type: 'plastic'),
  RecyclableItem(name: 'Plastic Water Gun', imagePath: 'assets/images/wastes/plastic/plastic_water_gun.png', type: 'plastic'),
  RecyclableItem(name: 'Plastic Bucket', imagePath: 'assets/images/wastes/plastic/plastic_bucket.png', type: 'plastic'),
  RecyclableItem(name: 'Plastic Cap', imagePath: 'assets/images/wastes/plastic/plastic_cap.png', type: 'plastic'),
  RecyclableItem(name: 'Plastic Bag', imagePath: 'assets/images/wastes/plastic/plastic_bag.png', type: 'plastic'),
  RecyclableItem(name: 'Plastic Cup', imagePath: 'assets/images/wastes/plastic/plastic_cup.png', type: 'plastic'),
  RecyclableItem(name: 'Plastic Bottle', imagePath: 'assets/images/wastes/plastic/plastic_bottle.png', type: 'plastic'),
  // Glass
  RecyclableItem(name: 'Glass Perfume', imagePath: 'assets/images/wastes/glass/glass_perfume.png', type: 'glass'),
  RecyclableItem(name: 'Glass Ashtray', imagePath: 'assets/images/wastes/glass/glass_ashtray.png', type: 'glass'),
  RecyclableItem(name: 'Glass Teapot', imagePath: 'assets/images/wastes/glass/glass_teapot.png', type: 'glass'),
  RecyclableItem(name: 'Glass Candy Bowl', imagePath: 'assets/images/wastes/glass/glass_candy_bowl.png', type: 'glass'),
  RecyclableItem(name: 'Glass Jug 1', imagePath: 'assets/images/wastes/glass/glass_jug_1.png', type: 'glass'),
  RecyclableItem(name: 'Glass Lid', imagePath: 'assets/images/wastes/glass/glass_lid.png', type: 'glass'),
  RecyclableItem(name: 'Glass Dome', imagePath: 'assets/images/wastes/glass/glass_dome.png', type: 'glass'),
  RecyclableItem(name: 'Glass Balloon', imagePath: 'assets/images/wastes/glass/glass_balloon.png', type: 'glass'),
  RecyclableItem(name: 'Glass Decoration', imagePath: 'assets/images/wastes/glass/glass_decoration.png', type: 'glass'),
  RecyclableItem(name: 'Glass Mug', imagePath: 'assets/images/wastes/glass/glass_mug.png', type: 'glass'),
  RecyclableItem(name: 'Glass Cup', imagePath: 'assets/images/wastes/glass/glass_cup.png', type: 'glass'),
  RecyclableItem(name: 'Glass Tube', imagePath: 'assets/images/wastes/glass/glass_tube.png', type: 'glass'),
  RecyclableItem(name: 'Glass Frame', imagePath: 'assets/images/wastes/glass/glass_frame.png', type: 'glass'),
  RecyclableItem(name: 'Glass Lamp', imagePath: 'assets/images/wastes/glass/glass_lamp.png', type: 'glass'),
  RecyclableItem(name: 'Glass Bowl', imagePath: 'assets/images/wastes/glass/glass_bowl.png', type: 'glass'),
  RecyclableItem(name: 'Glass Jug', imagePath: 'assets/images/wastes/glass/glass_jug.png', type: 'glass'),
  RecyclableItem(name: 'Glass Vase', imagePath: 'assets/images/wastes/glass/glass_vase.png', type: 'glass'),
  RecyclableItem(name: 'Glass Plate', imagePath: 'assets/images/wastes/glass/glass_plate.png', type: 'glass'),
  RecyclableItem(name: 'Glass Jar', imagePath: 'assets/images/wastes/glass/glass_jar.png', type: 'glass'),
  RecyclableItem(name: 'Glass Bottle', imagePath: 'assets/images/wastes/glass/glass_bottle.png', type: 'glass'),
  // Metal
  RecyclableItem(name: 'Metal Scissors', imagePath: 'assets/images/wastes/metal/metal_scissors.png', type: 'metal'),
  RecyclableItem(name: 'Metal Screw 1', imagePath: 'assets/images/wastes/metal/metal_screw_1.png', type: 'metal'),
  RecyclableItem(name: 'Metal Screw', imagePath: 'assets/images/wastes/metal/metal_screw.png', type: 'metal'),
  RecyclableItem(name: 'Metal Nail', imagePath: 'assets/images/wastes/metal/metal_nail.png', type: 'metal'),
  RecyclableItem(name: 'Metal Hanger', imagePath: 'assets/images/wastes/metal/metal_hanger.png', type: 'metal'),
  RecyclableItem(name: 'Metal Toy', imagePath: 'assets/images/wastes/metal/metal_toy.png', type: 'metal'),
  RecyclableItem(name: 'Metal Pin', imagePath: 'assets/images/wastes/metal/metal_pin.png', type: 'metal'),
  RecyclableItem(name: 'Metal Chain', imagePath: 'assets/images/wastes/metal/metal_chain.png', type: 'metal'),
  RecyclableItem(name: 'Metal Wire', imagePath: 'assets/images/wastes/metal/metal_wire.png', type: 'metal'),
  RecyclableItem(name: 'Metal Box', imagePath: 'assets/images/wastes/metal/metal_box.png', type: 'metal'),
  RecyclableItem(name: 'Metal Cup', imagePath: 'assets/images/wastes/metal/metal_cup.png', type: 'metal'),
  RecyclableItem(name: 'Metal Plate', imagePath: 'assets/images/wastes/metal/metal_plate.png', type: 'metal'),
  RecyclableItem(name: 'Metal Pot 1', imagePath: 'assets/images/wastes/metal/metal_pot_1.png', type: 'metal'),
  RecyclableItem(name: 'Metal Pot', imagePath: 'assets/images/wastes/metal/metal_pot.png', type: 'metal'),
  RecyclableItem(name: 'Metal Knife', imagePath: 'assets/images/wastes/metal/metal_knife.png', type: 'metal'),
  RecyclableItem(name: 'Metal Fork', imagePath: 'assets/images/wastes/metal/metal_fork.png', type: 'metal'),
  RecyclableItem(name: 'Metal Spoon', imagePath: 'assets/images/wastes/metal/metal_spoon.png', type: 'metal'),
  RecyclableItem(name: 'Metal Lid', imagePath: 'assets/images/wastes/metal/metal_lid.png', type: 'metal'),
  RecyclableItem(name: 'Tin Can', imagePath: 'assets/images/wastes/metal/tin_can.png', type: 'metal'),
  RecyclableItem(name: 'Metal Soda Can', imagePath: 'assets/images/wastes/metal/metal_soda_can.png', type: 'metal'),
  // Organic
  RecyclableItem(name: 'Fruit', imagePath: 'assets/images/wastes/organic/fruit.png', type: 'organic'),
  RecyclableItem(name: 'Peel', imagePath: 'assets/images/wastes/organic/peel.png', type: 'organic'),
  RecyclableItem(name: 'Leaves 1', imagePath: 'assets/images/wastes/organic/leaves_1.png', type: 'organic'),
  RecyclableItem(name: 'Leaves', imagePath: 'assets/images/wastes/organic/leaves.png', type: 'organic'),
  RecyclableItem(name: 'Straw', imagePath: 'assets/images/wastes/organic/straw.png', type: 'organic'),
  RecyclableItem(name: 'Cherry Pit', imagePath: 'assets/images/wastes/organic/cherry_pit.png', type: 'organic'),
  RecyclableItem(name: 'Lettuce Leaf', imagePath: 'assets/images/wastes/organic/lettuce_leaf.png', type: 'organic'),
  RecyclableItem(name: 'Cheese', imagePath: 'assets/images/wastes/organic/cheese.png', type: 'organic'),
  RecyclableItem(name: 'Bread', imagePath: 'assets/images/wastes/organic/bread.png', type: 'organic'),
  RecyclableItem(name: 'Eggshell', imagePath: 'assets/images/wastes/organic/eggshell.png', type: 'organic'),
  RecyclableItem(name: 'Coffee Bean', imagePath: 'assets/images/wastes/organic/coffee_bean.png', type: 'organic'),
  RecyclableItem(name: 'Tea Bag', imagePath: 'assets/images/wastes/organic/tea_bag.png', type: 'organic'),
  RecyclableItem(name: 'Carrot Peel', imagePath: 'assets/images/wastes/organic/carrot_peel.png', type: 'organic'),
  RecyclableItem(name: 'Onion Peel', imagePath: 'assets/images/wastes/organic/onion_peel.png', type: 'organic'),
  RecyclableItem(name: 'Cucumber Peel', imagePath: 'assets/images/wastes/organic/cucumber_peel.png', type: 'organic'),
  RecyclableItem(name: 'Potato Peel', imagePath: 'assets/images/wastes/organic/potato_peel.png', type: 'organic'),
  RecyclableItem(name: 'Apple Peel 1', imagePath: 'assets/images/wastes/organic/apple_peel_1.png', type: 'organic'),
  RecyclableItem(name: 'Apple Peel', imagePath: 'assets/images/wastes/organic/apple_peel.png', type: 'organic'),
  RecyclableItem(name: 'Lemon Peel', imagePath: 'assets/images/wastes/organic/lemon_peel.png', type: 'organic'),
  RecyclableItem(name: 'Banana Peel', imagePath: 'assets/images/wastes/organic/banana_peel.png', type: 'organic'),
];

final List<GameLevel> gameLevels = List.generate(10, (levelIndex) {
  final int itemCount = 10 + levelIndex * 3;
  final int timeLimit = 60 + levelIndex * 15;
  final random = Random(DateTime.now().millisecondsSinceEpoch + levelIndex);
  final items = List<RecyclableItem>.from(allItems)..shuffle(random);
  return GameLevel(
    timeLimit: timeLimit,
    items: items.take(itemCount).toList(),
  );
});
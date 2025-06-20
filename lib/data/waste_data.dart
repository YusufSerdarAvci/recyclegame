import 'package:recycle_game/models/recyclable_item.dart';

final Map<String, List<RecyclableItem>> categorizedWasteItems = {
  'paper': [
    RecyclableItem(name: 'Gazete', imagePath: 'assets/images/wastes/paper/newspaper.png', type: 'paper'),
    RecyclableItem(name: 'Dergi', imagePath: 'assets/images/wastes/paper/magazine.png', type: 'paper'),
    RecyclableItem(name: 'Kitap', imagePath: 'assets/images/wastes/paper/book.png', type: 'paper'),
    RecyclableItem(name: 'Defter', imagePath: 'assets/images/wastes/paper/notebook.png', type: 'paper'),
    RecyclableItem(name: 'Karton Kutu', imagePath: 'assets/images/wastes/paper/package.png', type: 'paper'),
    RecyclableItem(name: 'Kağıt Poşet', imagePath: 'assets/images/wastes/paper/paper_bag.png', type: 'paper'),
    RecyclableItem(name: 'Origami', imagePath: 'assets/images/wastes/paper/origami.png', type: 'paper'),
    RecyclableItem(name: 'Broşür', imagePath: 'assets/images/wastes/paper/brochure.png', type: 'paper'),
    RecyclableItem(name: 'Zarf', imagePath: 'assets/images/wastes/paper/envelope.png', type: 'paper'),
    RecyclableItem(name: 'Kağıt Havlu', imagePath: 'assets/images/wastes/paper/paper_towel.png', type: 'paper'),
    RecyclableItem(name: 'Mendil', imagePath: 'assets/images/wastes/paper/handkerchief.png', type: 'paper'),
    RecyclableItem(name: 'Kağıt Karton', imagePath: 'assets/images/wastes/paper/paper_carton.png', type: 'paper'),
    RecyclableItem(name: 'Kağıt Bardak', imagePath: 'assets/images/wastes/paper/paper_cup.png', type: 'paper'),
    RecyclableItem(name: 'Kağıt Ambalaj', imagePath: 'assets/images/wastes/paper/paper_packaging.png', type: 'paper'),
    RecyclableItem(name: 'Kağıt Makbuz', imagePath: 'assets/images/wastes/paper/paper_receipt.png', type: 'paper'),
    RecyclableItem(name: 'Kağıt Poster', imagePath: 'assets/images/wastes/paper/paper_poster.png', type: 'paper'),
    RecyclableItem(name: 'Kağıt Harita', imagePath: 'assets/images/wastes/paper/paper_map.png', type: 'paper'),
    RecyclableItem(name: 'Kağıt El İlanı', imagePath: 'assets/images/wastes/paper/flyer.png', type: 'paper'),
    RecyclableItem(name: 'Kağıt Davetiye', imagePath: 'assets/images/wastes/paper/wedding_invitation.png', type: 'paper'),
    RecyclableItem(name: 'Yapışkan Notlar', imagePath: 'assets/images/wastes/paper/sticky_note.png', type: 'paper'),
  ],
  'plastic': [
    RecyclableItem(name: 'Plastik Şişe', imagePath: 'assets/images/wastes/plastic/plastic_bottle.png', type: 'plastic'),
    RecyclableItem(name: 'Plastik Bardak', imagePath: 'assets/images/wastes/plastic/plastic_cup.png', type: 'plastic'),
    RecyclableItem(name: 'Plastik Tabanca', imagePath: 'assets/images/wastes/plastic/plastic_water_gun.png', type: 'plastic'),
    RecyclableItem(name: 'Plastik Poşet', imagePath: 'assets/images/wastes/plastic/plastic_bag.png', type: 'plastic'),
    RecyclableItem(name: 'Plastik Kapak', imagePath: 'assets/images/wastes/plastic/plastic_cap.png', type: 'plastic'),
    RecyclableItem(name: 'Plastik Kova', imagePath: 'assets/images/wastes/plastic/plastic_bucket.png', type: 'plastic'),
    RecyclableItem(name: 'Plastik Oyuncak', imagePath: 'assets/images/wastes/plastic/plastic_rubber.png', type: 'plastic'),
    RecyclableItem(name: 'Plastik Saklama Kabı', imagePath: 'assets/images/wastes/plastic/plastic_container.png', type: 'plastic'),
    RecyclableItem(name: 'Plastik Çatal', imagePath: 'assets/images/wastes/plastic/plastic_fork.png', type: 'plastic'),
    RecyclableItem(name: 'Plastik Kaşık', imagePath: 'assets/images/wastes/plastic/plastic_spoon.png', type: 'plastic'),
    RecyclableItem(name: 'Plastik Bıçak', imagePath: 'assets/images/wastes/plastic/plastic_knife.png', type: 'plastic'),
    RecyclableItem(name: 'Plastik Pipet', imagePath: 'assets/images/wastes/plastic/plastic_straw.png', type: 'plastic'),
    RecyclableItem(name: 'Plastik Deterjan Kabı', imagePath: 'assets/images/wastes/plastic/plastic_detergent.png', type: 'plastic'),
    RecyclableItem(name: 'Plastik Kap', imagePath: 'assets/images/wastes/plastic/plastic_container_1.png', type: 'plastic'),
    RecyclableItem(name: 'Plastik Şampuan Şişesi', imagePath: 'assets/images/wastes/plastic/plastic_shampoo.png', type: 'plastic'),
    RecyclableItem(name: 'Plastik Küçük Kap', imagePath: 'assets/images/wastes/plastic/plastic_jam.png', type: 'plastic'),
    RecyclableItem(name: 'Plastik Bardak Altlığı', imagePath: 'assets/images/wastes/plastic/plastic_coaster.png', type: 'plastic'),
    RecyclableItem(name: 'Plastik Dosya', imagePath: 'assets/images/wastes/plastic/plastic_folder.png', type: 'plastic'),
    RecyclableItem(name: 'Plastik Koli Bandı', imagePath: 'assets/images/wastes/plastic/plastic_tape.png', type: 'plastic'),
    RecyclableItem(name: 'Plastik Çiçek', imagePath: 'assets/images/wastes/plastic/plastic_flower.png', type: 'plastic'),
  ],
  'glass': [
    RecyclableItem(name: 'Cam Şişe', imagePath: 'assets/images/wastes/glass/glass_bottle.png', type: 'glass'),
    RecyclableItem(name: 'Cam Kavanoz', imagePath: 'assets/images/wastes/glass/glass_jar.png', type: 'glass'),
    RecyclableItem(name: 'Cam Bardak', imagePath: 'assets/images/wastes/glass/glass_cup.png', type: 'glass'),
    RecyclableItem(name: 'Cam Tabak', imagePath: 'assets/images/wastes/glass/glass_plate.png', type: 'glass'),
    RecyclableItem(name: 'Cam Vazo', imagePath: 'assets/images/wastes/glass/glass_vase.png', type: 'glass'),
    RecyclableItem(name: 'Cam Sürahi', imagePath: 'assets/images/wastes/glass/glass_jug.png', type: 'glass'),
    RecyclableItem(name: 'Cam Kase', imagePath: 'assets/images/wastes/glass/glass_bowl.png', type: 'glass'),
    RecyclableItem(name: 'Cam Lamba', imagePath: 'assets/images/wastes/glass/glass_lamp.png', type: 'glass'),
    RecyclableItem(name: 'Cam Çerçeve', imagePath: 'assets/images/wastes/glass/glass_frame.png', type: 'glass'),
    RecyclableItem(name: 'Cam Tüp', imagePath: 'assets/images/wastes/glass/glass_tube.png', type: 'glass'),
    RecyclableItem(name: 'Cam Kupa', imagePath: 'assets/images/wastes/glass/glass_mug.png', type: 'glass'),
    RecyclableItem(name: 'Cam Dekorasyon', imagePath: 'assets/images/wastes/glass/glass_dome.png', type: 'glass'),
    RecyclableItem(name: 'Cam Süs Eşyası', imagePath: 'assets/images/wastes/glass/glass_decoration.png', type: 'glass'),
    RecyclableItem(name: 'Cam Beher', imagePath: 'assets/images/wastes/glass/glass_jug_1.png', type: 'glass'),
    RecyclableItem(name: 'Cam Parfüm Kutusu', imagePath: 'assets/images/wastes/glass/glass_perfume.png', type: 'glass'),
    RecyclableItem(name: 'Cam Kapak', imagePath: 'assets/images/wastes/glass/glass_lid.png', type: 'glass'),
    RecyclableItem(name: 'Cam Balon', imagePath: 'assets/images/wastes/glass/glass_balloon.png', type: 'glass'),
    RecyclableItem(name: 'Cam Şekerlik', imagePath: 'assets/images/wastes/glass/glass_candy_bowl.png', type: 'glass'),
    RecyclableItem(name: 'Cam Çaydanlık', imagePath: 'assets/images/wastes/glass/glass_teapot.png', type: 'glass'),
    RecyclableItem(name: 'Cam Kül Tablası', imagePath: 'assets/images/wastes/glass/glass_ashtray.png', type: 'glass'),
  ],
  'metal': [
    RecyclableItem(name: 'Kola Kutusu', imagePath: 'assets/images/wastes/metal/metal_soda_can.png', type: 'metal'),
    RecyclableItem(name: 'Konserve Kutusu', imagePath: 'assets/images/wastes/metal/tin_can.png', type: 'metal'),
    RecyclableItem(name: 'Metal Ataç', imagePath: 'assets/images/wastes/metal/metal_pin.png', type: 'metal'),
    RecyclableItem(name: 'Metal Kaşık', imagePath: 'assets/images/wastes/metal/metal_spoon.png', type: 'metal'),
    RecyclableItem(name: 'Metal Çatal', imagePath: 'assets/images/wastes/metal/metal_fork.png', type: 'metal'),
    RecyclableItem(name: 'Metal Bıçak', imagePath: 'assets/images/wastes/metal/metal_knife.png', type: 'metal'),
    RecyclableItem(name: 'Metal Tencere', imagePath: 'assets/images/wastes/metal/metal_pot.png', type: 'metal'),
    RecyclableItem(name: 'Metal Kazan', imagePath: 'assets/images/wastes/metal/metal_pot_1.png', type: 'metal'),
    RecyclableItem(name: 'Metal Bardak', imagePath: 'assets/images/wastes/metal/metal_cup.png', type: 'metal'),
    RecyclableItem(name: 'Metal Kutu', imagePath: 'assets/images/wastes/metal/metal_box.png', type: 'metal'),
    RecyclableItem(name: 'Metal Tel', imagePath: 'assets/images/wastes/metal/metal_wire.png', type: 'metal'),
    RecyclableItem(name: 'Metal Çerçeve', imagePath: 'assets/images/wastes/metal/metal_plate.png', type: 'metal'),
    RecyclableItem(name: 'Metal Oyuncak', imagePath: 'assets/images/wastes/metal/metal_toy.png', type: 'metal'),
    RecyclableItem(name: 'Metal Vidalar', imagePath: 'assets/images/wastes/metal/metal_screw_1.png', type: 'metal'),
    RecyclableItem(name: 'Metal Zincir', imagePath: 'assets/images/wastes/metal/metal_chain.png', type: 'metal'),
    RecyclableItem(name: 'Metal Askı', imagePath: 'assets/images/wastes/metal/metal_hanger.png', type: 'metal'),
    RecyclableItem(name: 'Metal Şişe Açacağı', imagePath: 'assets/images/wastes/metal/metal_lid.png', type: 'metal'),
    RecyclableItem(name: 'Metal Çivi', imagePath: 'assets/images/wastes/metal/metal_nail.png', type: 'metal'),
    RecyclableItem(name: 'Metal Vida', imagePath: 'assets/images/wastes/metal/metal_screw.png', type: 'metal'),
    RecyclableItem(name: 'Metal Makas', imagePath: 'assets/images/wastes/metal/metal_scissors.png', type: 'metal'),
  ],
  'organic': [
    RecyclableItem(name: 'Muz Kabuğu', imagePath: 'assets/images/wastes/organic/banana_peel.png', type: 'organic'),
    RecyclableItem(name: 'Elma Kabuğu', imagePath: 'assets/images/wastes/organic/apple_peel.png', type: 'organic'),
    RecyclableItem(name: 'Portakal Kabuğu', imagePath: 'assets/images/wastes/organic/peel.png', type: 'organic'),
    RecyclableItem(name: 'Salatalık Kabuğu', imagePath: 'assets/images/wastes/organic/cucumber_peel.png', type: 'organic'),
    RecyclableItem(name: 'Elma Çöpü', imagePath: 'assets/images/wastes/organic/apple_peel_1.png', type: 'organic'),
    RecyclableItem(name: 'Patates Kabuğu', imagePath: 'assets/images/wastes/organic/potato_peel.png', type: 'organic'),
    RecyclableItem(name: 'Soğan Kabuğu', imagePath: 'assets/images/wastes/organic/onion_peel.png', type: 'organic'),
    RecyclableItem(name: 'Havuç Kabuğu', imagePath: 'assets/images/wastes/organic/carrot_peel.png', type: 'organic'),
    RecyclableItem(name: 'Çay Poşeti', imagePath: 'assets/images/wastes/organic/tea_bag.png', type: 'organic'),
    RecyclableItem(name: 'Kahve Çekirdeği', imagePath: 'assets/images/wastes/organic/coffee_bean.png', type: 'organic'),
    RecyclableItem(name: 'Yumurta Kabuğu', imagePath: 'assets/images/wastes/organic/eggshell.png', type: 'organic'),
    RecyclableItem(name: 'Ekmek Parçası', imagePath: 'assets/images/wastes/organic/bread.png', type: 'organic'),
    RecyclableItem(name: 'Peynir Parçası', imagePath: 'assets/images/wastes/organic/cheese.png', type: 'organic'),
    RecyclableItem(name: 'Balya', imagePath: 'assets/images/wastes/organic/straw.png', type: 'organic'),
    RecyclableItem(name: 'Limon Kabuğu', imagePath: 'assets/images/wastes/organic/lemon_peel.png', type: 'organic'),
    RecyclableItem(name: 'Ağaç Yaprağı', imagePath: 'assets/images/wastes/organic/leaves.png', type: 'organic'),
    RecyclableItem(name: 'Marul Yaprağı', imagePath: 'assets/images/wastes/organic/lettuce_leaf.png', type: 'organic'),
    RecyclableItem(name: 'Ağaç Yaprakları', imagePath: 'assets/images/wastes/organic/leaves_1.png', type: 'organic'),
    RecyclableItem(name: 'Kiraz Çekirdeği', imagePath: 'assets/images/wastes/organic/cherry_pit.png', type: 'organic'),
    RecyclableItem(name: 'Meyve', imagePath: 'assets/images/wastes/organic/fruit.png', type: 'organic'),
  ],
};

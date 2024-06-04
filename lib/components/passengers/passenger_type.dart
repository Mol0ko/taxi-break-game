enum PassengerType {
  man1(
    idleSpriteSource: 'people/man_1_idle.png',
    walkSpriteSource: 'people/man_1_walk.png',
  ),
  man2(
    idleSpriteSource: 'people/man_2_idle.png',
    walkSpriteSource: 'people/man_2_walk.png',
  ),
  man3(
    idleSpriteSource: 'people/man_3_idle.png',
    walkSpriteSource: 'people/man_3_walk.png',
  );

  final String idleSpriteSource;
  final String walkSpriteSource;

  const PassengerType({
    required this.idleSpriteSource,
    required this.walkSpriteSource,
  });
}

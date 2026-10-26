const faxNames: Record<string, string> = {
  'Tarkon Industries Bridge': '塔肯工业舰桥',
  'Tarkon TB.': '塔肯舰桥',
};

const augmentNames: Record<string, string> = {
  'Raptoral cybernetic head': '猛禽型机械头部',
  'Greyscale robotic Teshari head': '可调色特沙利机械头部',
  'Raptoral cybernetic chest': '猛禽型机械躯干',
  'Greyscale robotic Teshari chest': '可调色特沙利机械躯干',
  'Raptoral prosthetic left forelimb': '猛禽型左前肢义肢',
  'Raptoral cybernetic left forelimb': '猛禽型机械左前肢',
  'Greyscale robotic Teshari left arm': '可调色特沙利机械左前肢',
  'Raptoral prototype right forelimb': '猛禽型原型右前肢',
  'Greyscale robotic Teshari right arm': '可调色特沙利机械右前肢',
  'Raptoral prosthetic left hindlimb': '猛禽型左后肢义肢',
  'Raptoral cybernetic left hindlimb': '猛禽型机械左后肢',
  'Greyscale robotic Teshari left leg': '可调色特沙利机械左后肢',
  'Raptoral prosthetic right hindlimb': '猛禽型右后肢义肢',
  'Raptoral cybernetic right hindlimb': '猛禽型机械右后肢',
  'Greyscale robotic Teshari right leg': '可调色特沙利机械右后肢',
};

const researchCategoryNames: Record<string, string> = {
  Raptoral: '猛禽型',
  'Advanced Raptoral Limbs': '高级猛禽型肢体',
  'Xenoarchaeology Machinery': '异星考古机器',
  'Xenoarchaeology Equipment': '异星考古装备',
  'Xenoarchaeology Tools': '异星考古工具',
  'Xenoarchaeology Tools (Advanced)': '高级异星考古工具',
};

export const skyratFaxDisplay = (value: string) => faxNames[value] ?? value;

export const skyratAugmentDisplay = (value: string) =>
  augmentNames[value] ?? value;

export const skyratAugmentOptions = (values: string[]) =>
  values.map((value) => ({ value, displayText: skyratAugmentDisplay(value) }));

export const skyratResearchCategoryDisplay = (value: string) =>
  researchCategoryNames[value] ?? value;

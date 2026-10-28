import { Section, Stack, LabeledList } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { type Objective, ObjectivePrintout } from './common/Objectives';

type Info = {
  objectives: Objective[];
  team: Team;
};

type Team = {
  blood_consumed_total: number;
  times_reproduced_total: number;
};

export const AntagInfoBloodWorm = (props) => {
  const { data } = useBackend<Info>();
  const { objectives, team } = data;
  return (
    <Window width={800} height={500}>
      <Window.Content>
        <Section scrollable fill>
          <Stack vertical>
            <Stack.Item textColor="red" fontSize="20px">
              你是一只血虫！
            </Stack.Item>
            <Stack.Item>
              <ObjectivePrintout objectives={objectives} />
            </Stack.Item>
            <Stack.Item>
              <Stack vertical>
                <Stack.Item bold>你的队伍状态：</Stack.Item>
                <Stack.Item>
                  - 总摄血量：{team.blood_consumed_total} 单位<br/>
                  - 总繁殖次数：{team.times_reproduced_total} 次
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Stack.Item>
              <Section fill title="能力">
                <LabeledList>
                  <LabeledList.Item label="无需呼吸">
                  你无需呼吸，你的宿主也一样。
                  </LabeledList.Item>
                  <LabeledList.Item label="摄取血液">
                  使用吸血或侵入尸体摄取血液可以促进生长，
                  但猴子血等合成血液的效果有上限。
                  你的抬头显示能让你一眼看出目标的血量，
                  检查目标还能获得更详细的血液信息。
                  </LabeledList.Item>
                  <LabeledList.Item label="生长阶段">
                  你可以在状态栏查看生长进度。当前阶段生长完成后，
                  你可以结茧孵化，进入下一生长阶段。
                  进入幼年期后便能吐血，而成虫则极其强壮。
                  </LabeledList.Item>
                  <LabeledList.Item label="管道爬行">
                  初生血虫可以钻通风管。长大后，你将失去这项能力，
                  只能靠钻门缝、破门或 ID 权限来通行。
                  在进入幼年期前，先找好藏身处或宿主。
                  </LabeledList.Item>
                  <LabeledList.Item label="钻门缝">
                  初生和幼年血虫能从门下钻过，成虫则不行，
                  只能靠破门和 ID 权限来通行。
                  在成年前，务必找好可靠的藏身处或宿主。
                  </LabeledList.Item>
                  <LabeledList.Item label="繁殖">
                  成年并达到最后生长阶段后，你可以繁殖出 3 只初生血虫，代价是自己也变回初生状态。
                  </LabeledList.Item>
                  <LabeledList.Item label="寄生">
                  你拥有随心所欲化为血液的超自然能力。
                  这让你能够进入尸体，将其作为宿主。
                  </LabeledList.Item>
                  <LabeledList.Item label="再生">
                  你会随时间缓慢恢复，从濒死状态完全恢复约需 5 分钟。在宿主体内时，这表现为血量逐渐恢复。
                  你可以向宿主受损的组织注血，消耗自己的生命值来迅速治愈宿主。
                  </LabeledList.Item>
                  <LabeledList.Item label="生命维持">
                  你在宿主体内时，宿主只需大脑就能存活，无需其他重要器官。肺让你能说话，肝脏让你能代谢化学品。
                  拿起器官并用它右键点击宿主，即可将其植入宿主体内。机械器官也适用。
                  </LabeledList.Item>
                  <LabeledList.Item label="异星心智">
                  你的心智与人类不同。常人会遇到的事物无法令你产生渴望、恐惧、悲伤或快乐，即使在宿主体内也一样。
                  </LabeledList.Item>
                </LabeledList>
              </Section>
            </Stack.Item>
            <Stack.Item>
              <Section fill title="弱点">
                <LabeledList>
                  <LabeledList.Item label="极寒">
                  你的种族能很好地抵御气压变化和寒冷，但极低的气压和温度仍会伤害你。
                  在宿主体内时，你不受此弱点影响，也可以给宿主穿上太空服来保护它。
                  </LabeledList.Item>
                  <LabeledList.Item label="高温">
                  你的种族惧怕高温，在炎热环境中会迅速灼伤。你的身体也很易燃，务必远离火焰。
                  即使在宿主体内，此弱点也依然存在，但为宿主穿戴防火装备可以弥补。
                  </LabeledList.Item>
                  <LabeledList.Item label="出血">
                  在宿主体内时，你会完全化为血液。因此，出血伤口对你尤其危险。
                  宿主失血会直接伤害你，而且宿主即使死去也会继续出血。
                  你的宿主出血速度还比常人快 50%。
                  </LabeledList.Item>
                  <LabeledList.Item label="低等生理结构">
                  宿主没有你的敏锐感官，会受到黑暗和闪光弹等常见因素的妨碍。
                  你可以使用夜视镜、护目镜和护耳装备等人类工具来弥补。
                  </LabeledList.Item>
                  <LabeledList.Item label="检测">
                  德福雷斯特公司开发了检测血虫的一次性设备。安保可以订购这种设备，
                  使用时无需等待，但会令目标疼痛，而且价格高昂。
                  </LabeledList.Item>
                </LabeledList>
              </Section>
            </Stack.Item>
            <Stack.Item>
              <Section fill title="技巧">
                <LabeledList>
                  <LabeledList.Item label="隐蔽治疗">
                  利用医疗部治疗宿主，而不是消耗血液，可以避免让宿主的皮肤变得惨白。
                  这也能为之后的吐血和治疗保留更多血液。
                  </LabeledList.Item>
                  <LabeledList.Item label="血虫突袭">
                  你可以脱离宿主发动突袭，成年后尤其有效。务必先封锁
                  所有逃跑路线，因为脱离宿主需要 3 秒。
                  </LabeledList.Item>
                  <LabeledList.Item label="门缝潜伏">
                  初生或幼年血虫可以钻进门底，潜伏等待附近的受害者。小心前来开门的人。
                  </LabeledList.Item>
                  <LabeledList.Item label="肉盾">
                  宿主就是你的肉盾，但要留意火焰、出血伤口、焚尸炉以及能将其绞碎的装置。
                  宿主生命值过低时，记得及时使用注血来治疗。
                  </LabeledList.Item>
                  <LabeledList.Item label="保命措施">
                  血量不足最大生命值的十分之一时，你无法控制尸体，因此生命垂危时会被迫脱离宿主。
                  你可以利用这一机制，争取最后一次逃脱机会。
                  </LabeledList.Item>
                  <LabeledList.Item label="医疗部自助餐">
                  找不到猴子时，医疗部的血液冷柜也是不错的合成血液来源。
                  小心附近的船员，打坏冷柜的声音能够穿墙。
                  </LabeledList.Item>
                  <LabeledList.Item label="速食">
                  你可以进入尸体，极快地吸尽其血液。已经处于宿主体内时获得的血液不会促进生长。
                  复制的血液可以促进生长，但它属于合成血液，效果有限。
                  </LabeledList.Item>
                  <LabeledList.Item label="游荡生活">
                  你有夜视能力，也不受领地限制，因此到哪里都能生存。初生血虫可以钻通风管，
                  幼年和成年血虫则能用牙齿咬破门和其他障碍。没有哪里能躲过你！
                  </LabeledList.Item>
                  <LabeledList.Item label="结伴行动">
                  同族通常与你目标一致，也愿意合作。你们拥有自己的语言——虫语，
                  只有同族能够听懂。你可以通过抬头显示图标辨认血虫宿主。
                  </LabeledList.Item>
                  <LabeledList.Item label="越狱">
                  被安保抓住了？激活吐血后右键点击，即可破坏宿主受到的束缚，包括柜子等。
                  你也可以脱离宿主，通过通风管或破门逃出。
                  </LabeledList.Item>
                  <LabeledList.Item label="助力成长">
                  成年后，你可以为后代收集尸体作为宿主。收集血液可以帮助
                  初生血虫迅速进入幼年期，甚至直接长成成虫。
                  </LabeledList.Item>
                </LabeledList>
              </Section>
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};

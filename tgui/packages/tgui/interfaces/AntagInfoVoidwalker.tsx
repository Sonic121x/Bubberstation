import { BlockQuote, LabeledList, Section, Stack } from 'tgui-core/components';

import { Window } from '../layouts';

const tipstyle = {
  color: 'white',
};

const noticestyle = {
  color: 'lightblue',
};

export const AntagInfoVoidwalker = (props) => {
  return (
    <Window width={660} height={660}>
      <Window.Content backgroundColor="#0d0d0d">
        <Stack fill>
          <Stack.Item width="50%">
            <Section fill>
              <Stack vertical fill>
                <Stack.Item fontSize="25px">你是虚空行者</Stack.Item>
                <Stack.Item>
                  <BlockQuote>
                    你是来自星际虚空的生物。
                    这座空间站广播的无线电信号
                    将你吸引至此。
                  </BlockQuote>
                </Stack.Item>
                <Stack.Divider />
                <Stack.Item textColor="label">
                  <span style={tipstyle}>生存：&ensp;</span>
                  你拥有无与伦比的自由。留在太空中，就无人能够
                  阻挡你。你可以穿过窗户，因此尽量靠近窗户，
                  随时为自己留条退路。
                  <br />
                  <br />
                  <span style={tipstyle}>狩猎：&ensp;</span>
                  挑有利的架打。寻找疏于防范的目标，
                  趁其不备发动攻击。
                  <br />
                  <br />
                  <span style={tipstyle}>掳掠：&ensp;</span>
                  惊扰能力会使目标眩晕并削弱他们。用
                  汲取斩击将其击倒，带到太空（或
                  星云呕吐物中），然后启迪他们。
                  <br />
                  <br />
                  <span style={tipstyle}>收获：&ensp;</span>
                  我们的学生会定期排出我们的精华。我们可借此
                  前往原本无法抵达的地方，但借此离开时，
                  会将其重新吸收。（你可以潜入太空呕吐物。）
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
          <Stack.Item width="50%">
            <Section fill title="能力">
              <LabeledList>
                <LabeledList.Item label="太空潜行">
                  你可以从太空潜入空间站下方移动，用它来狩猎，
                  或抵达隔绝的太空区域。
                </LabeledList.Item>
                <LabeledList.Item label="汲取斩击">
                  你能直接夺走目标肺中的气息，迅速击倒
                  最强大的对手。如果他们反抗，
                  右键点击可以造成直接伤害。除此之外，你的手臂
                  并不灵巧，除了抓取东西，
                  基本做不了别的。
                </LabeledList.Item>
                <LabeledList.Item label="星辰体质">
                  你的天然伪装让你在太空中隐形，同时
                  治愈身体所受的伤。你可以
                  自由穿过玻璃，但在重力下会减速。
                </LabeledList.Item>
                <LabeledList.Item label="惊扰">
                  在受害者视野中只露出部分身形时对其使用，
                  使其眩晕并虚弱，但也会暴露你的存在。
                </LabeledList.Item>
                <LabeledList.Item label="星辰冲刺">
                  距离短、伤害微乎其微，因此不适合进攻，
                  却很适合迅速逃脱和调整位置。
                </LabeledList.Item>
                <LabeledList.Item label="扩张">
                  每授予一次教诲，我们的力量便会增长。我们可以
                  将墙壁变为玻璃，让自己抵达更远的地方。
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

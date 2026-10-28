// THIS IS A SKYRAT UI FILE
import { BlockQuote, Box, NoticeBox, Section } from 'tgui-core/components';

import { Window } from '../layouts';

export const DelamProcedure = () => {
  return (
    <Window
      title="安全蛾——崩解应急处置流程"
      width={666}
      height={865}
      theme="dark"
    >
      <Window.Content>
        <Section title="纳米传讯认证的崩解应急处置流程">
          <NoticeBox danger m={2}>
            <b>
              看来你遇到了一点小麻烦：
              超物质反应堆正在崩解。
              <br />
              <br />
              别担心，只需几步就能拯救局面！
            </b>
          </NoticeBox>
          <BlockQuote m={2}>
            找到那个总是难觅踪影的红色紧急停止按钮。它
            很可能就在你眼前，所以慢慢找，笑一笑，
            好好享受期待的过程。记住，这就像寻宝，
            只不过额外的奖品是阻止一场核灾难。
          </BlockQuote>
          <BlockQuote m={2}>
            找到按钮后，鼓起全部勇气，
            像没有明天一样按下去。呃，其实你按下它
            正是为了确保还有明天。不过，谁不喜欢
            这种有点自相矛盾的按按钮体验呢？
          </BlockQuote>
          <BlockQuote m={2}>
            做好准备，超物质引擎室即将启动抑制措施，
            周围很快就会安静下来。务必确保
            所有人都已撤离，否则他们可要大吃一惊了。
            这套系统需要独处空间，而且它可不是什么
            和善的邻居。
          </BlockQuote>
          <BlockQuote m={2}>
            成功抑制崩解后，不妨花点时间
            欣赏晶体发电的精妙之美。检查
            四周，修好那些脆弱玻璃组件的损伤。
            干活时尽管穿上你最好的工作服，
            发挥心中工程机器人的本领吧。
          </BlockQuote>
          <BlockQuote m={2}>
            留意火灾和那臭名昭著的混合气体。在可呼吸
            空气与潜在窒息之间寻求完美平衡，
            总是一场冒险。记住，氧气加火花等于
            烟花——而你绝不想让这种烟花在
            反应堆里绽放。
          </BlockQuote>
          <NoticeBox info m={2}>
            <b>
              你知道氟利昂会在低温下燃烧吗？
              <br />
              <br />
              它甚至会在 120K 至 160K 之间形成热冰！
              <br />
              <br />
              记住，你随时可以将引擎室空气警报器设为
              污染模式，帮助清除有害气体！
            </b>
          </NoticeBox>
          <BlockQuote m={2}>
            为了避免烧掉眉毛，不妨请合成人
            或可靠的机器人帮忙。毕竟，把灭火工作
            外包给不需要呼吸的非生命助手，
            才最能体现“安全第一”。
          </BlockQuote>
          <BlockQuote m={2}>
            清理所有轻度放射性碎屑和热冰（货运部
            大概会很乐意替你处理）。
          </BlockQuote>
          <BlockQuote m={2}>
            最后，尽情享受那份成就感吧：你凭一己之力
            阻止了崩解。当然，也别
            忘了心怀愧疚，因为安全蛾全都知道。安全蛾无所不知。
            它一直在观察、评判，可能还在
            为下一场安全简报做笔记。所以，尽管享受
            英雄的荣光，但要知道那只全知的蛾子已经盯上你了。
          </BlockQuote>
          <Box m={2}>
            <b>可选步骤，献给真正的亡命之徒</b>
          </Box>
          <BlockQuote m={2}>
            当你准备第二次启动超物质引擎时：拿起
            这块标牌，朝晶体用力扔过去，看着它
            在空中飞翔。<br />
            <br />
            没有什么比胡闹一番更能表现出
            “我正在应对一场潜在灾难”了。
          </BlockQuote>
          <NoticeBox m={2}>
            <b>
              希望你永远用不上这些。不过，祝你好运！
            </b>
          </NoticeBox>
        </Section>
      </Window.Content>
    </Window>
  );
};

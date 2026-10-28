import { Box, NoticeBox, Section, Stack } from 'tgui-core/components';

const ORDER_TEXT = `空间站各部门会通过各自的专用
        控制台订购货箱。这些订单完全免费！它们不会扣除
        货运预算，只会让控制台进入冷却。接下来
        就轮到你出场了：订购的货箱会显示在你的
        物资控制台上，你需要将货箱送到订购者手中。
        如果货箱未经拆动，送达时你将获得
        相当于该部门货箱全额价值的报酬，因此这个系统
        是个不错的收入来源。`;

const DISPOSAL_TEXT = `除了使用搬运机器人和亲自运送，你也可以利用
        废物管道邮寄系统。请注意，废物管道破损可能
        导致包裹丢失（这种情况极少发生），因此这并不
        总是最安全的递送方式。如果你（或柜台前的某个人）
        想要寄信，也可以将一张纸包装起来，
        用同样的方式寄出。`;

export function CargoHelp(props) {
  return (
    <Stack fill vertical>
      <Stack.Item grow>
        <Section fill scrollable>
          <Section color="label" title="部门订单">
            {ORDER_TEXT}
            <br />
            <br />
            检查部门订单货箱，即可获得其
            具体递送地点的信息。
          </Section>
          <Section title="搬运机器人">
            <Box color="label">
              搬运机器人虽然缓慢，但很可靠，能帮技术员
              省力地递送货箱。不过，它的速度较慢，
              途中也可能遭到他人干扰。
            </Box>
            <br />
            <Box bold color="green">
              设置搬运机器人很简单：
            </Box>
            <b>1.</b> 将需要递送的货箱拖到搬运机器人旁边。
            <br />
            <b>2.</b> 将货箱拖放到搬运机器人身上，即可装载。
            <br />
            <b>3.</b> 打开你的 PDA。
            <br />
            <b>4.</b> 点击<i>运输机器人控制</i>。<br />
            <b>5.</b> 点击<i>扫描运行中的机器人</i>。<br />
            <b>6.</b> 选择你的搬运机器人。
            <br />
            <b>7.</b> 点击<i>目的地：（设置）</i>。<br />
            <b>8.</b> 选择目的地并点击确定。
            <br />
            <b>9.</b> 点击<i>出发</i>。
          </Section>
          <Section title="废物管道递送系统">
            <Box color="label">{DISPOSAL_TEXT}</Box>
            <br />
            <Box bold color="green">
              使用废物管道递送系统更简单：
            </Box>
            <b>1.</b> 用包装纸包好物品或货箱。
            <br />
            <b>2.</b> 使用目的地标签器选择递送地点。
            <br />
            <b>3.</b> 给包裹贴上标签。
            <br />
            <b>4.</b> 将包裹放上传送带，剩下的交给系统处理。
            <br />
          </Section>
        </Section>
      </Stack.Item>
      <Stack.Item>
        <NoticeBox textAlign="center" info mb={0}>
          还有这里没提到的问题？有疑问就去问货运主管！
        </NoticeBox>
      </Stack.Item>
    </Stack>
  );
}

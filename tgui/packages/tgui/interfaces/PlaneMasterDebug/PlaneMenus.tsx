import { useState } from 'react';
import { Button, Dropdown, Modal, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { BlendModes, type Plane } from './types';
import { usePlaneDebugContext } from './usePlaneDebug';

export function PlaneMenus() {
  const { connectionOpen, infoOpen } = usePlaneDebugContext();

  return (
    <>
      {!!connectionOpen && <AddConnectionModal />}
      {!!infoOpen && <InfoModal />}
    </>
  );
}

function AddConnectionModal() {
  const { act } = useBackend();
  const { activePlane, setActivePlane, setConnectionOpen, planesProcessed } =
    usePlaneDebugContext();
  const currentPlane = planesProcessed[activePlane as number];
  const optionMap: Record<string, number> = {};
  const [selectedTarget, setSelectedTarget] = useState<number>();
  const [selectedBlend, setSelectedBlend] = useState<string>('BLEND_DEFAULT');

  const selectablePlanes: Plane[] = [];
  for (const key in planesProcessed) {
    const plane: Plane = planesProcessed[key];
    if (plane !== currentPlane) {
      selectablePlanes.push(plane);
      optionMap[plane.name] = plane.plane;
    }
  }

  const planeOptions: Array<string> = selectablePlanes
    .sort((a, b) => {
      if (a.depth !== b.depth) {
        return a.depth - b.depth;
      }

      return a.plane - b.plane;
    })
    .map((a) => a.name);

  return (
    <Modal p={1}>
      <Section
        fill
        title={`添加来自 ${currentPlane.name} 的中继`}
        buttons={
          <Button
            icon="close"
            color="bad"
            onClick={() => {
              setConnectionOpen(false);
              setActivePlane(undefined);
            }}
          />
        }
      >
        <Stack fill vertical>
          <Stack.Item>
            <Dropdown
              options={planeOptions}
              selected={
                selectedTarget !== undefined
                  ? planesProcessed[selectedTarget].name
                  : '选择目标'
              }
              width="300px"
              onSelected={(value) => setSelectedTarget(optionMap[value])}
            />
          </Stack.Item>
          <Stack.Item>
            <Dropdown
              options={Object.keys(BlendModes).filter((x) =>
                Number.isNaN(Number(x)),
              )}
              selected={selectedBlend}
              width="300px"
              onSelected={(value) => setSelectedBlend(value)}
            />
          </Stack.Item>
          <Stack.Item textAlign="center">
            <Button
              color="good"
              onClick={() => {
                act('connect_relay', {
                  source: activePlane,
                  target: selectedTarget,
                  mode: BlendModes[selectedBlend],
                });
                setConnectionOpen(false);
                setActivePlane(undefined);
              }}
            >
              确认
            </Button>
          </Stack.Item>
        </Stack>
      </Section>
    </Modal>
  );
}

function InfoModal() {
  const { setInfoOpen } = usePlaneDebugContext();
  return (
    <Modal
      position="absolute"
      top="100px"
      right="180px"
      left="180px"
      bottom="100px"
    >
      <Section
        fill
        scrollable
        title="信息面板"
        buttons={
          <Button
            icon="times"
            tooltip="关闭"
            onClick={() => setInfoOpen(false)}
          />
        }
      >
        <h3>这是什么？</h3>
        此界面将平面控制器可视化，它们是我们
        渲染系统的核心。<br />
        此处还提供了一些编辑和调整平面控制器的工具。<br />
        <br />
        <h3>如何使用此界面</h3> <br />
        此界面的主要用途是可视化，因为这些信息
        比较晦涩，希望这种方式能让它们更易于理解。
        <br />
        <br />
        同时，它也支持编辑平面控制器、添加和移除
        中继，并可便捷地编辑颜色矩阵、滤镜、
        不透明度以及其他变量。<br />
        <br />
        首先，每个小圆圈都表示一个基于{' '}
        <code>render_target</code> 的连接。
        <br />
        蓝色节点是中继，将一个平面绘制到另一个平面上。紫色节点
        是基于滤镜的连接。<br />
        根据节点位于平面的哪一侧，可以判断
        其起点和终点。<br />
        <br />
        添加新中继很简单，只需点击 + 按钮，
        然后按名称选择中继目标平面。<br />
        <br />
        点击每个平面右上角的小按钮，
        即可查看其详细信息。这会打开侧边栏，显示
        平面的基本信息和用途，同时提供
        一些实用按钮和相关数值。<br />
        <br />
        平面按照初始设置排列。如果修改导致
        无法恢复的问题，或者只是想重置，可以点击
        左上角的回收按钮，完全刷新平面控制器。{' '}
        <br />
        <br />
        <h3>什么是平面控制器？</h3>
        可以将平面控制器理解为将一组对象汇集到
        同一个渲染画布上的方式。<br />
        它还可以按客户端独立配置，因而十分强大。这是通过
        <code>/atom</code> 的 <code>plane</code> 变量实现的。<br />
        <br />
        首先创建一个外观标志包含{' '}
        <code>PLANE_MASTER</code> 的原子，并为它设置 <code>plane</code> 值。<br />
        然后，将希望在该组中渲染的所有原子的 <code>plane</code> 值
        设为相同的值。
        <br />
        <br />
        最后，将带有 <code>PLANE_MASTER</code> 标志的原子放入
        对应客户端的屏幕内容中。<br />
        至此就完成了最基本的设置。
        <br />
        <br />
        请注意，<code>plane</code> 变量不仅影响
        渲染分组行为。<br />
        它还会影响地图上对象的叠放顺序。<br />
        <br />
        因此，有些效果几乎不可能单靠
        平面实现。<br />
        例如，为对象添加遮罩的同时，又让它与地图上
        其他对象保持正确的绘制顺序。
        <br />
        这<b>确实</b>可以做到，但会带来很大的干扰。
        <br />
        <br />
        通常，平面只是将对象分组、应用效果，然后
        直接绘制到游戏画面上。
        <br />
        如果想将<b>平面</b>绘制到其他平面上呢？<br />
        <br />
        <h3>渲染目标与中继</h3>
        <br />
        将一个对象渲染到另一个对象上其实并不复杂。<br />
        可以设置原子的 <code>render_target</code> 变量，将其
        中继给某个 <code>render_source</code>。<br />
        <br />
        如果 <code>render_target</code> 以 * 开头，它就
        <b>不会</b>绘制到客户端视图中，而仅进行中继。{' '}
        <br />
        <br />
        既然能将平面控制器中继到其他原子上，该如何
        将它绘制到另一个平面控制器上？不能只用{' '}
        <code>render_source</code> 来绘制，因为可能需要中继多个
        平面控制器。
        <br />
        <br />
        那么，何不先将它中继到另一个原子，再将该
        原子的 <code>plane</code> 变量设为目标平面控制器的值？<br />
        <br />
        我们实际采用的正是这种做法。<br />
        渲染源也经常被滤镜使用，
        通常用于应用位移或遮罩。
        <br />
        <br />
        <h3>应用效果</h3> <br />
        现在可以对平面分组并进行中继了，但具体能用它们
        做些什么？<br />
        <br />
        答案是很多。滤镜功能强大，我们也经常
        使用它们。<br />
        可以用滤镜将一个平面作为另一个平面的遮罩，或将一个平面
        用作另一个平面的扭曲源。<br />
        <br />
        也可以进行更基础的操作，例如设置平面的颜色矩阵，
        同样能实现强大的效果。<br />
        即使只是设置不透明度来显示或隐藏对象，也很有用。{' '}
        <br />
        <br />
        这里不逐一介绍所有效果。点击各个平面右上角的
        小按钮，即可了解对应平面的更多信息。<br />
        <br />
      </Section>
    </Modal>
  );
}

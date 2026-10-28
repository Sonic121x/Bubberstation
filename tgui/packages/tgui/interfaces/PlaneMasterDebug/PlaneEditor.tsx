import {
  Box,
  Button,
  LabeledList,
  Section,
  Slider,
  Tooltip,
} from 'tgui-core/components';

import { useBackend } from '../../backend';
import type { Plane } from './types';
import { usePlaneDebugContext } from './usePlaneDebug';

export function PlaneEditor() {
  const { act } = useBackend();
  const { activePlane, planesProcessed, setPlaneOpen } = usePlaneDebugContext();

  const currentPlane: Plane = planesProcessed[activePlane as number];
  const doc_html = {
    __html: currentPlane.documentation,
  };

  return (
    <Section
      fill
      scrollable
      width="450px"
      position="absolute"
      top="0px"
      right="0px"
      backgroundColor="#121212DA"
      title={`平面控制器：${currentPlane.name}`}
      buttons={
        <Button
          icon="times"
          tooltip="关闭"
          onClick={() => setPlaneOpen(false)}
        />
      }
    >
      <Section title="信息">
        <Box dangerouslySetInnerHTML={doc_html} />
        <br />
        <LabeledList>
          <LabeledList.Divider />
          <Tooltip
            content="世界中所有平面值相同的原子都会绘制到此平面控制器上"
            position="right"
          >
            <LabeledList.Item label="平面">
              {currentPlane.plane}
            </LabeledList.Item>
          </Tooltip>
          <Tooltip
            content="可以将其理解为此平面所在的楼层。我们为每一层复制各个平面，以支持多层地图"
            position="right"
          >
            <LabeledList.Item label="偏移">
              {currentPlane.offset}
            </LabeledList.Item>
          </Tooltip>
          <Tooltip
            content="渲染目标可用于引用或绘制地图上已渲染的对象。对于平面控制器，我们将其用于中继（蓝线）或滤镜（粉线）"
            position="right"
          >
            <LabeledList.Item label="渲染目标">
              {currentPlane.render_target
                ? `"${currentPlane.render_target}"`
                : '无'}
            </LabeledList.Item>
          </Tooltip>
          <Tooltip
            content="定义此平面向中继目标绘制时采用的方式。详情请参阅 BYOND 参考文档"
            position="right"
          >
            <LabeledList.Item label="混合模式">
              {currentPlane.blend_mode}
            </LabeledList.Item>
          </Tooltip>
          <Tooltip
            content="值为 1 时，此平面控制器会对其所属生物强制隐藏。某些平面很少使用，因此通常借此优化性能"
            position="right"
          >
            <LabeledList.Item label="强制隐藏">
              {currentPlane.force_hidden ? '是' : '否'}
            </LabeledList.Item>
          </Tooltip>
        </LabeledList>
        <br />
        <Section title="视觉效果">
          <Button
            tooltip="打开此平面的变量查看菜单"
            mr="5px"
            mb="5px"
            onClick={() =>
              act('vv_plane', {
                edit: currentPlane.plane,
              })
            }
          >
            查看变量
          </Button>
          <Button
            tooltip="应用并编辑整个平面的效果"
            mr="5px"
            mb="5px"
            onClick={() =>
              act('edit_filters', {
                edit: currentPlane.plane,
              })
            }
          >
            编辑滤镜
          </Button>
          <Button
            tooltip="修改不同颜色分量映射到最终平面的方式"
            mr="5px"
            mb="5px"
            onClick={() =>
              act('edit_color_matrix', {
                edit: currentPlane.plane,
              })
            }
          >
            编辑颜色矩阵
          </Button>
          <Slider
            value={currentPlane.alpha}
            minValue={0}
            maxValue={255}
            step={1}
            stepPixelSize={1.9}
            onChange={(_event, value) =>
              act('set_alpha', { edit: currentPlane.plane, alpha: value })
            }
          >
            不透明度（{currentPlane.alpha}）
          </Slider>
        </Section>
      </Section>
    </Section>
  );
}

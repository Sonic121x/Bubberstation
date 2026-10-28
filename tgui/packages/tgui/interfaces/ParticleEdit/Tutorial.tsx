import { useContext } from 'react';
import {
  Box,
  Button,
  Image,
  LabeledList,
  Modal,
  Section,
  Stack,
} from 'tgui-core/components';

import { resolveAsset } from '../../assets';
import { ParticleContext } from '.';

export const ShowDesc = (props) => {
  const { desc, setDesc } = useContext(ParticleContext);
  return (
    <Modal
      width={'60em'}
      align={VarExplanation[desc].dataunit ? 'center' : 'left'}
    >
      <Section
        title={'变量详情'}
        buttons={
          VarExplanation[desc].dataunit ? (
            <Button content="关闭" onClick={() => setDesc('')} />
          ) : (
            <>
              <Button
                content="运动基础"
                selected={desc === 'motion'}
                onClick={() => setDesc('motion')}
              />
              <Button
                content="随机分布类型"
                selected={desc === 'randtypes'}
                onClick={() => setDesc('randtypes')}
              />
              <Button
                content="生成器类型"
                selected={desc === 'gentypes'}
                onClick={() => setDesc('gentypes')}
              />
              <Button
                icon="x"
                tooltip={'关闭'}
                color={'red'}
                onClick={() => setDesc('')}
              />
            </>
          )
        }
      >
        {VarExplanation[desc].dataunit ? (
          <LabeledList>
            <LabeledList.Item label={'数据单位'}>
              {VarExplanation[desc].dataunit}
            </LabeledList.Item>
            <LabeledList.Item label={'说明'}>
              {VarExplanation[desc].desc}
            </LabeledList.Item>
          </LabeledList>
        ) : (
          VarExplanation[desc].desc
        )}
      </Section>
    </Modal>
  );
};

/** Dictionary for all the tutorial question marks + generators guide */
const VarExplanation = {
  width: {
    dataunit: '像素',
    desc: '粒子“图像”的宽度。粒子超出此范围时会消失，回到“图像”范围内时则会重新出现。',
  },
  height: {
    dataunit: '像素',
    desc: '粒子“图像”的高度。粒子超出此范围时会消失，回到“图像”范围内时则会重新出现。',
  },
  count: {
    dataunit: '整数',
    desc: '此发射器能够同时存在的粒子数量上限。达到上限后，必须等已有粒子的生命周期结束，才会继续生成粒子。',
  },
  spawning: {
    dataunit: '每刻生成的粒子数',
    desc: '粒子生成速率，单位为每刻生成的粒子数。无需使用整数，因为这是生成速率，而非生成总数。',
  },
  bound1: {
    dataunit: '坐标',
    desc: '粒子区域的x/y/z坐标下限。粒子的任意坐标低于对应下限时便会被删除。可以设为单个数值（bound1 = -100），其效果等同于 bound1 = list(-100,-100,-100)。',
  },
  bound2: {
    dataunit: '坐标',
    desc: '粒子区域的x/y/z坐标上限。粒子的任意坐标高于对应上限时便会被删除。可以设为单个数值（bound2 = 100），其效果等同于 bound2 = list(100,100,100)。',
  },
  gravity: {
    dataunit: '向量',
    desc: '每刻施加于每个粒子的恒定加速度。',
  },
  gradient: {
    dataunit: 'BYOND颜色渐变',
    desc: '颜色渐变是一种高级颜色控制方式。例如 list(0, "#f00",0.1, 0.3, "#ff0", 0.4, 0.6, "#008000", 0.7, 0.9, "#00f", "loop") 中，红、黄、绿、蓝各占10%，相邻颜色之间的过渡区各占20%，超出范围后循环回到起点。启用渐变后，需要把 color 设为数值。例如上述渐变中 color = 0 对应颜色 "#f00"。color_change 决定每刻的颜色索引变化量；若当前索引为0.1且 color_change = 0.1，则下一刻为0.2。过渡区内会混合相邻颜色，例如2/3的 "#f00" 与1/3的 "#ff0"。"space" 键指定BYOND使用的色彩空间（https://secure.byond.com/docs/ref/index.html#/{{appendix}}/color-space），影响颜色之间的混合方式。',
  },
  transform: {
    dataunit: '矩阵（列表形式）',
    desc: 'BYOND的三种矩阵类型之一（参见参考文档）。\n简单矩阵：\n大多数BYOND代码使用的标准矩阵类型：list(a, b, c, d, e, f)。\n复杂矩阵：类似简单矩阵，但除x和y之外也改变z值。最后一行可选，存在时分别加到x/y/z坐标上：list(xx,xy,xz, yx,yy,yz, zx,zy,zz) 或 list(xx,xy,xz, yx,yy,yz, zx,zy,zz, cx,cy,cz)。\n投影矩阵：\n一种仅用于粒子的特殊矩阵。与复杂矩阵一样操作x、y、z，同时还操作名为 "w" 的第四个轴，它影响z值变化时粒子缩小的程度。较低的w会使粒子看起来更快远离镜头：list(xx,xy,xz,xw, yx,yy,yz,yw, zx,zy,zz,zw, wx,wy,wz,ww)。',
  },

  icon: {
    dataunit: '图标文件或 list(icon_file = weight)',
    desc: "生成粒子使用的图标文件。未指定时生成1×1的白点。若为图标文件引用，每刻都会应用该图标；若为列表，则以键作为候选图标、对应值作为选择权重。例如 list('rain.dmi' = 1, 'snow.dmi' = 2) 约有33%的概率使用 rain.dmi、66%的概率使用 snow.dmi。",
  },
  icon_state: {
    dataunit: '字符串或 list(icon_state = weight)',
    desc: '生成粒子使用的图标状态。若为列表，则以键作为候选图标状态、对应值作为选择权重。例如 list("rain" = 1, "snow" = 2) 约有33%的概率使用 "rain"、66%的概率使用 "snow"。',
  },
  lifespan: {
    dataunit: '刻',
    desc: '在粒子生成时应用，决定经过多少刻后粒子开始消失。可以使用生成器。',
  },
  fade: {
    dataunit: '刻',
    desc: '生命周期结束后，粒子淡出所需的刻数。可以使用生成器。',
  },
  fadein: {
    dataunit: '刻',
    desc: '粒子生成时淡入所需的刻数。淡入结束后开始计算生命周期。可以使用生成器。',
  },
  color: {
    dataunit: '数值或颜色字符串',
    desc: '通常为标准颜色字符串；使用渐变时也可以是数值。可以使用生成器。详情请参阅渐变说明。',
  },
  color_change: {
    dataunit: '浮点数',
    desc: '定义了渐变时，每刻按此数值改变颜色索引。可以使用生成器。详情请参阅渐变说明。',
  },
  position: {
    dataunit: '坐标',
    desc: '粒子生成位置的X、Y、Z坐标。可以使用生成器。',
  },
  velocity: {
    dataunit: '坐标',
    desc: '粒子生成时的初始速度。可以使用生成器。',
  },
  scale: {
    dataunit: '缩放比例',
    desc: '粒子生成时应用到图标的缩放比例，形式为 list(x_scale, y_scale)，默认值为(1,1)。可以使用生成器。',
  },
  grow: {
    dataunit: '缩放比例',
    desc: '每刻施加于粒子的缩放比例变化量。可以使用生成器。',
  },
  rotation: {
    dataunit: '数值',
    desc: '指定图标时，决定粒子生成时图标顺时针旋转的角度。可以使用生成器。',
  },
  spin: {
    dataunit: '数值',
    desc: '每刻的旋转角度变化量。可以使用生成器。',
  },
  friction: {
    dataunit: '浮点数',
    desc: '每刻削减的速度比例，取值范围为0至1。可以使用生成器。',
  },

  drift: {
    dataunit: '向量',
    desc: '每刻施加于粒子的加速度。此变量每刻重新计算。可以使用生成器。',
  },

  motion: {
    desc: (
      <>
        深入了解生成器之前，首先需要理解运动。
        以下基础知识是为物理课上睡着的人准备的，
        没睡着的话可以跳过。
        <br />
        <br />
        首先需要关注三个变量：位置、速度和加速度。
        位置表示你在三维空间中的坐标；速度表示
        沿x/y/z各方向移动的快慢；加速度表示
        速度变化的快慢。简而言之：
        <br />
        <br />
        <b>位移 = 平均速度 * 时间</b> <br />
        <br /> <b>速度 = 当前速度 + 加速度 * 时间</b>
        <br />
        <br /> 因此，一段时间后的位置为：
        <br />
        <br />
        <b>
          位置 = 初始位置 + (初始速度 * 时间) + (0.5 *
          加速度 * 时间<sup>2</sup>)
        </b>
        <br />
        <br />
        换成粒子参数，相当于： <br />
        <br />
        <b>
          pixel_location = position + (velocity * ticks_elapsed) +(0.5 *
          (average_drift_during_ticks + gravity - (velocity * friction
          <sup>ticks_elapsed</sup>)) * ticks_elapsed<sup>2</sup>)
        </b>
        <br />
        <br />
        这些公式看着不错，但实际效果如何呢？
        只观察一个方向时，运动效果如下：
        <br />
        <Image src={resolveAsset('motion')} />
        <Box />
      </>
    ),
  },

  randtypes: {
    desc: (
      <Stack vertical fill>
        <Stack.Item>
          统计课上没睡着的话，可以跳过这一节。
          选择的随机类型决定了取值的概率曲线，
          也就是采样一百万次后在图表上呈现的分布。
          BYOND各随机类型的概率图如下：
        </Stack.Item>
        <Stack.Item>
          <Stack>
            <Stack.Item>
              <Stack vertical fill>
                <Stack.Item bold>均匀随机（默认）：</Stack.Item>
                <Stack.Item>
                  <Image width={25} src={resolveAsset('uniform')} />
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Stack.Item>
              <Stack vertical fill>
                <Stack.Item bold>正态随机：</Stack.Item>
                <Stack.Item>
                  <Image width={28.2} src={resolveAsset('normal')} />
                </Stack.Item>
              </Stack>
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item>
          <Stack>
            <Stack.Item>
              <Stack vertical fill>
                <Stack.Item bold>线性随机：</Stack.Item>
                <Stack.Item>
                  <Image width={25} src={resolveAsset('linear')} />
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Stack.Item>
              <Stack vertical fill>
                <Stack.Item bold>平方随机：</Stack.Item>
                <Stack.Item>
                  <Image width={25} src={resolveAsset('square_rand')} />
                </Stack.Item>
              </Stack>
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
    ),
  },

  gentypes: {
    desc: (
      <Stack vertical fill>
        <Stack.Item height={2}>
          <Stack>
            <Stack.Item width={10} bold>
              类型
            </Stack.Item>
            <Stack.Item width={11} bold>
              结果
            </Stack.Item>
            <Stack.Item width={20} bold>
              说明
            </Stack.Item>
            <Stack.Item bold width={15}>
              图示
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item height={5}>
          <Stack>
            <Stack.Item width={10}>数值（num）</Stack.Item>
            <Stack.Item width={11}>数值</Stack.Item>
            <Stack.Item width={20}>A与B之间的随机数。</Stack.Item>
            <Stack.Item>
              <Image
                src={resolveAsset('num')}
                width={15}
                style={{
                  transform: 'translateY(-20%)',
                }}
              />
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item height={5.5}>
          <Stack>
            <Stack.Item width={10}>向量（vector）</Stack.Item>
            <Stack.Item width={11}>向量</Stack.Item>
            <Stack.Item width={20}>
              A与B连线上的随机向量。
            </Stack.Item>
            <Stack.Item>
              <Image
                src={resolveAsset('vector')}
                width={15}
                style={{
                  transform: 'translateY(-35%)',
                }}
              />
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item height={7}>
          <Stack>
            <Stack.Item width={10}>长方体（box）</Stack.Item>
            <Stack.Item width={11}>向量</Stack.Item>
            <Stack.Item width={20}>
              以A和B为对角顶点的长方体内的随机向量。
            </Stack.Item>
            <Stack.Item>
              <Image
                src={resolveAsset('box')}
                width={15}
                style={{
                  transform: 'translateY(-10%)',
                }}
              />
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item height={7}>
          <Stack>
            <Stack.Item width={10}>颜色（color）</Stack.Item>
            <Stack.Item width={11}>颜色字符串或颜色矩阵</Stack.Item>
            <Stack.Item width={20}>
              结果类型取决于A或B是否为矩阵。
              结果在A与B之间进行插值，
              各分量不会单独随机取值。
            </Stack.Item>
            <Stack.Item>
              <Box width={15} />
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item height={6}>
          <Stack>
            <Stack.Item width={10}>圆环（circle）</Stack.Item>
            <Stack.Item width={11}>向量</Stack.Item>
            <Stack.Item width={20}>
              以(0,0)为中心、内外半径为A和B的圆环内，
              仅含XY分量的随机向量。
            </Stack.Item>
            <Stack.Item>
              <Image
                src={resolveAsset('circle')}
                width={15}
                style={{
                  transform: 'translateY(-30%)',
                }}
              />
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item height={6}>
          <Stack>
            <Stack.Item width={10}>球壳（sphere）</Stack.Item>
            <Stack.Item width={11}>向量</Stack.Item>
            <Stack.Item width={20}>
              以(0,0,0)为中心、内外半径为A和B的球壳内
              的随机向量。
            </Stack.Item>
            <Stack.Item>
              <Image
                src={resolveAsset('sphere')}
                width={15}
                style={{
                  transform: 'translateY(15%)',
                }}
              />
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item height={6}>
          <Stack>
            <Stack.Item width={10}>方形框（square）</Stack.Item>
            <Stack.Item width={11}>向量</Stack.Item>
            <Stack.Item width={20}>
              尺寸为A和B的两个正方形之间，仅含XY分量的随机向量。
              （正方形以(0,0)为中心，边长介于A*2与B*2之间。）
            </Stack.Item>
            <Stack.Item>
              <Box width={15} />
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item height={10}>
          <Stack>
            <Stack.Item width={10}>立方体壳（cube）</Stack.Item>
            <Stack.Item width={11}>向量</Stack.Item>
            <Stack.Item width={20}>
              尺寸为A和B的两个立方体之间的随机向量。
              （立方体以(0,0,0)为中心，边长介于A*2与B*2之间。）
            </Stack.Item>
            <Stack.Item>
              <Image
                src={resolveAsset('cube')}
                width={15}
                style={{
                  transform: 'translateY(-10%)',
                }}
              />
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
    ),
  },

  generator: {
    desc: <Box>请选择主题</Box>,
  },
};

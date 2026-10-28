import {
  createContext,
  type Dispatch,
  type SetStateAction,
  useState,
} from 'react';
import { Button, LabeledList, Section } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { Window } from '../../layouts';
import type { ParticleUIData } from './data';
import {
  EntryCoord,
  EntryFloat,
  EntryGradient,
  EntryIcon,
  EntryIconState,
  EntryTransform,
} from './EntriesBasic';
import {
  EntryGeneratorNumbersList,
  FloatGenerator,
  FloatGeneratorColor,
} from './EntriesGenerators';
import { ShowDesc } from './Tutorial';

type ParticleEditContext = {
  desc: string;
  setDesc: Dispatch<SetStateAction<string>>;
};

export const ParticleContext = createContext({} as ParticleEditContext);

export const ParticleEdit = (props) => {
  const { act, data } = useBackend<ParticleUIData>();
  const [desc, setDesc] = useState('');

  const {
    width,
    height,
    count,
    spawning,
    bound1,
    bound2,
    gravity,
    gradient,
    transform,

    icon,
    icon_state,
    lifespan,
    fade,
    fadein,
    color,
    color_change,
    position,
    velocity,
    scale,
    grow,
    rotation,
    spin,
    friction,

    drift,
  } = data.particle_data;

  return (
    <ParticleContext.Provider value={{ desc, setDesc }}>
      <Window
        title={`${data.target_name}的粒子效果`}
        width={940}
        height={890}
      >
        {desc ? <ShowDesc /> : null}
        <Window.Content scrollable>
          <LabeledList>
            <Section
              title={'影响整个粒子系统'}
              buttons={
                <>
                  <Button
                    icon={'question'}
                    onClick={() => setDesc('generator')}
                    tooltip={'生成器说明'}
                  />
                  <Button
                    icon={'sync'}
                    onClick={() => act('new_type')}
                    tooltip={'更改类型'}
                  />
                  <Button
                    icon={'x'}
                    color={'red'}
                    onClick={() => act('delete_and_close')}
                    tooltip={'删除并关闭界面'}
                  />
                </>
              }
            >
              <EntryFloat name={'宽度'} var_name={'width'} float={width} />
              <EntryFloat name={'高度'} var_name={'height'} float={height} />
              <EntryFloat name={'数量上限'} var_name={'count'} float={count} />
              <EntryFloat
                name={'生成速率'}
                var_name={'spawning'}
                float={spawning}
              />
              <EntryCoord
                name={'边界角点1'}
                var_name={'bound1'}
                coord={bound1}
              />
              <EntryCoord
                name={'边界角点2'}
                var_name={'bound2'}
                coord={bound2}
              />
              <EntryCoord
                name={'重力'}
                var_name={'gravity'}
                coord={gravity}
              />
              <EntryGradient
                name={'渐变'}
                var_name={'gradient'}
                gradient={gradient}
              />
              <EntryTransform
                name={'变换'}
                var_name={'transform'}
                transform={transform}
              />
            </Section>
            <Section title={'创建粒子时计算'}>
              <EntryIcon name={'图标'} var_name={'icon'} icon_state={icon} />
              <EntryIconState
                name={'图标状态'}
                var_name={'icon_state'}
                icon_state={icon_state}
              />
              <FloatGenerator
                name={'生命周期'}
                var_name={'lifespan'}
                float={lifespan}
              />
              <FloatGenerator
                name={'淡出'}
                var_name={'fade'}
                float={fade}
              />
              <FloatGenerator
                name={'淡入'}
                var_name={'fadein'}
                float={fadein}
              />
              <FloatGeneratorColor
                name={'颜色'}
                var_name={'color'}
                float={color}
              />
              <FloatGenerator
                name={'颜色变化'}
                var_name={'color_change'}
                float={color_change}
              />
              <EntryGeneratorNumbersList
                name={'位置'}
                var_name={'position'}
                allow_z
                input={position}
              />
              <EntryGeneratorNumbersList
                name={'速度'}
                var_name={'velocity'}
                allow_z
                input={velocity}
              />
              <EntryGeneratorNumbersList
                name={'缩放'}
                var_name={'scale'}
                allow_z={false}
                input={scale}
              />
              <EntryGeneratorNumbersList
                name={'缩放变化'}
                var_name={'grow'}
                allow_z={false}
                input={grow}
              />
              <FloatGenerator
                name={'旋转角度'}
                var_name={'rotation'}
                float={rotation}
              />
              <FloatGenerator name={'自转'} var_name={'spin'} float={spin} />
              <FloatGenerator
                name={'摩擦'}
                var_name={'friction'}
                float={friction}
              />
            </Section>
            <Section title={'每刻计算'}>
              <EntryGeneratorNumbersList
                name={'漂移'}
                var_name={'drift'}
                allow_z
                input={drift}
              />
            </Section>
          </LabeledList>
        </Window.Content>
      </Window>
    </ParticleContext.Provider>
  );
};

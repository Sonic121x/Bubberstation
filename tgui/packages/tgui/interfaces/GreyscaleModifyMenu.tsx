import {
  Box,
  Button,
  ColorBox,
  Divider,
  Flex,
  Icon,
  Image,
  Input,
  LabeledList,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type ColorEntry = {
  index: number;
  label?: string; //BUBBER ADDITION - dynamic uniforms
  value: string;
};

type SpriteData = {
  icon_states: string[];
  finished: string;
  steps: SpriteEntry[];
  time_spent: number;
};

type SpriteEntry = {
  layer: string;
  result: string;
  config_name: string;
};

type GreyscaleMenuData = {
  greyscale_config: string;
  colors: ColorEntry[];
  //BUBBER ADDITION START - dynamic uniforms
  full_color_string?: string;
  hide_full_color_string?: boolean;
  component_style?: ComponentStyleData;
  //BUBBER ADDITION END - dynamic uniforms
  sprites: SpriteData;
  generate_full_preview: boolean;
  unlocked: boolean;
  monitoring_files: boolean;
  sprites_dir: string;
  icon_state: string;
  refreshing: boolean;
};

//BUBBER ADDITION START - dynamic uniforms
type ComponentStyleOption = {
  name: string;
  value: string;
  selected: boolean;
};

type ComponentStyleCore = {
  name: string;
  key: string;
  options: ComponentStyleOption[];
};

type ComponentStyleData = {
  core_components: ComponentStyleCore[];
  accessories: ComponentStyleOption[];
};
//BUBBER ADDITION END - dynamic uniforms

enum Direction {
  North = 'north',
  NorthEast = 'northeast',
  East = 'east',
  SouthEast = 'southeast',
  South = 'south',
  SouthWest = 'southwest',
  West = 'west',
  NorthWest = 'northwest',
}

const DirectionAbbreviation: Record<Direction, string> = {
  [Direction.North]: '北',
  [Direction.NorthEast]: '东北',
  [Direction.East]: '东',
  [Direction.SouthEast]: '东南',
  [Direction.South]: '南',
  [Direction.SouthWest]: '西南',
  [Direction.West]: '西',
  [Direction.NorthWest]: '西北',
};

const ConfigDisplay = (props) => {
  const { act, data } = useBackend<GreyscaleMenuData>();
  return (
    <Section title="设计">
      <LabeledList>
        <LabeledList.Item label="设计类型">
          <Button icon="cogs" onClick={() => act('select_config')} />
          <Input
            value={data.greyscale_config}
            onBlur={(value) =>
              act('load_config_from_string', { config_string: value })
            }
          />
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
//BUBBER ADDITION START - dynamic uniforms
const ComponentStyleDisplay = (props) => {
  const { act, data } = useBackend<GreyscaleMenuData>();
  const style = data.component_style;

  if (!style) {
    return null;
  }

  return (
    <Section title="样式">
      <LabeledList>
        {style.core_components.map((component) => (
          <LabeledList.Item key={component.key} label={component.name}>
            <Flex wrap>
              {component.options.map((item) => (
                <Flex.Item
                  key={`${component.key}-${item.value}`}
                  mr={0.5}
                  mb={0.5}
                >
                  <Button.Checkbox
                    checked={item.selected}
                    onClick={() =>
                      act('component_style_set_core', {
                        component: component.key,
                        value: item.value,
                      })
                    }
                  >
                    {item.name}
                  </Button.Checkbox>
                </Flex.Item>
              ))}
            </Flex>
          </LabeledList.Item>
        ))}
        {!!style.accessories.length && (
          <LabeledList.Item label="配饰">
            <Flex wrap>
              {style.accessories.map((item) => (
                <Flex.Item key={item.value} mr={0.5} mb={0.5}>
                  <Button.Checkbox
                    checked={item.selected}
                    onClick={() =>
                      act('component_style_toggle_accessory', {
                        accessory: item.value,
                      })
                    }
                  >
                    {item.name}
                  </Button.Checkbox>
                </Flex.Item>
              ))}
            </Flex>
          </LabeledList.Item>
        )}
      </LabeledList>
    </Section>
  );
};
//BUBBER ADDITION END - dynamic uniforms

const ColorDisplay = (props) => {
  const { act, data } = useBackend<GreyscaleMenuData>();
  const colors = data.colors || [];
  return (
    <Section title="颜色">
      <LabeledList>
        {/* BUBBER EDIT START - dynamic uniforms */}
        {!data.hide_full_color_string && (
          <LabeledList.Item label="完整颜色字符串">
            <Button
              icon="dice"
              onClick={() => act('random_all_colors')}
              tooltip="随机设置所有颜色组。"
            />
            {!!data.component_style && (
              <Button
                icon="undo"
                onClick={() => act('component_style_reset_all')}
                tooltip="将颜色与样式选项恢复为默认值。"
              />
            )}
            <Input
              value={
                data.full_color_string ||
                colors.map((item) => item.value).join('')
              }
              onBlur={(value) =>
                act('recolor_from_string', { color_string: value })
              }
            />
          </LabeledList.Item>
        )}
        {/* BUBBER EDIT END - dynamic uniforms */}
        {colors.map((item) => (
          <LabeledList.Item
            key={`colorgroup${item.index}${item.value}`}
            label={item.label || `颜色组${item.index}`} //BUBBER EDIT
            color={item.value}
          >
            <ColorBox color={item.value} />{' '}
            <Button
              icon="palette"
              onClick={() => act('pick_color', { color_index: item.index })}
              tooltip="打开颜色选择窗口，替换此颜色组。"
            />
            <Button
              icon="dice"
              onClick={() => act('random_color', { color_index: item.index })}
              tooltip="随机设置此颜色组的颜色。"
            />
            {/* BUBBER EDIT START - dynamic uniforms */}
            {!!data.component_style && (
              <Button
                icon="undo"
                onClick={() =>
                  act('component_style_reset_color', {
                    color_index: item.index,
                  })
                }
                tooltip="将此颜色组恢复为默认值。"
              />
            )}
            {/* BUBBER EDIT END - dynamic uniforms */}
            <Input
              value={item.value}
              width={7}
              onBlur={(value) =>
                act('recolor', { color_index: item.index, new_color: value })
              }
            />
          </LabeledList.Item>
        ))}
      </LabeledList>
    </Section>
  );
};

const PreviewCompassSelect = (props) => {
  return (
    <Box>
      <Stack vertical>
        <Flex>
          <SingleDirection dir={Direction.NorthWest} />
          <SingleDirection dir={Direction.North} />
          <SingleDirection dir={Direction.NorthEast} />
        </Flex>
        <Flex>
          <SingleDirection dir={Direction.West} />
          <Flex.Item grow={1} basis={0}>
            <Button lineHeight={3} m={-0.2} fluid>
              <Icon name="arrows-alt" size={1.5} m="20%" />
            </Button>
          </Flex.Item>
          <SingleDirection dir={Direction.East} />
        </Flex>
        <Flex>
          <SingleDirection dir={Direction.SouthWest} />
          <SingleDirection dir={Direction.South} />
          <SingleDirection dir={Direction.SouthEast} />
        </Flex>
      </Stack>
    </Box>
  );
};

const SingleDirection = (props) => {
  const { dir } = props;
  const { data, act } = useBackend<GreyscaleMenuData>();
  return (
    <Flex.Item grow={1} basis={0}>
      <Button
        tooltip={`将预览图像的朝向设为${DirectionAbbreviation[dir]}`}
        disabled={`${dir}` === data.sprites_dir}
        textAlign="center"
        onClick={() => act('change_dir', { new_sprite_dir: dir })}
        lineHeight={3}
        m={-0.2}
        fluid
      >
        {DirectionAbbreviation[dir]}
      </Button>
    </Flex.Item>
  );
};

const IconStatesDisplay = (props) => {
  const { data, act } = useBackend<GreyscaleMenuData>();
  return (
    <Section title="图标状态">
      <Flex>
        {data.sprites.icon_states.map((item) => (
          <Flex.Item key={item}>
            <Button
              mx={0.5}
              content={item ? item : '空白状态'}
              disabled={item === data.icon_state}
              onClick={() => act('select_icon_state', { new_icon_state: item })}
            />
          </Flex.Item>
        ))}
      </Flex>
    </Section>
  );
};

const PreviewDisplay = (props) => {
  const { data } = useBackend<GreyscaleMenuData>();
  return (
    <Section title={`预览（${DirectionAbbreviation[data.sprites_dir] ?? data.sprites_dir}）`}>
      <Table>
        <Table.Row>
          <Table.Cell width="50%">
            <PreviewCompassSelect />
          </Table.Cell>
          {data.sprites?.finished ? (
            <Table.Cell>
              <Image m={0} mx="10%" src={data.sprites.finished} width="75%" />
            </Table.Cell>
          ) : (
            <Table.Cell>
              <Box>
                <Icon name="image" ml="25%" size={5} />
              </Box>
            </Table.Cell>
          )}
        </Table.Row>
      </Table>
      {!!data.unlocked && `耗时：${data.sprites.time_spent}毫秒`}
      <Divider />
      {!data.refreshing && (
        <Table>
          {!!data.generate_full_preview && data.sprites.steps !== null && (
            <Table.Row header>
              <Table.Cell width="50%" textAlign="center">
                图层来源
              </Table.Cell>
              <Table.Cell width="25%" textAlign="center">
                当前步骤图层
              </Table.Cell>
              <Table.Cell width="25%" textAlign="center">
                当前步骤结果
              </Table.Cell>
            </Table.Row>
          )}
          {!!data.generate_full_preview &&
            data.sprites.steps !== null &&
            data.sprites.steps.map((item) => (
              <Table.Row key={`${item.result}|${item.layer}`}>
                <Table.Cell verticalAlign="middle">
                  {item.config_name}
                </Table.Cell>
                <Table.Cell>
                  <SingleSprite source={item.layer} />
                </Table.Cell>
                <Table.Cell>
                  <SingleSprite source={item.result} />
                </Table.Cell>
              </Table.Row>
            ))}
        </Table>
      )}
    </Section>
  );
};

const SingleSprite = (props) => {
  const { source } = props;
  return <Image src={source} />;
};

const LoadingAnimation = () => {
  return (
    <Box height={0} mt="-100%">
      <Icon name="cog" height={22.7} opacity={0.5} size={25} spin />
    </Box>
  );
};

export const GreyscaleModifyMenu = (props) => {
  const { act, data } = useBackend<GreyscaleMenuData>();
  return (
    <Window title="颜色配置" width={325} height={800}>
      <Window.Content scrollable>
        <ConfigDisplay />
        {/* BUBBER ADDITION START - dynamic uniforms */}
        <ComponentStyleDisplay />
        {/* BUBBER ADDITION END - dynamic uniforms */}
        <ColorDisplay />
        <IconStatesDisplay />
        <Flex direction="column">
          {!!data.unlocked && (
            <Flex.Item justify="flex-start">
              <Button
                content={
                  <Icon name="file-image-o" spin={data.monitoring_files} />
                }
                tooltip="持续检查文件更改，并在需要时重新加载。警告：极其消耗性能。"
                selected={data.monitoring_files}
                onClick={() => act('toggle_mass_refresh')}
                width={1.9}
                mr={-0.2}
              />
              <Button
                content="刷新图标文件"
                tooltip="从磁盘重新加载JSON配置和图标文件，无需重启服务器即可查看更改。警告：消耗性能。"
                onClick={() => act('refresh_file')}
              />
              <Button
                content="保存图标文件"
                tooltip="将图标保存到tmp/中的临时文件，方便在别处使用生成的图标，或查看更准确的效果。"
                onClick={() => act('save_dmi')}
              />
            </Flex.Item>
          )}
          <Flex.Item>
            <Button
              content="应用"
              tooltip="将更改应用到打开此菜单的对象。"
              color="red"
              onClick={() => act('apply')}
            />
            <Button.Checkbox
              content="完整预览"
              tooltip="生成并显示完整的图像生成过程，而非仅显示最终结果。"
              disabled={!data.generate_full_preview && !data.unlocked}
              checked={data.generate_full_preview}
              onClick={() => act('toggle_full_preview')}
            />
          </Flex.Item>
        </Flex>
        <PreviewDisplay />
        {!!data.refreshing && <LoadingAnimation />}
      </Window.Content>
    </Window>
  );
};

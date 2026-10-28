// BUBBER TGUI FILE
import {
  AnimatedNumber,
  Button,
  Divider,
  ImageButton,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';
import { useBackend } from '../backend';
import { Window } from '../layouts';

type ProteanData = {
  metal: number;
  metal_max: number;
  low_power: boolean;
  transformation: boolean;
  lock: boolean;
  assimilated: boolean;
  is_owner: boolean;
  icon: string;
  icon_state: string;
};

export const ProteanUI = () => {
  return (
    <Window width={400} height={300}>
      <Protean />
    </Window>
  );
};

export const Protean = () => {
  const { data, act } = useBackend<ProteanData>();
  const {
    lock,
    metal,
    metal_max,
    icon,
    icon_state,
    low_power,
    transformation,
    assimilated,
    is_owner,
  } = data;

  return (
    <Section
      fill
      title="装甲锁定"
      buttons={
        <Button
          style={{ flex: 0.2 }}
          onClick={() => act('lock')}
          color={lock ? 'bad' : 'good'}
        >
          {lock ? '已锁定' : '已解锁'}
        </Button>
      }
    >
      <NoticeBox color={lock ? 'bad' : 'good'} />
      <Divider />
      <LabeledList>
        <LabeledList.Item label="金属储量">
          <ProgressBar
            value={metal / metal_max}
            ranges={{
              good: [0.5, Infinity],
              average: [0.2, 0.5],
              bad: [-Infinity, 0.2],
            }}
          >
            <AnimatedNumber value={Number(metal?.toFixed(2))} />
          </ProgressBar>
        </LabeledList.Item>
      </LabeledList>
      <Divider />
      <Table>
        <Table.Row header>
          <Table.Cell fontSize="10px" textAlign="center">
            低功耗模式
          </Table.Cell>
          <Table.Cell fontSize="10px" textAlign="center">
            装甲变形
          </Table.Cell>
          <Table.Cell fontSize="10px" textAlign="center">
            修复器官
          </Table.Cell>
          <Table.Cell fontSize="10px" textAlign="center">
            穿戴者变形
          </Table.Cell>
        </Table.Row>
        <Table.Row>
          <Table.Cell textAlign="center">
            <Button
              color={low_power ? 'bad' : 'default'}
              icon="plug"
              onClick={() => act('power')}
            />
          </Table.Cell>
          <Table.Cell textAlign="center">
            <Button
              color="default"
              icon="suitcase"
              onClick={() => act('transform')}
            />
          </Table.Cell>
          <Table.Cell textAlign="center">
            <Button color="default" icon="heart" onClick={() => act('heal')} />
          </Table.Cell>
          <Table.Cell textAlign="center">
            <Button
              color={transformation ? 'good' : 'default'}
              icon="video-camera"
              tooltip="使当前穿戴者暂时变成你的外貌"
              onClick={() => act('protean_transform')}
            />
          </Table.Cell>
        </Table.Row>
      </Table>
      <Divider />
      <Stack justify="flex-end">
        <Stack.Item>
          <Stack vertical align="center">
            <Stack.Item>
              <ImageButton
                dmIcon={icon}
                dmIconState={icon_state}
                style={{ display: 'inline-flex' }}
                tooltipPosition="top"
                tooltip="模块化装甲界面"
                onClick={() => act('openui')}
              />
            </Stack.Item>
            <Stack.Item>
              <Button.Confirm
                fluid
                textAlign="center"
                icon="right-from-bracket"
                color="good"
                confirmColor="bad"
                confirmContent="确定吗？"
                disabled={!assimilated || !is_owner}
                tooltip={
                  assimilated
                    ? '将吸收的模块化装甲从体内取出'
                    : '尚未同化模块化装甲'
                }
                onClick={() => act('eject_modsuit')}
              >
                弹出装甲
              </Button.Confirm>
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

import {
  Button,
  Dropdown,
  LabeledList,
  ProgressBar,
  Section,
  Stack,
} from 'tgui-core/components';
import { capitalize } from 'tgui-core/string';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { InterfaceLockNoticeBox } from './common/InterfaceLockNoticeBox';

type Data = {
  powerStatus: BooleanLike;
  cellPercent: number | null;
  load: BooleanLike;
  loadName : string | null;
  locked: BooleanLike;
  siliconUser: BooleanLike;
  mode: string;
  modeStatus: string;
  autoReturn: BooleanLike;
  autoPickup: BooleanLike;
  reportDelivery: BooleanLike;
  destination: string | null;
  destinationsList: string[];
  homeDestination: string | null;
  botId: string;
  allowPossession: BooleanLike;
  possessionEnabled: BooleanLike;
  paiInserted: BooleanLike;
};

const MuleControls = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    load,
    loadName,
    autoReturn,
    autoPickup,
    reportDelivery,
    destination,
    homeDestination,
    botId,
    allowPossession,
    possessionEnabled,
    paiInserted,
    destinationsList = [],
  } = data;

  return (
    <>
      <Section
        title="控制"
        buttons={
          <>
            {!!load && (
              <Button icon="eject" onClick={() => act('unload')}>
                卸货
              </Button>
            )}
            {!!paiInserted && (
              <Button icon="eject" onClick={() => act('eject_pai')}>
                弹出个人 AI
              </Button>
            )}
          </>
        }
      >
        <LabeledList>
          <LabeledList.Item label="编号">
            <Button onClick={() => act('setid')}>{botId}</Button>
          </LabeledList.Item>
          <LabeledList.Item label="基地">
            <Button onClick={() => act('sethome')}>{homeDestination}</Button>
          </LabeledList.Item>
          <LabeledList.Item label="目的地">
            <Dropdown
              over
              selected={destination || '无'}
              options={destinationsList}
              width="188px"
              onSelected={(value) => act('destination', { value })}
            />
          </LabeledList.Item>
        </LabeledList>
      </Section>
      <Section title="操作">
        <Stack style={{ padding: '0px 30px' }}>
          <Stack.Item grow>
            <Button
              width="60px"
              icon="stop"
              color="bad"
              onClick={() => act('stop')}
            >
              停止
            </Button>
          </Stack.Item>
          <Stack.Item grow>
            <Button
              width="60px"
              icon="play"
              color="average"
              onClick={() => act('go')}
            >
              出发
            </Button>
          </Stack.Item>
          <Stack.Item>
            <Button width="60px" icon="home" onClick={() => act('home')}>
              返回基地
            </Button>
          </Stack.Item>
        </Stack>
      </Section>
      <Section title="设置">
        <Button.Checkbox checked={autoReturn} onClick={() => act('autored')}>
          自动返回
        </Button.Checkbox>
        <br />
        <Button.Checkbox checked={autoPickup} onClick={() => act('autopick')}>
          自动装货
        </Button.Checkbox>
        <br />
        <Button.Checkbox checked={reportDelivery} onClick={() => act('report')}>
          报告送达
        </Button.Checkbox>
        <br />
        {!!allowPossession && (
          <Button.Checkbox
            checked={possessionEnabled}
            onClick={() => act('toggle_personality')}
          >
            下载人格
          </Button.Checkbox>
        )}
      </Section>
    </>
  );
};

export const Mule = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    powerStatus,
    cellPercent,
    load,
    loadName,
    mode,
    modeStatus,
    locked,
    siliconUser,
  } = data;

  const mulebotLocked = locked && !siliconUser;

  return (
    <Window width={350} height={540}>
      <Window.Content scrollable>
        <InterfaceLockNoticeBox />
        <Section
          title="状态"
          buttons={
            <>
              <Button icon="fa-poll-h" onClick={() => act('rename')}>
                重命名
              </Button>
              {!mulebotLocked && (
                <Button
                  icon={powerStatus ? 'power-off' : 'times'}
                  selected={powerStatus}
                  onClick={() => act('on')}
                >
                  {powerStatus ? '开启' : '关闭'}
                </Button>
              )}
            </>
          }
        >
          <ProgressBar
            value={cellPercent ? cellPercent / 100 : 0}
            color={cellPercent ? 'good' : 'bad'}
          />
          <Stack mt={1} vertical>
            <Stack.Item grow>
              <LabeledList>
                <LabeledList.Item label="模式" color={modeStatus}>
                  {mode}
                </LabeledList.Item>
                <LabeledList.Item
                  label="货物"
                  color={load ? 'good' : 'average'}
                >
                  {load ? capitalize(loadName ?? '') : '无'}
                </LabeledList.Item>
              </LabeledList>
            </Stack.Item>
          </Stack>
        </Section>
        {!mulebotLocked && <MuleControls />}
      </Window.Content>
    </Window>
  );
};

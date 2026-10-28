import { useBackend } from 'tgui/backend';
import {
  Button,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
  Stack,
} from 'tgui-core/components';
import { capitalizeFirst } from 'tgui-core/string';

import type { Data } from './types';

/** Displays loaded container info, if it exists */
export const BeakerDisplay = (props) => {
  const { act, data } = useBackend<Data>();
  const { has_beaker, beaker, has_blood } = data;
  const cant_empty = !has_beaker || !beaker?.volume;
  let content;
  if (!has_beaker) {
    content = <NoticeBox>未装入烧杯。</NoticeBox>;
  } else if (!beaker?.volume) {
    content = <NoticeBox>烧杯为空。</NoticeBox>;
  } else if (!has_blood) {
    content = <NoticeBox>未装入血液样本。</NoticeBox>;
  } else {
    content = (
      <Stack vertical>
        <Stack.Item>
          <Info />
        </Stack.Item>
        <Stack.Item>
          <Antibodies />
        </Stack.Item>
      </Stack>
    );
  }

  return (
    <Section
      title="烧杯"
      buttons={
        <>
          <Button
            icon="times"
            content="清空并弹出"
            color="bad"
            disabled={cant_empty}
            onClick={() => act('empty_eject_beaker')}
          />
          <Button
            icon="trash"
            content="清空"
            disabled={cant_empty}
            onClick={() => act('empty_beaker')}
          />
          <Button
            icon="eject"
            content="弹出"
            disabled={!has_beaker}
            onClick={() => act('eject_beaker')}
          />
        </>
      }
    >
      {content}
    </Section>
  );
};

/** Displays info about the blood type, beaker capacity - volume */
const Info = (props) => {
  const { data } = useBackend<Data>();
  const { beaker, blood } = data;
  if (!beaker || !blood) {
    return <NoticeBox>未装入烧杯</NoticeBox>;
  }

  return (
    <Stack>
      <Stack.Item grow={2}>
        <LabeledList>
          <LabeledList.Item label="DNA">
            {capitalizeFirst(blood.dna)}
          </LabeledList.Item>
          <LabeledList.Item label="血型">
            {capitalizeFirst(blood.type)}
          </LabeledList.Item>
        </LabeledList>
      </Stack.Item>
      <Stack.Item grow={2}>
        <LabeledList>
          <LabeledList.Item label="容器">
            <ProgressBar
              color="darkred"
              value={beaker.volume}
              minValue={0}
              maxValue={beaker.capacity}
              ranges={{
                good: [beaker.capacity * 0.85, beaker.capacity],
                average: [beaker.capacity * 0.25, beaker.capacity * 0.85],
                bad: [0, beaker.capacity * 0.25],
              }}
            />
          </LabeledList.Item>
        </LabeledList>
      </Stack.Item>
    </Stack>
  );
};

/** If antibodies are present, returns buttons to create vaccines */
const Antibodies = (props) => {
  const { act, data } = useBackend<Data>();
  const { is_ready, resistances = [] } = data;
  if (!resistances) {
    return <NoticeBox>未检测到任何内容</NoticeBox>;
  }

  return (
    <LabeledList>
      <LabeledList.Item label="抗体">
        {!resistances.length
          ? '无'
          : resistances.map((resistance) => {
              return (
                <Button
                  key={resistance.name}
                  icon="eye-dropper"
                  disabled={!is_ready}
                  tooltip="制作一瓶疫苗。"
                  onClick={() =>
                    act('create_vaccine_bottle', {
                      index: resistance.id,
                    })
                  }
                >
                  {`${resistance.name}`}
                </Button>
              );
            })}
      </LabeledList.Item>
    </LabeledList>
  );
};

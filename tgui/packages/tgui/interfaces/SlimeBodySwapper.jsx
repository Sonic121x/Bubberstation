import { Box, Button, LabeledList, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

const statusMap = {
  Dead: 'bad',
  Unconscious: 'average',
  Conscious: 'good',
};

const occupiedMap = {
  owner: '你在此处',
  stranger: '已被占用',
  available: '切换',
};

export const BodyEntry = (props) => {
  const { body, swapFunc } = props;
  return (
    <Section
      title={
        <Box inline color={body.htmlcolor}>
          {body.name}
        </Box>
      }
      level={2}
      buttons={
        <Button
          content={occupiedMap[body.occupied]}
          selected={body.occupied === 'owner'}
          color={body.occupied === 'stranger' && 'bad'}
          onClick={() => swapFunc()}
        />
      }
    >
      <LabeledList>
        <LabeledList.Item label="状态" bold color={statusMap[body.status]}>
          {({ Dead: '死亡', Unconscious: '昏迷', Conscious: '清醒' })[body.status] ?? body.status}
        </LabeledList.Item>
        <LabeledList.Item label="胶质">{body.exoticblood}</LabeledList.Item>
        <LabeledList.Item label="位置">{body.area}</LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

export const SlimeBodySwapper = (props) => {
  const { act, data } = useBackend();
  const { bodies = [] } = data;
  return (
    <Window width={400} height={400}>
      <Window.Content scrollable>
        <Section>
          {bodies.map((body) => (
            <BodyEntry
              key={body.name}
              body={body}
              swapFunc={() => act('swap', { ref: body.ref })}
            />
          ))}
        </Section>
      </Window.Content>
    </Window>
  );
};

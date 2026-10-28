import { useBackend } from 'tgui/backend';
import { Window } from 'tgui/layouts';
import { Box, Button, Image, LabeledList, Stack } from 'tgui-core/components';

type SpriteAuditorEntry = {
  ref: string;
  name: string;
  ckey: string;
  timestamp: string;
};

type SpriteAuditorData = {
  entries?: SpriteAuditorEntry[];
};

export const SpriteAuditor = (props) => {
  const { act, data } = useBackend<SpriteAuditorData>();
  const { entries } = data;
  return (
    <Window width={360} height={720} title="图像审核器">
      <Window.Content>
        <Stack vertical overflowY="scroll">
          {entries?.map((entry, i) => {
            const { ref, name, ckey, timestamp } = entry;
            return (
              <Stack.Item
                key={i}
                height="120px"
                className="SpriteAuditor_EntryCell"
              >
                <Stack fill align="center">
                  <Stack.Item width="120px">
                    <Image fixErrors src={ref} />
                  </Stack.Item>
                  <Stack.Item grow>
                    <LabeledList>
                      <LabeledList.Item label="创建时间">
                        {timestamp}
                      </LabeledList.Item>
                      <LabeledList.Item label="创建者">
                        <Box inline>{`${name} (${ckey})`}</Box>
                        <Button
                          inline
                          tooltip="显示玩家面板"
                          onClick={() => act('playerPanel', { ckey })}
                        >
                          玩家面板
                        </Button>
                      </LabeledList.Item>
                    </LabeledList>
                  </Stack.Item>
                </Stack>
              </Stack.Item>
            );
          })}
        </Stack>
      </Window.Content>
    </Window>
  );
};

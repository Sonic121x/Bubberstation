import { sortBy } from 'es-toolkit';
import { useState } from 'react';
import { Box, Button, LabeledList, Section, Stack } from 'tgui-core/components';
import { classes } from 'tgui-core/react';
import { capitalize } from 'tgui-core/string';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { chineseDisplay } from '../localization/zhDisplay';
type FishingTips = {
  spots: string;
  difficulty: string;
  favorite_bait: string;
  disliked_bait: string;
  traits: string[];
};

type FishInfo = {
  name: string;
  desc: string;
  fluid: string;
  temp_min: number;
  temp_max: number;
  feed: string;
  source: string;
  fishing_tips: FishingTips;
  weight: string;
  size: string;
  icon: string;
  beauty: string;
};

type FishCatalogData = {
  fish_info: FishInfo[] | null;
  sponsored_by: string;
};

export const FishCatalog = (props) => {
  const { act, data } = useBackend<FishCatalogData>();
  const { fish_info, sponsored_by } = data;
  const fish_by_name = sortBy(fish_info || [], [(fish: FishInfo) => fish.name]);
  const [currentFish, setCurrentFish] = useState<FishInfo | null>(null);
  return (
    <Window width={500} height={300}>
      <Window.Content>
        <Stack fill>
          <Stack.Item width="140px">
            <Section fill scrollable>
              {fish_by_name.map((f) => (
                <Button
                  key={f.name}
                  fluid
                  color="transparent"
                  selected={f === currentFish}
                  onClick={() => {
                    setCurrentFish(f);
                  }}
                >
                  {f.name}
                </Button>
              ))}
            </Section>
          </Stack.Item>
          <Stack.Item grow basis={0}>
            <Section
              fill
              scrollable
              title={
                currentFish
                  ? capitalize(currentFish.name)
                  : `${sponsored_by}鱼类图鉴`
              }
            >
              {currentFish && (
                <LabeledList>
                  <LabeledList.Item label="描述">
                    {currentFish.desc}
                  </LabeledList.Item>
                  <LabeledList.Item label="水体类型">
                    {chineseDisplay(currentFish.fluid)}
                  </LabeledList.Item>
                  <LabeledList.Item label="温度">
                    {currentFish.temp_min}至{currentFish.temp_max}
                  </LabeledList.Item>
                  <LabeledList.Item label="饲料">
                    {currentFish.feed}
                  </LabeledList.Item>
                  <LabeledList.Item label="获取方式">
                    {currentFish.source}
                  </LabeledList.Item>
                  <LabeledList.Item label="平均体长">
                    {currentFish.size} cm
                  </LabeledList.Item>
                  <LabeledList.Item label="平均体重">
                    {currentFish.weight} 千蛤
                  </LabeledList.Item>
                  <LabeledList.Item label="水族箱观赏评分">
                    {currentFish.beauty}
                  </LabeledList.Item>
                  <LabeledList.Item label="垂钓与饲养提示">
                    <LabeledList>
                      <LabeledList.Item label="垂钓地点">
                        {currentFish.fishing_tips.spots}
                      </LabeledList.Item>
                      <LabeledList.Item label="喜爱的鱼饵">
                        {currentFish.fishing_tips.favorite_bait}
                      </LabeledList.Item>
                      <LabeledList.Item label="不喜爱的鱼饵">
                        {currentFish.fishing_tips.disliked_bait}
                      </LabeledList.Item>
                      <LabeledList.Item label="行为">
                        {currentFish.fishing_tips.traits}
                      </LabeledList.Item>
                    </LabeledList>
                  </LabeledList.Item>
                  <LabeledList.Item label="插图">
                    <Box className={classes(['fish32x32', currentFish.icon])} />
                  </LabeledList.Item>
                </LabeledList>
              )}
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

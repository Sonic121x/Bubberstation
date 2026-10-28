import { Button, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { ReagentLookup } from '../common/ReagentLookup';
import { RecipeLookup } from '../common/RecipeLookup';
import { bookmarkedReactions } from '.';
import type { ReagentsData } from './types';

export function Lookup() {
  const { act, data } = useBackend<ReagentsData>();
  const { beakerSync, reagent_mode_recipe, reagent_mode_reagent } = data;

  return (
    <Stack fill>
      <Stack.Item grow basis={0}>
        <Section
          title="配方查询"
          minWidth="353px"
          buttons={
            <>
              <Button
                icon="atom"
                color={beakerSync ? 'green' : 'red'}
                tooltip="启用后，会自动显示关联烧杯中正在进行的反应。"
                onClick={() => act('beaker_sync')}
              >
                同步烧杯
              </Button>
              <Button
                icon="search"
                color="purple"
                tooltip="按产物名称搜索配方"
                onClick={() => act('search_recipe')}
              >
                搜索
              </Button>
              <Button
                icon="times"
                color="red"
                disabled={!reagent_mode_recipe}
                onClick={() =>
                  act('recipe_click', {
                    id: null,
                  })
                }
              />
            </>
          }
        >
          <RecipeLookup
            recipe={reagent_mode_recipe}
            bookmarkedReactions={bookmarkedReactions}
          />
        </Section>
      </Stack.Item>
      <Stack.Item grow basis={0}>
        <Section
          title="试剂查询"
          minWidth="300px"
          buttons={
            <>
              <Button
                icon="search"
                tooltip="按名称搜索试剂"
                tooltipPosition="left"
                onClick={() => act('search_reagents')}
              >
                搜索
              </Button>
              <Button
                icon="times"
                color="red"
                disabled={!reagent_mode_reagent}
                onClick={() =>
                  act('reagent_click', {
                    id: null,
                  })
                }
              />
            </>
          }
        >
          <ReagentLookup reagent={reagent_mode_reagent} />
        </Section>
      </Stack.Item>
    </Stack>
  );
}

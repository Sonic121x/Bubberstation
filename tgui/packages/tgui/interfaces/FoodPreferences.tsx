// THIS IS A SKYRAT UI FILE
import {
  Box,
  Button,
  Dimmer,
  Divider,
  Icon,
  Section,
  Stack,
  StyleableSection,
  Tooltip,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { interfaceUtilityDisplay } from '../localization/interfaceUtilityDisplay';
type Data = {
  food_types: Record<string, number>;
  obscure_food_types: string;
  selection: Record<string, number>;
  enabled: boolean;
  invalid: string;
  race_disabled: boolean;
};

const FOOD_TOXIC = 1;
const FOOD_DISLIKED = 2;
const FOOD_NEUTRAL = 3;
const FOOD_LIKED = 4;
const DEFAULT_FOOD_VALUE = 4;
const OBSCURE_FOOD = 5;

export const FoodPreferences = (props) => {
  const { act, data } = useBackend<Data>();

  return (
    <Window width={1300} height={600}>
      <Window.Content scrollable>
        {
          <StyleableSection
            style={{
              'margin-bottom': '1em',
              'break-inside': 'avoid-column',
            }}
            titleStyle={{
              'justify-content': 'center',
            }}
            title={
              <Box>
                <Tooltip
                  position="bottom"
                  content={
                    '必须选择至少一种有毒食物和三种不喜欢的食物。最多可选择三种喜欢的食物。'
                  }
                >
                  <Box inline>
                    <Button icon="circle-question" mr="0.5em" />
                    {data.invalid ? (
                      <Box as="span" color="#bd2020">
                        偏好设置无效！{' '}
                        {data.invalid.charAt(0).toUpperCase() +
                          data.invalid.slice(1)}{' '}
                        |&nbsp;
                      </Box>
                    ) : (
                      <Box as="span" color="green">
                        偏好设置有效！
                      </Box>
                    )}
                  </Box>
                </Tooltip>

                <Button
                  style={{ position: 'absolute', right: '20em' }}
                  color={'red'}
                  onClick={() => act('reset')}
                  tooltip="恢复默认设置！"
                >
                  重置
                </Button>

                <Button
                  style={{ position: 'absolute', right: '0.5em' }}
                  icon={data.enabled ? 'check-square-o' : 'square-o'}
                  color={data.enabled ? 'green' : 'red'}
                  onClick={() => act('toggle')}
                  disabled={data.race_disabled}
                  tooltip={
                    <>
                      切换是否在角色生成时应用这些
                      饮食偏好。
                      <Divider />
                      请记住，这些主要是参考建议。即使没有
                      在此将某类食物设为喜欢，也鼓励你在
                      角色扮演中表现出角色对特定菜肴的
                      喜爱！
                    </>
                  }
                >
                  使用自定义饮食偏好
                </Button>
              </Box>
            }
          >
            {(data.race_disabled && (
              <ErrorOverlay>
                你所选的种族不受饮食
                偏好影响！
              </ErrorOverlay>
            )) ||
              (!data.enabled && (
                <ErrorOverlay>你的饮食偏好已禁用！</ErrorOverlay>
              ))}
            <Box style={{ columns: '30em' }}>
              {Object.entries(data.food_types).map((element) => {
                const { 0: foodName, 1: foodPointValues } = element;
                return (
                  <Box key={foodName}>
                    <Section
                      title={
                        <>
                          {interfaceUtilityDisplay(foodName)}
                          {data.obscure_food_types[foodName] && (
                            <Tooltip content="此食物不占喜欢的食物名额，可以自由选择！">
                              <Box
                                as="span"
                                fontSize={0.75}
                                verticalAlign={'top'}
                              >
                                <Icon name="star" style={{ color: 'orange' }} />
                              </Box>
                            </Tooltip>
                          )}
                        </>
                      }
                    >
                      <FoodButton
                        foodName={foodName}
                        foodPreference={FOOD_TOXIC}
                        selected={
                          data.selection[foodName] === FOOD_TOXIC ||
                          (!data.selection[foodName] &&
                            foodPointValues === FOOD_TOXIC)
                        }
                        content={<>有毒</>}
                        color="olive"
                        tooltip="你的角色吃下有毒食物后几乎会立即呕吐。"
                      />
                      <FoodButton
                        foodName={foodName}
                        foodPreference={FOOD_DISLIKED}
                        selected={
                          data.selection[foodName] === FOOD_DISLIKED ||
                          (!data.selection[foodName] &&
                            foodPointValues === FOOD_DISLIKED)
                        }
                        content={<>不喜欢</>}
                        color="red"
                        tooltip="你的角色会感到恶心，吃下较多不喜欢的食物后最终会呕吐。"
                      />
                      <FoodButton
                        foodName={foodName}
                        foodPreference={FOOD_NEUTRAL}
                        selected={
                          data.selection[foodName] === FOOD_NEUTRAL ||
                          (!data.selection[foodName] &&
                            foodPointValues === FOOD_NEUTRAL)
                        }
                        content={<>一般</>}
                        color="yellow"
                        tooltip="你的角色对这类食物没有特别感受。"
                      />
                      <FoodButton
                        foodName={foodName}
                        foodPreference={FOOD_LIKED}
                        selected={
                          data.selection[foodName] === FOOD_LIKED ||
                          (!data.selection[foodName] &&
                            foodPointValues === FOOD_LIKED)
                        }
                        content={<>喜欢</>}
                        color="green"
                        tooltip="你的角色会享受喜欢的食物。"
                      />
                    </Section>
                  </Box>
                );
              })}
            </Box>
          </StyleableSection>
        }
      </Window.Content>
    </Window>
  );
};

const FoodButton = (props) => {
  const { act } = useBackend();
  const { foodName, foodPreference, color, selected, ...rest } = props;
  return (
    <Button
      icon={selected ? 'check-square-o' : 'square-o'}
      color={selected ? color : 'grey'}
      onClick={() =>
        act('change_food', {
          food_name: foodName,
          food_preference: foodPreference,
        })
      }
      {...rest}
    />
  );
};

const ErrorOverlay = (props) => {
  return (
    <Dimmer>
      <Stack vertical mt="5.2em">
        <Stack.Item color="#bd2020" textAlign="center">
          {props.children}
        </Stack.Item>
      </Stack>
    </Dimmer>
  );
};

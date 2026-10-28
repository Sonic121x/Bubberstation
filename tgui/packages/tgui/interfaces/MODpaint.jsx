import {
  Box,
  Button,
  ByondUi,
  Flex,
  Section,
  Slider,
  Stack,
} from 'tgui-core/components';
import { capitalize } from 'tgui-core/string';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { chineseDisplay as zh } from '../localization/zhDisplay';
const colorToMatrix = (param) => {
  switch (param) {
    case 'red':
      return [
        1, 0, 0, 0, 0.25, 0.5, 0, 0, 0.25, 0, 0.5, 0, 0, 0, 0, 1, 0, 0, 0, 0,
      ];
    case 'yellow':
      return [
        0.5, 0.5, 0, 0, 0.5, 0.5, 0, 0, 0.25, 0.25, 0.5, 0, 0, 0, 0, 1, 0, 0, 0,
        0,
      ];
    case 'green':
      return [
        0.5, 0.25, 0, 0, 0, 1, 0, 0, 0, 0.25, 0.5, 0, 0, 0, 0, 1, 0, 0, 0, 0,
      ];
    case 'teal':
      return [
        0.25, 0.25, 0.25, 0, 0, 0.5, 0.5, 0, 0, 0.5, 0.5, 0, 0, 0, 0, 1, 0, 0,
        0, 0,
      ];
    case 'blue':
      return [
        0.25, 0, 0.25, 0, 0, 0.5, 0.25, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0,
      ];
    case 'purple':
      return [
        0.5, 0, 0.5, 0, 0.25, 0.5, 0.25, 0, 0.5, 0, 0.5, 0, 0, 0, 0, 1, 0, 0, 0,
        0,
      ];
  }
};

const displayText = (param) => {
  switch (param) {
    case 'r':
      return '红色';
    case 'g':
      return '绿色';
    case 'b':
      return '蓝色';
  }
};

export const MODpaint = (props) => {
  const { act, data } = useBackend();
  const { mapRef, currentColor } = data;
  const presets = ['red', 'yellow', 'green', 'teal', 'blue', 'purple'];
  const prefixes = ['r', 'g', 'b'];
  return (
    <Window width={600} height={365}>
      <Window.Content>
        <Stack fill>
          <Stack.Item fill width="30%">
            {[0, 1, 2].map((row) => (
              <Section
                key={row}
                title={`${displayText(prefixes[row])}转换为：`}
              >
                {[0, 1, 2].map((col) => (
                  <Flex key={col}>
                    <Flex.Item align="left" width="30%">
                      <Box inline textColor="label">
                        {`${displayText(prefixes[col])}:`}
                      </Box>
                    </Flex.Item>
                    <Flex.Item align="right" width="70%">
                      <Slider
                        inline
                        textAlign="right"
                        value={currentColor[row * 4 + col] * 100}
                        minValue={0}
                        maxValue={125}
                        step={1}
                        stepPixelSize={0.75}
                        format={(value) => `${value}%`}
                        onChange={(e, value) => {
                          const retColor = currentColor;
                          retColor[row * 4 + col] = value / 100;
                          act('transition_color', { color: retColor });
                        }}
                      />
                    </Flex.Item>
                  </Flex>
                ))}
              </Section>
            ))}
          </Stack.Item>
          <Stack.Item width="25%">
            <Section height="70%" title="预设">
              <Box textAlign="center">
                {presets.map((preset) => (
                  <Button
                    key={preset}
                    height="50px"
                    width="50px"
                    color={preset}
                    tooltipPosition="top"
                    tooltip={preset === 'teal' ? '蓝绿色' : zh(capitalize(preset))}
                    onClick={() =>
                      act('transition_color', { color: colorToMatrix(preset) })
                    }
                  />
                ))}
              </Box>
            </Section>
            <Section textAlign="center" fontSize="28px">
              <Button
                height="50px"
                width="50px"
                icon="question"
                color="average"
                tooltipPosition="top"
                tooltip="这是颜色矩阵。可以把它理解为分别编辑图像的红、绿、蓝三个通道，而不是像普通 RGB 调色那样直接更改最终颜色。"
              />
              <Button
                height="50px"
                width="50px"
                icon="check"
                color="good"
                tooltipPosition="top"
                tooltip="确认更改！"
                onClick={() => act('confirm')}
              />
            </Section>
          </Stack.Item>
          <Stack.Item width="45%">
            <Section fill title="预览">
              <ByondUi
                height="230px"
                params={{
                  id: mapRef,
                  type: 'map',
                }}
              />
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

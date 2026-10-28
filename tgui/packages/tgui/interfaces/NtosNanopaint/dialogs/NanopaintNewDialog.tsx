import { useState } from 'react';
import { sendAct as act } from 'tgui/events/act';
import {
  Box,
  Button,
  Dimmer,
  Floating,
  LabeledList,
  NumberInput,
  Section,
  Stack,
} from 'tgui-core/components';

type NanopaintNewDialogProps = {
  minSize: number;
  maxSize: number;
  templateSizes: Record<string, [number, number]>;
};

export const NanopaintNewDialog = (props: NanopaintNewDialogProps) => {
  const { minSize, maxSize, templateSizes } = props;
  const [width, setWidth] = useState(32);
  const [height, setHeight] = useState(32);
  const [templatesOpen, setTemplatesOpen] = useState(false);
  return (
    <Dimmer>
      <Section title="新建项目">
        <Stack vertical>
          <Stack.Item>
            <LabeledList>
              <LabeledList.Item label="宽度">
                <NumberInput
                  value={width}
                  minValue={minSize}
                  maxValue={maxSize}
                  step={1}
                  onChange={(v) => setWidth(Math.round(v))}
                />
              </LabeledList.Item>
              <LabeledList.Item label="高度">
                <NumberInput
                  value={height}
                  minValue={minSize}
                  maxValue={maxSize}
                  step={1}
                  onChange={(v) => setHeight(Math.round(v))}
                />
              </LabeledList.Item>
            </LabeledList>
          </Stack.Item>
          <Stack.Item>
            <Floating
              handleOpen={templatesOpen}
              disabled
              placement="right"
              preventPortal
              content={
                <Box maxHeight="75%" overflowY="scroll">
                  {Object.entries(templateSizes).map(
                    ([name, [templateWidth, templateHeight]], i) => (
                      <Button
                        className="NtosNanopaint__NewDialog__TemplateCell"
                        key={i}
                        width="100%"
                        onClick={() => {
                          setWidth(templateWidth);
                          setHeight(templateHeight);
                        }}
                      >
                        <Stack align="center" justify="space-between">
                          <Stack.Item fontSize="24px">{name}</Stack.Item>
                          <Stack.Item>
                            <Box
                              className="NtosNanopaint__NewDialog__TemplatePreview"
                              width={`${templateWidth * 3}px`}
                              height={`${templateHeight * 3}px`}
                            />
                          </Stack.Item>
                        </Stack>
                      </Button>
                    ),
                  )}
                </Box>
              }
            >
              <Button
                icon={templatesOpen ? 'chevron-left' : 'chevron-right'}
                iconPosition="right"
                onClick={() => setTemplatesOpen(!templatesOpen)}
              >
                模板尺寸
              </Button>
            </Floating>
          </Stack.Item>
          <Stack.Item>
            <Stack fill justify="end">
              <Stack.Item>
                <Button onClick={() => act('new', { width, height })}>
                  确定
                </Button>
              </Stack.Item>
              <Stack.Item>
                <Button onClick={() => act('closeDialog')}>取消</Button>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Section>
    </Dimmer>
  );
};

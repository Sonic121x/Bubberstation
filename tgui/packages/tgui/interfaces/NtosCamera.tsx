import {
  Box,
  Button,
  Image,
  Input,
  NoticeBox,
  Slider,
  Stack,
  TextArea,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';

type NtosCameraCommonData = {
  width: number;
  height: number;
  size: string;
  minSize: number;
  maxSize: number;
  maxNameLength: number;
  maxDescLength: number;
  maxCaptionLength: number;
  printCost: number;
};

type NtosCameraPictureData = {
  photo: string;
  canEditMetadata: BooleanLike;
  name?: string;
  desc?: string;
  caption?: string;
  storedPaper: number;
};

type NtosCameraData =
  | NtosCameraCommonData
  | (NtosCameraCommonData & NtosCameraPictureData);

export const NtosCamera = (props) => {
  return (
    <NtosWindow width={400} height={600}>
      <NtosWindow.Content scrollable>
        <NtosCameraContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};

export const NtosCameraContent = (props) => {
  const { act, data } = useBackend<NtosCameraData>();
  const {
    width,
    height,
    size,
    minSize,
    maxSize,
    maxNameLength,
    maxDescLength,
    maxCaptionLength,
    printCost,
    photo,
    canEditMetadata,
    name,
    desc,
    caption,
    storedPaper,
  } = data;

  return (
    <Stack fill vertical width="100%">
      {photo ? (
        <>
          <Stack.Item align="center">
            <Image
              width="auto"
              minWidth="50%"
              maxWidth="100%"
              height="auto"
              fixErrors
              src={`data:image/jpeg;base64,${photo}`}
            />
          </Stack.Item>
          <Stack.Item>
            <Box bold textColor="label">
              名称：
            </Box>
            <Input
              fluid
              disabled={!canEditMetadata}
              value={name}
              maxLength={maxNameLength}
              onChange={(value) =>
                act('setName', {
                  value: value,
                })
              }
            />
          </Stack.Item>
          <Stack.Item>
            <Box bold textColor="label">
              描述：
            </Box>
            <Input
              fluid
              disabled={!canEditMetadata}
              value={desc}
              maxLength={maxDescLength}
              onChange={(value) =>
                act('setDesc', {
                  value: value,
                })
              }
            />
          </Stack.Item>
          <Stack.Item>
            <Box bold textColor="label">
              图片说明：
            </Box>
            <TextArea
              height="6rem"
              fluid
              disabled={!canEditMetadata}
              value={caption}
              maxLength={maxCaptionLength}
              onChange={(value) =>
                act('setCaption', {
                  value: value,
                })
              }
            />
          </Stack.Item>
          <Stack.Item align="center">
            <Button onClick={() => act('savePhoto')}>保存照片</Button>
          </Stack.Item>
          <Stack.Item align="center">
            <Button
              disabled={storedPaper! < printCost}
              tooltip={
                !storedPaper &&
                `打印一张照片至少需要 ${printCost} 张纸。`
              }
              onClick={() => act('printPhoto')}
            >
              打印照片
            </Button>
          </Stack.Item>
        </>
      ) : (
        <Stack.Item>
          <NoticeBox>
            纳米传讯影像——手持平板电脑，
            轻点目标（右键）即可拍照！
          </NoticeBox>
        </Stack.Item>
      )}
      <Stack.Item align="center">{size}</Stack.Item>
      <Stack.Item align="center">
        <Box bold inline textColor="label" mr="0.5rem">
          取景半宽：
        </Box>
        <Slider
          inline
          value={width}
          minValue={minSize}
          maxValue={maxSize}
          step={1}
          onChange={(e, value) =>
            act('adjustWidth', {
              value: value,
            })
          }
        />
      </Stack.Item>
      <Stack.Item align="center">
        <Box bold inline textColor="label" mr="0.5rem">
          取景半高：
        </Box>
        <Slider
          inline
          value={height}
          minValue={minSize}
          maxValue={maxSize}
          step={1}
          onChange={(e, value) =>
            act('adjustHeight', {
              value: value,
            })
          }
        />
      </Stack.Item>
    </Stack>
  );
};

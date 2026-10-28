import type { Dispatch, SetStateAction } from 'react';
import {
  Box,
  Button,
  Collapsible,
  Divider,
  LabeledList,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../../backend';
import { logger } from '../../logging';
import { ListMapper } from './ListMapper';
import type { LuaEditorData, LuaEditorModal } from './types';

const parsePanic = (name, panic_json) => {
  const panic_info = JSON.parse(panic_json);
  const {
    message,
    location: { file, line },
    backtrace,
  } = panic_info;
  return (
    <>
      <Box textColor="red">
        <b>{name}</b> 在 {file}:{line} 发生严重错误：{message}
      </Box>
      <Collapsible title="调用回溯">
        <Stack vertical>
          {backtrace
            ?.filter(
              (frame) => frame.file !== undefined && frame.line !== undefined,
            )
            ?.map(({ name, file, line }, i) => (
              <>
                {i > 0 && <Divider />}
                <Stack.Item key={i}>
                  <LabeledList>
                    <LabeledList.Item label="函数">{name}</LabeledList.Item>
                    <LabeledList.Item label="位置">
                      {file}:{line}
                    </LabeledList.Item>
                  </LabeledList>
                </Stack.Item>
              </>
            ))}
        </Stack>
      </Collapsible>
    </>
  );
};

type LogProps = {
  setViewedChunk: Dispatch<SetStateAction<string | undefined>>;
  setModal: Dispatch<SetStateAction<LuaEditorModal>>;
};

export const Log = (props: LogProps) => {
  const { act, data } = useBackend<LuaEditorData>();
  const { stateLog } = data;
  const { setViewedChunk, setModal } = props;

  return stateLog.map((element, i) => {
    const { status, repeats } = element;
    let output;
    let messageColor;
    switch (status) {
      case 'sleep': {
        const { chunk, name } = element;
        if (chunk) {
          messageColor = 'blue';
          output = (
            <>
              <b>{name}</b> 已休眠。
            </>
          );
        }
        break;
      }
      case 'yield': {
        const { name, return_values, variants } = element;
        output = (
          <>
            <b>{name}</b> 已让出执行权
            {return_values.length
              ? `，返回 ${return_values.length} 个值${
                  return_values.length > 1 ? '' : ''
                }`
              : ''}
            。
            {return_values.length ? (
              <ListMapper
                list={return_values}
                variants={variants}
                skipNulls
                name="返回值"
                collapsible
                vvAct={(path) =>
                  act('vvReturnValue', {
                    entryIndex: i + 1,
                    indices: path,
                  })
                }
              />
            ) : (
              <br />
            )}
          </>
        );
        messageColor = 'yellow';
        break;
      }
      case 'finished': {
        const { name, return_values, variants } = element;
        output = (
          <>
            <b>{name}</b> 已返回
            {return_values.length
              ? ` ${return_values.length} 个值${
                  return_values.length > 1 ? '' : ''
                }`
              : ''}
            。
            {return_values.length ? (
              <Box color="default">
                <ListMapper
                  list={return_values}
                  variants={variants}
                  skipNulls
                  name="返回值"
                  collapsible
                  vvAct={(path) =>
                    act('vvReturnValue', {
                      entryIndex: i + 1,
                      tableIndices: path,
                    })
                  }
                />
              </Box>
            ) : (
              <br />
            )}
          </>
        );
        messageColor = 'green';
        break;
      }
      case 'error': {
        const { message } = element;
        output = message;
        messageColor = 'red';
        break;
      }
      case 'panic': {
        const { name, message } = element;
        output = parsePanic(name, message);
        break;
      }
      case 'runtime': {
        const { file, line, message, stack } = element;
        output = (
          <>
            运行时错误位于 {file}:{line}：{message}
            <ListMapper
              list={stack.map((frame) => {
                return { key: null, value: frame };
              })}
              name="堆栈回溯"
              collapsible
            />
          </>
        );
        messageColor = 'red';
        break;
      }
      case 'print': {
        const { message } = element;
        output = message;
        break;
      }
      default:
        logger.warn(`unknown log status ${status}`);
    }
    if (output === undefined) {
      return null;
    }
    const { chunk } = element;
    if (chunk) {
      output = (
        <>
          <Box>{output}</Box>
          <Button
            onClick={() => {
              setViewedChunk(chunk);
              setModal('viewChunk');
            }}
          >
            查看源代码
          </Button>
        </>
      );
    }
    return (
      <>
        {i > 0 && <Divider />}
        <Box width="100%" key={i} color={messageColor}>
          {output}
        </Box>
        {repeats && (
          <Box
            inline
            px="0.25rem"
            mt="0.25rem"
            style={{
              borderRadius: '0.5em',
            }}
            backgroundColor={messageColor}
          >
            x{repeats + 1}
          </Box>
        )}
      </>
    );
  });
};

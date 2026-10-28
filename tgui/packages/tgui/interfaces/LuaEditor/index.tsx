import hljs from 'highlight.js/lib/core';
import lua from 'highlight.js/lib/languages/lua';
import {
  type ReactNode,
  useCallback,
  useEffect,
  useLayoutEffect,
  useRef,
  useState,
} from 'react';
import {
  Box,
  Button,
  Flex,
  MenuBar,
  ProgressBar,
  Section,
  Stack,
  Tabs,
  TextArea,
} from 'tgui-core/components';

import { useBackend } from '../../backend';
import { Window } from '../../layouts';
import { CallModal } from './CallModal';
import { ChunkViewModal } from './ChunkViewModal';
import { ListMapper } from './ListMapper';
import { Log } from './Log';
import { StateSelectModal } from './StateSelectModal';
import { TaskManager } from './TaskManager';
import type { CallInfo, LuaEditorData, LuaEditorModal } from './types';

hljs.registerLanguage('lua', lua);

export const LuaEditor = () => {
  const { act, data } = useBackend<LuaEditorData>();
  const {
    noStateYet,
    globals,
    tasks,
    showGlobalTable,
    page,
    pageCount,
    lastError,
    supressRuntimes,
  } = data;

  const modalState = useState<LuaEditorModal>(
    noStateYet ? 'states' : undefined,
  );
  const [modal, setModal] = modalState;
  const [activeTab, setActiveTab] = useState<'tasks' | 'log' | 'globals'>(
    'log',
  );
  const [showJumpToBottomButton, setShowJumpToBottomButton] =
    useState<boolean>();
  const [scriptInput, setScriptInput] = useState<string>('');
  const [openMenuBar, setOpenMenuBar] = useState<string | null>(null);
  const [openOnHover, setOpenOnHover] = useState<boolean>(false);

  const [viewedChunk, setViewedChunk] = useState<string>();

  const [toCall, setToCall] = useState<CallInfo>();

  const sectionRef = useRef<HTMLDivElement>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  useLayoutEffect(() => {
    const { data } = useBackend<LuaEditorData>();
    const { forceModal, forceViewChunk, forceInput } = data;
    if (forceModal || forceViewChunk) {
      setModal(forceModal);
      setViewedChunk(forceViewChunk);
    }
    if (forceInput) {
      setScriptInput(forceInput);
    }
  }, []);

  const handleSectionScroll = useCallback(() => {
    const scrollableCurrent = sectionRef.current;
    if (scrollableCurrent) {
      const { scrollHeight, scrollTop, clientHeight } = scrollableCurrent;
      if (!showJumpToBottomButton && scrollHeight > scrollTop + clientHeight) {
        setShowJumpToBottomButton(true);
      } else if (
        showJumpToBottomButton &&
        scrollTop + clientHeight >= scrollHeight
      ) {
        setShowJumpToBottomButton(false);
      }
    }
  }, [showJumpToBottomButton, sectionRef]);

  useEffect(handleSectionScroll);

  useLayoutEffect(() => {
    handleSectionScroll();
    window.addEventListener('resize', handleSectionScroll);
    return () => window.removeEventListener('resize', handleSectionScroll);
  }, [handleSectionScroll]);

  let tabContent: ReactNode;
  switch (activeTab) {
    case 'globals': {
      if (!globals) {
        tabContent = (
          <h1>
            无法获取全局表。它是否已损坏或被同名变量遮蔽？
          </h1>
        );
      } else {
        const { values, variants } = globals;
        tabContent = (
          <ListMapper
            list={values}
            variants={variants}
            skipNulls
            vvAct={(path) => act('vvGlobal', { indices: path })}
            callType="callFunction"
            setToCall={setToCall}
            setModal={setModal}
          />
        );
      }
      break;
    }
    case 'tasks': {
      if (!tasks) {
        tabContent = <h1>无法获取任务信息。</h1>;
      } else {
        tabContent = <TaskManager setModal={setModal} setToCall={setToCall} />;
      }
      break;
    }
    case 'log': {
      tabContent = <Log setViewedChunk={setViewedChunk} setModal={setModal} />;
      break;
    }
  }

  const menuBarProps = {
    openMenuBar: openMenuBar,
    setOpenMenuBar: setOpenMenuBar,
    openOnHover: openOnHover,
    setOpenOnHover: setOpenOnHover,
  };

  const closeMenuAndThen = (func?: () => void) => {
    return () => {
      setOpenMenuBar(null);
      setOpenOnHover(false);
      func?.();
    };
  };

  async function onDropHandler(event: React.DragEvent<HTMLTextAreaElement>) {
    if (event.dataTransfer?.files.length) {
      event.preventDefault();
      setScriptInput(await event.dataTransfer.files[0].text());
    }
  }

  return (
    <Window width={1280} height={720}>
      <Window.Content>
        <input
          type="file"
          hidden
          accept=".lua,.luau"
          ref={fileInputRef}
          onChange={async (event) => {
            if (event.target.files?.length) {
              setScriptInput(await event.target.files[0].text());
              event.target.value = '';
            }
          }}
        />
        <MenuBar>
          <MenuBar.Dropdown
            entry="file"
            openWidth="22rem"
            display="文件"
            {...menuBarProps}
          >
            <MenuBar.Dropdown.MenuItem
              displayText="运行环境"
              onClick={closeMenuAndThen(() => {
                setModal('states');
              })}
            />
            <MenuBar.Dropdown.MenuItem
              displayText="打开"
              onClick={closeMenuAndThen(() => fileInputRef.current?.click())}
            />
            <MenuBar.Dropdown.MenuItem
              displayText="上传并运行"
              onClick={closeMenuAndThen(() => act('runCodeFile'))}
            />
          </MenuBar.Dropdown>
        </MenuBar>
        {noStateYet ? (
          <Flex
            width="100%"
            height="100%"
            align="center"
            justify="space-around"
          >
            <h1>请选择或创建一个 Lua 运行环境以开始。</h1>
          </Flex>
        ) : (
          <Stack height="calc(100% - 16px)">
            <Stack.Item grow shrink basis="55%">
              <Stack fill vertical>
                <Stack.Item grow>
                  <Section fill>
                    <Stack fill vertical>
                      <Stack.Item grow>
                        <TextArea
                          width="100%"
                          height="100%"
                          value={scriptInput}
                          fontFamily="Consolas"
                          onChange={setScriptInput}
                          onDrop={onDropHandler}
                        />
                      </Stack.Item>
                      <Stack.Item>
                        <Button
                          onClick={() => act('runCode', { code: scriptInput })}
                        >
                          运行
                        </Button>
                      </Stack.Item>
                    </Stack>
                  </Section>
                </Stack.Item>
                <Stack.Item>
                  <Box bold textColor="red" mb="1rem">
                    {lastError}
                  </Box>
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Stack.Item grow shrink basis="45%">
              <Section fill pb="24px" height="100%" width="100%">
                <Stack justify="space-between">
                  <Stack.Item>
                    <Tabs>
                      {!!showGlobalTable && (
                        <Tabs.Tab
                          selected={activeTab === 'globals'}
                          onClick={() => {
                            setActiveTab('globals');
                          }}
                        >
                          全局变量
                        </Tabs.Tab>
                      )}
                      <Tabs.Tab
                        selected={activeTab === 'tasks'}
                        onClick={() => setActiveTab('tasks')}
                      >
                        任务
                      </Tabs.Tab>
                      <Tabs.Tab
                        selected={activeTab === 'log'}
                        onClick={() => {
                          setActiveTab('log');
                          setTimeout(handleSectionScroll, 0);
                        }}
                      >
                        日志
                      </Tabs.Tab>
                    </Tabs>
                  </Stack.Item>
                  <Stack.Item>
                    <Button.Checkbox
                      inline
                      checked={showGlobalTable}
                      tooltip="警告：显示全局表可能导致整个服务器严重卡顿，尤其是在全局变量数量很多时。"
                      onClick={() => {
                        if (showGlobalTable && activeTab === 'globals') {
                          setActiveTab('tasks');
                        }
                        act('toggleShowGlobalTable');
                      }}
                    >
                      显示全局表
                    </Button.Checkbox>
                  </Stack.Item>
                </Stack>
                <Stack fill vertical>
                  <Stack.Item grow>
                    <Section
                      title={<Box height="1rem" width="1rem" />}
                      ref={sectionRef}
                      fill
                      scrollable
                      scrollableHorizontal
                      onScroll={handleSectionScroll}
                      buttons={
                        activeTab === 'log' && (
                          <Box position="relative" bottom="1.25rem">
                            <Button.Checkbox
                              checked={supressRuntimes}
                              onClick={() => act('toggleSupressRuntimes')}
                            >
                              禁用运行时错误日志
                            </Button.Checkbox>
                            <Button.Confirm
                              color="red"
                              tooltip="删除所有日志"
                              icon="trash-alt"
                              confirmIcon="trash-alt"
                              confirmContent={null}
                              onClick={() => act('nukeLog')}
                            />
                          </Box>
                        )
                      }
                      width="100%"
                    >
                      {tabContent}
                    </Section>
                    {activeTab === 'log' && showJumpToBottomButton && (
                      <Flex
                        position="absolute"
                        bottom="2.5rem"
                        width="100%"
                        justify="center"
                      >
                        <Button
                          icon="arrow-down"
                          onClick={() => {
                            const sectionCurrent = sectionRef.current;
                            if (sectionCurrent) {
                              sectionCurrent.scrollTop =
                                sectionCurrent.scrollHeight;
                            }
                          }}
                        >
                          跳到底部
                        </Button>
                      </Flex>
                    )}
                  </Stack.Item>
                  {activeTab === 'log' && pageCount > 1 && (
                    <Stack.Item>
                      <Stack justify="space-between">
                        <Stack.Item width="25%">
                          <Button
                            width="100%"
                            align="center"
                            icon="arrow-left"
                            disabled={page <= 0}
                            onClick={() => {
                              act('previousPage');
                            }}
                          />
                        </Stack.Item>
                        <Stack.Item width="50%">
                          <ProgressBar
                            width="100%"
                            value={page / (pageCount - 1)}
                          >
                            <Box width="100%" align="center">
                              {`第 ${page + 1}/${pageCount} 页`}
                            </Box>
                          </ProgressBar>
                        </Stack.Item>
                        <Stack.Item width="25%">
                          <Button
                            width="100%"
                            align="center"
                            icon="arrow-right"
                            disabled={page >= pageCount - 1}
                            onClick={() => {
                              act('nextPage');
                            }}
                          />
                        </Stack.Item>
                      </Stack>
                    </Stack.Item>
                  )}
                </Stack>
              </Section>
            </Stack.Item>
          </Stack>
        )}
      </Window.Content>
      {modal === 'states' && <StateSelectModal setModal={setModal} />}
      {modal === 'viewChunk' && (
        <ChunkViewModal
          viewedChunk={viewedChunk ?? ''}
          setViewedChunk={setViewedChunk}
          setModal={setModal}
        />
      )}
      {modal === 'call' && toCall && (
        <CallModal toCall={toCall} setToCall={setToCall} setModal={setModal} />
      )}
    </Window>
  );
};

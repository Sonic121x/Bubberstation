/**
 * @file
 * @copyright 2022 raffclar
 * @license MIT
 */

import { useEffect, useRef, useState } from 'react';
import {
  Box,
  Button,
  Dialog,
  Divider,
  Dropdown,
  Flex,
  Input,
  MenuBar,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';
import type { NTOSData } from '../layouts/NtosWindow';
import { createLogger } from '../logging';

const logger = createLogger('NtosNotepad');

const DEFAULT_DOCUMENT_NAME = '无标题';

enum Extensions {
  TXT = 'TXT',
}

type NoteFileEntry = {
  uid: number;
  name: string;
  filetype: string;
  onDisk: boolean;
  displayName: string;
};

type PartiallyUnderlinedProps = {
  str: string;
  indexStart: number;
};

const PartiallyUnderlined = (props: PartiallyUnderlinedProps) => {
  const { str, indexStart } = props;
  const start = str.substring(0, indexStart);
  const underlined = str.substring(indexStart, indexStart + 1);
  const end = indexStart < str.length - 1 ? str.substring(indexStart + 1) : '';
  return (
    <>
      {start}
      <span style={{ textDecoration: 'underline' }}>{underlined}</span>
      {end}
    </>
  );
};

enum Dialogs {
  NONE = 0,
  UNSAVED_CHANGES = 1,
  OPEN = 2,
  ABOUT = 3,
  SELECT_FILE = 4,
  SAVE = 5,
}

type MenuBarProps = {
  onSave: () => void;
  onSaveAs: () => void;
  onExit: () => void;
  onNewNote: () => void;
  onCutSelected: () => void;
  onCopySelected: () => void;
  onPasteSelected: () => void;
  onDeleteSelected: () => void;
  onOpenSelected: () => void;
  showStatusBar: boolean;
  setShowStatusBar: (boolean) => void;
  wordWrap: boolean;
  setWordWrap: (boolean) => void;
  aboutNotepadDialog: () => void;
};

const NtosNotepadMenuBar = (props: MenuBarProps) => {
  const {
    onSave,
    onSaveAs,
    onExit,
    onNewNote,
    onCutSelected,
    onCopySelected,
    onPasteSelected,
    onDeleteSelected,
    onOpenSelected,
    setShowStatusBar,
    showStatusBar,
    wordWrap,
    setWordWrap,
    aboutNotepadDialog,
  } = props;
  const [openOnHover, setOpenOnHover] = useState(false);
  const [openMenuBar, setOpenMenuBar] = useState<string | null>(null);
  const onMenuItemClick = (value) => {
    setOpenOnHover(false);
    setOpenMenuBar(null);
    switch (value) {
      case 'save':
        onSave();
        break;
      case 'save_as':
        onSaveAs();
        break;
      case 'exit':
        onExit();
        break;
      case 'new':
        onNewNote();
        break;
      case 'open':
        onOpenSelected();
        break;
      case 'cut':
        onCutSelected();
        break;
      case 'copy':
        onCopySelected();
        break;
      case 'paste':
        onPasteSelected();
        break;
      case 'delete':
        onDeleteSelected();
        break;
      case 'statusBar':
        setShowStatusBar(!showStatusBar);
        break;
      case 'wordWrap':
        setWordWrap(!wordWrap);
        break;
      case 'aboutNotepad':
        aboutNotepadDialog();
        break;
    }
  };
  // Adds the key using the value
  const getMenuItemProps = (value: string, displayText: string) => {
    return {
      key: value,
      value,
      displayText,
      onClick: onMenuItemClick,
    };
  };
  const itemProps = {
    openOnHover,
    setOpenOnHover,
    openMenuBar,
    setOpenMenuBar,
  };

  return (
    <MenuBar>
      <MenuBar.Dropdown
        entry="file"
        openWidth="22rem"
        display={<PartiallyUnderlined str="文件" indexStart={0} />}
        {...itemProps}
      >
        <MenuBar.Dropdown.MenuItem {...getMenuItemProps('new', '新建')} />
        <MenuBar.Dropdown.MenuItem {...getMenuItemProps('open', '打开')} />
        <MenuBar.Dropdown.MenuItem {...getMenuItemProps('save', '保存')} />
        <MenuBar.Dropdown.MenuItem
          {...getMenuItemProps('save_as', '另存为')}
        />
        <MenuBar.Dropdown.Separator key="firstSep" />
        <MenuBar.Dropdown.MenuItem {...getMenuItemProps('exit', '退出……')} />
      </MenuBar.Dropdown>
      <MenuBar.Dropdown
        entry="edit"
        openWidth="22rem"
        display={<PartiallyUnderlined str="编辑" indexStart={0} />}
        {...itemProps}
      >
        <MenuBar.Dropdown.MenuItem {...getMenuItemProps('cut', '剪切')} />
        <MenuBar.Dropdown.MenuItem {...getMenuItemProps('copy', '复制')} />
        <MenuBar.Dropdown.MenuItem {...getMenuItemProps('paste', '粘贴')} />
        <MenuBar.Dropdown.MenuItem {...getMenuItemProps('delete', '删除')} />
      </MenuBar.Dropdown>
      <MenuBar.Dropdown
        entry="format"
        openWidth="15rem"
        display={<PartiallyUnderlined str="格式" indexStart={1} />}
        {...itemProps}
      >
        <MenuBar.Dropdown.MenuItemToggle
          checked={wordWrap}
          {...getMenuItemProps('wordWrap', '自动换行')}
        />
      </MenuBar.Dropdown>
      <MenuBar.Dropdown
        entry="view"
        openWidth="15rem"
        display={<PartiallyUnderlined str="视图" indexStart={0} />}
        {...itemProps}
      >
        <MenuBar.Dropdown.MenuItemToggle
          checked={showStatusBar}
          {...getMenuItemProps('statusBar', '状态栏')}
        />
      </MenuBar.Dropdown>
      <MenuBar.Dropdown
        entry="help"
        openWidth="17rem"
        display={<PartiallyUnderlined str="帮助" indexStart={0} />}
        {...itemProps}
      >
        <MenuBar.Dropdown.MenuItem
          {...getMenuItemProps('aboutNotepad', '关于记事本')}
        />
      </MenuBar.Dropdown>
    </MenuBar>
  );
};

interface StatusBarProps {
  statuses: Statuses;
}

const StatusBar = (props: StatusBarProps) => {
  const { statuses } = props;
  return (
    <Box className="NtosNotepad__StatusBar">
      <Box className="NtosNotepad__StatusBar__entry" minWidth="25rem">
        按 Shift + Enter 插入新行
      </Box>
      <Box className="NtosNotepad__StatusBar__entry" minWidth="15rem">
        第 {statuses.line} 行，第 {statuses.column} 列
      </Box>
      <Box className="NtosNotepad__StatusBar__entry" minWidth="5rem">
        100%
      </Box>
      <Box className="NtosNotepad__StatusBar__entry" minWidth="12rem">
        NtOS (LF)
      </Box>
      <Box className="NtosNotepad__StatusBar__entry" minWidth="12rem">
        UTF-8
      </Box>
    </Box>
  );
};

type Statuses = {
  line: number;
  column: number;
};

const getStatusCounts = (text: string, selectionStart: number): Statuses => {
  const lines = text.substr(0, selectionStart).split('\n');
  return {
    line: lines.length,
    column: lines[lines.length - 1].length + 1,
  };
};

const TEXTAREA_UPDATE_TRIGGERS = [
  'click',
  'input',
  'paste',
  'cut',
  'mousemove',
  'select',
  'selectstart',
  'keydown',
];

interface NotePadTextAreaProps {
  text: string;
  wordWrap: boolean;
  setText: (text: string) => void;
  setStatuses: (statuses: Statuses) => void;
}

function NotePadTextArea(props: NotePadTextAreaProps) {
  const { text, setText, wordWrap, setStatuses } = props;

  const textareaRef = useRef<HTMLTextAreaElement | null>(null);

  function handleEvent(event) {
    const area = event.target as HTMLTextAreaElement;
    setStatuses(getStatusCounts(area.value, area.selectionStart));
  }

  return (
    <textarea
      autoFocus
      className="NtosNotepad__textarea"
      onClick={handleEvent}
      onMouseUp={handleEvent}
      onChange={(event) => {
        setText(event.currentTarget.value);
        handleEvent(event);
      }}
      ref={textareaRef}
      spellCheck={false}
      style={{
        whiteSpace: wordWrap ? 'normal' : 'nowrap',
        overflow: wordWrap ? 'hidden auto' : 'scroll hidden',
      }}
      value={text}
    />
  );
}

type AboutDialogProps = {
  close: () => void;
};

const AboutDialog = (props: AboutDialogProps) => {
  const { close } = props;
  const { data } = useBackend<NTOSData>();
  const { show_imprint, login } = data;
  const paragraphStyle = { padding: '.5rem 1rem 0 2rem' };

  return (
    <Dialog title="关于记事本" onClose={close} width={'500px'}>
      <div className="Dialog__body">
        <span className="NtosNotepad__AboutDialog__logo">NtOS</span>
        <Divider />
        <Box className="NtosNotepad__AboutDialog__text">
          <span style={paragraphStyle}>纳米传讯 NtOS</span>
          <span style={paragraphStyle}>
            版本 7815696ecbf1c96e6894b779456d330e
          </span>
          <span style={paragraphStyle}>
            &copy; 纳米传讯公司。保留所有权利。
          </span>
          <span style={{ padding: '3rem 1rem 3rem 2rem' }}>
            NtOS 操作系统及其用户界面受到
            太阳系及其他地区的商标，以及其他已生效或
            正在申请中的知识产权保护。
          </span>
          <span
            style={{
              padding: '3rem 1rem 0.5rem 2rem',
              maxWidth: '35rem',
            }}
          >
            根据纳米传讯公司的条款，本产品授权给：
          </span>
          <span style={{ padding: '0 1rem 0 4rem' }}>
            {show_imprint ? login.IDName : '未知'}
          </span>
        </Box>
      </div>
      <div className="Dialog__footer">
        <Dialog.Button onClick={close}>确定</Dialog.Button>
      </div>
    </Dialog>
  );
};

type NoteData = {
  note: string;
  documentName: string;
  files: NoteFileEntry[];
};
type RetryActionType = (retrying?: boolean) => void;

export const NtosNotepad = (props) => {
  const { act, data } = useBackend<NoteData>();
  const {
    note,
    documentName: backendDocumentName = DEFAULT_DOCUMENT_NAME,
    files = [],
  } = data;
  const [documentName, setDocumentName] = useState(backendDocumentName);
  const [originalText, setOriginalText] = useState(note);
  const [text, setText] = useState(note);
  const [statuses, setStatuses] = useState<Statuses>({
    line: 0,
    column: 0,
  });
  const [activeDialog, setActiveDialog] = useState(Dialogs.NONE);
  const [retryAction, setRetryAction] = useState<RetryActionType | null>(null);
  const [showStatusBar, setShowStatusBar] = useState(true);
  const [wordWrap, setWordWrap] = useState(true);
  const [selectedFileUid, setSelectedFileUid] = useState<number | null>(null);
  const [saveName, setSaveName] = useState(DEFAULT_DOCUMENT_NAME);

  const [saveExtension, setSaveExtension] = useState(Extensions.TXT);

  useEffect(() => {
    setText(note);
    setOriginalText(note);
    setDocumentName(backendDocumentName);
    setStatuses(getStatusCounts(note, note.length));
  }, [note, backendDocumentName]);

  const handleCloseDialog = () => setActiveDialog(Dialogs.NONE);
  const handleSave = () => {
    logger.log(`Saving the document as ${documentName}`);
    act('save', { note: text });
    setActiveDialog(Dialogs.NONE);
    if (retryAction) {
      setRetryAction(null);
    }
  };
  const handleSaveAs = () => setActiveDialog(Dialogs.SAVE);
  const handleOpenNote = (retrying = false) => {
    if (ensureUnsavedChangesAreHandled(handleOpenNote, retrying)) {
      return;
    }
    setSelectedFileUid(null);
    setActiveDialog(Dialogs.SELECT_FILE);
  };
  const ensureUnsavedChangesAreHandled = (
    action: () => void,
    retrying = false,
  ): boolean => {
    // This is a guard function that throws up the "unsaved changes" dialog if the user is
    // attempting to do something that will make them lose data
    if (!retrying && originalText !== text) {
      logger.log('Unsaved changes. Asking client to save');
      setRetryAction(() => action);
      setActiveDialog(Dialogs.UNSAVED_CHANGES);
      return true;
    }

    return false;
  };
  const exit = (retrying = false) => {
    if (ensureUnsavedChangesAreHandled(exit, retrying)) {
      return;
    }
    logger.log('Exiting Notepad');
    act('PC_exit');
  };
  const newNote = (retrying = false) => {
    if (ensureUnsavedChangesAreHandled(newNote, retrying)) {
      return;
    }
    setOriginalText('');
    setText('');
    setDocumentName(DEFAULT_DOCUMENT_NAME);
  };

  const selectedFile = files.find((file) => file.uid === selectedFileUid);
  // MS Notepad displays an asterisk when there's unsaved changes
  const unsavedAsterisk = text !== originalText ? '*' : '';
  return (
    <NtosWindow
      title={`${unsavedAsterisk}${documentName} - 记事本`}
      width={840}
      height={900}
    >
      <NtosWindow.Content>
        <Box className="NtosNotepad__layout">
          <NtosNotepadMenuBar
            onSave={handleSave}
            onSaveAs={handleSaveAs}
            onExit={exit}
            onNewNote={newNote}
            onOpenSelected={handleOpenNote}
            onCutSelected={() => document.execCommand('cut')}
            onCopySelected={() => document.execCommand('copy')}
            onPasteSelected={() => document.execCommand('paste')}
            onDeleteSelected={() => document.execCommand('delete')}
            showStatusBar={showStatusBar}
            setShowStatusBar={setShowStatusBar}
            wordWrap={wordWrap}
            setWordWrap={setWordWrap}
            aboutNotepadDialog={() => setActiveDialog(Dialogs.ABOUT)}
          />
          <Section fill>
            <NotePadTextArea
              text={text}
              setText={setText}
              wordWrap={wordWrap}
              setStatuses={setStatuses}
            />
          </Section>
          {showStatusBar && <StatusBar statuses={statuses} />}
        </Box>
      </NtosWindow.Content>
      {activeDialog === Dialogs.SELECT_FILE && (
        <Dialog title="打开文件" onClose={handleCloseDialog} width="520px">
          <div className="Dialog__body">
            <Stack vertical fill>
              <Stack.Item>
                <Section fill title="文本文件">
                  {files.length ? (
                    <Dropdown
                      selected={selectedFile?.displayName}
                      displayText={selectedFile?.displayName}
                      placeholder="选择文件……"
                      options={files.map((file) => file.displayName)}
                      onSelected={(filename) => {
                        setSelectedFileUid(
                          files.find((file) => file.displayName === filename)
                            ?.uid || files[0].uid,
                        );
                      }}
                    />
                  ) : (
                    <Box>没有可用的文本文件。</Box>
                  )}
                </Section>
              </Stack.Item>
            </Stack>
          </div>
          <div className="Dialog__footer">
            <Button
              onClick={() => {
                if (selectedFile) {
                  act('Open', {
                    uid: selectedFile.uid,
                    onDisk: selectedFile.onDisk,
                    name: selectedFile.name,
                  });
                  handleCloseDialog();
                }
              }}
            >
              {'打开'}
            </Button>
            <Dialog.Button onClick={handleCloseDialog}>取消</Dialog.Button>
          </div>
        </Dialog>
      )}
      {activeDialog === Dialogs.SAVE && (
        <Dialog title="另存为" onClose={handleCloseDialog} width="420px">
          <div className="Dialog__body">
            <Flex justify="space-between">
              <Flex.Item>
                <Input
                  autoFocus
                  fluid
                  value={saveName}
                  onChange={(value) => setSaveName(value)}
                />
              </Flex.Item>
              <Flex.Item>
                <Dropdown
                  selected={saveExtension}
                  displayText={saveExtension}
                  placeholder="选择扩展名……"
                  options={[Extensions.TXT]}
                  onSelected={(extension) => {
                    setSaveExtension(extension);
                  }}
                />
              </Flex.Item>
            </Flex>
          </div>
          <div className="Dialog__footer">
            <Dialog.Button
              onClick={() => {
                act('SaveAs', {
                  name: saveName,
                  extension: saveExtension,
                  note: text,
                });
                handleCloseDialog();
              }}
            >
              {'保存'}
            </Dialog.Button>
            <Dialog.Button onClick={handleCloseDialog}>取消</Dialog.Button>
          </div>
        </Dialog>
      )}
      {activeDialog === Dialogs.UNSAVED_CHANGES && (
        <Dialog title="记事本" onClose={handleCloseDialog}>
          <div className="Dialog__body">
            是否保存对 {documentName} 的更改？
          </div>
          <div className="Dialog__footer">
            <Dialog.Button
              onClick={() => {
                setRetryAction(null);
                act('Save', { note: text });
                setActiveDialog(Dialogs.NONE);
              }}
            >
              保存
            </Dialog.Button>
            <Dialog.Button onClick={handleCloseDialog}>
              不保存
            </Dialog.Button>
            <Dialog.Button onClick={handleCloseDialog}>取消</Dialog.Button>
          </div>
        </Dialog>
      )}
      {activeDialog === Dialogs.ABOUT && (
        <AboutDialog close={handleCloseDialog} />
      )}
    </NtosWindow>
  );
};

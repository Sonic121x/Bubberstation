import { type Dispatch, type SetStateAction, useState } from 'react';
import { sendAct as act } from 'tgui/events/act';
import { MenuBar } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

type NanopaintMenuBarProps = {
  undoHistory: string[];
  redoHistory: string[];
  workspaceOpen: BooleanLike;
  zoom: number;
  maxZoom: number;
  minZoom: number;
  setZoom: Dispatch<SetStateAction<number>>;
};

export const NanopaintMenuBar = (props: NanopaintMenuBarProps) => {
  const {
    undoHistory,
    redoHistory,
    workspaceOpen,
    zoom,
    minZoom,
    maxZoom,
    setZoom,
  } = props;
  const [openOnHover, setOpenOnHover] = useState(false);
  const [openMenuBar, setOpenMenuBar] = useState<string | null>(null);
  // Adds the key using the value
  const getMenuItemProps = (
    value: string,
    displayText: string,
    action: () => void,
  ) => {
    return {
      key: value,
      value,
      displayText,
      onClick: (_value) => {
        setOpenOnHover(false);
        setOpenMenuBar(null);
        action();
      },
    };
  };
  const dropdownProps = {
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
        display="文件"
        {...dropdownProps}
      >
        <MenuBar.Dropdown.MenuItem
          {...getMenuItemProps('new', '新建', () => act('newDialog'))}
        />
        <MenuBar.Dropdown.MenuItem
          {...getMenuItemProps('open', '打开', () => act('openDialog'))}
        />
        <MenuBar.Dropdown.MenuItem
          {...getMenuItemProps('save', '保存', () => act('save'))}
          disabled={!workspaceOpen}
        />
        <MenuBar.Dropdown.MenuItem
          {...getMenuItemProps('saveAs', '另存为', () => act('saveAsDialog'))}
          disabled={!workspaceOpen}
        />
      </MenuBar.Dropdown>
      <MenuBar.Dropdown
        entry="edit"
        openWidth="22rem"
        display="编辑"
        disabled={!workspaceOpen}
        {...dropdownProps}
      >
        <MenuBar.Dropdown.MenuItem
          {...getMenuItemProps(
            'undo',
            `撤销${undoHistory.length > 0 ? ` ${undoHistory[0]}` : ''}`,
            () => act('spriteEditorCommand', { command: 'undo' }),
          )}
          disabled={undoHistory.length === 0}
        />
        <MenuBar.Dropdown.MenuItem
          {...getMenuItemProps(
            'redo',
            `重做${undoHistory.length > 0 ? ` ${redoHistory[0]}` : ''}`,
            () => act('spriteEditorCommand', { command: 'redo' }),
          )}
          disabled={redoHistory.length === 0}
        />
      </MenuBar.Dropdown>
      <MenuBar.Dropdown
        entry="view"
        openWidth="22rem"
        display="视图"
        {...dropdownProps}
      >
        <MenuBar.Dropdown.MenuItem
          disabled={!workspaceOpen || zoom === maxZoom}
          {...getMenuItemProps('zoomIn', '放大', () => setZoom(zoom + 1))}
        />
        <MenuBar.Dropdown.MenuItem
          disabled={!workspaceOpen || zoom === minZoom}
          {...getMenuItemProps('zoomOut', '缩小', () => setZoom(zoom - 1))}
        />
      </MenuBar.Dropdown>
    </MenuBar>
  );
};

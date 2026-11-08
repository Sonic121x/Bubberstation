import { useState } from 'react';
import {
  Button,
  Icon,
  Input,
  LabeledList,
  Section,
  Table,
  Tooltip,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts'; import { directoryDisplay } from '../localization/directoryDisplay';

// 自定义修改：角色目录不显示或按成人偏好着色。

export const ZubbersCharacterDirectory = (props) => {
  const { data } = useBackend();

  const {
    personalVisibility,
    personalAttraction,
    personalGender,
  } = data;

  return (
    <Window width={900} height={640} resizeable>
      <Window.Content scrollable>
        <Section title="控制">
          <LabeledList>
            <LabeledList.Item label="可见性">
              <Button fluid>
                {personalVisibility ? '显示' : '隐藏'}
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="吸引倾向">
              <Button fluid>{directoryDisplay(personalAttraction)}</Button>
            </LabeledList.Item>
            <LabeledList.Item label="性别">
              <Button fluid>{directoryDisplay(personalGender)}</Button>
            </LabeledList.Item>
            {/* 自定义修改：移除成人偏好展示 */}
            {/* 自定义修改：移除成人偏好展示 */}
            {/* 自定义修改：移除成人偏好展示 */}
            {/* 自定义修改：移除成人偏好展示 */}
          </LabeledList>
        </Section>
        <CharacterDirectoryList />
      </Window.Content>
    </Window>
  );
};

const CharacterDirectoryList = (props) => {
  const { act, data } = useBackend();

  const { directory, canOrbit } = data;
  const [searchTerm, setSearchTerm] = useState('');

  const [sortId, setSortId] = useState('name');
  const [sortOrder, setSortOrder] = useState('asc');

  const handleSort = (id) => {
    if (sortId === id) {
      setSortOrder(sortOrder === 'asc' ? 'desc' : 'asc');
    } else {
      setSortId(id);
      setSortOrder('desc'); // Set to descending on new sort
    }
  };

  const handleRandomView = () => {
    if (directory.length > 0) {
      const randomIndex = Math.floor(Math.random() * directory.length);
      const randomCharacter = directory[randomIndex];
      act('view', { ref: randomCharacter.ref });
    }
  };

  const filteredDirectory = directory.filter((character) =>
    character.name.toLowerCase().includes(searchTerm.toLowerCase()),
  );

  // 自定义修改：取消成人状态排序。

  const sortedDirectory = filteredDirectory.slice().sort((a, b) => {
    // 自定义修改：目录仅按普通角色信息排序。

    const sortOrderValue = sortOrder === 'asc' ? 1 : -1;
    return sortOrderValue * a[sortId].localeCompare(b[sortId]);
  });

  return (
    <Section
      title="角色目录"
      buttons={
        <>
          <Button icon="sync" onClick={() => act('refresh')}>
            {'刷新'}
          </Button>
          <Tooltip content="显示一位随机玩家的角色介绍。敢的话就点吧。">
            <Button icon="random" onClick={handleRandomView}>
              {'手气不错'}
            </Button>
          </Tooltip>
        </>
      }
    >
      <Input
        placeholder="搜索姓名……"
        onChange={setSearchTerm}
        value={searchTerm}
        mb={2}
      />
      <Table>
        <Table.Row bold>
          <SortButton
            id="name"
            sortId={sortId}
            sortOrder={sortOrder}
            onClick={handleSort}
          >
            姓名
          </SortButton>
          <SortButton
            id="species"
            sortId={sortId}
            sortOrder={sortOrder}
            onClick={handleSort}
          >
            物种
          </SortButton>
          <SortButton
            id="attraction"
            sortId={sortId}
            sortOrder={sortOrder}
            onClick={handleSort}
          >
            吸引倾向
          </SortButton>
          <SortButton
            id="gender"
            sortId={sortId}
            sortOrder={sortOrder}
            onClick={handleSort}
          >
            性别
          </SortButton>
          {/* 自定义修改：移除成人偏好列 */}
          {/* 自定义修改：移除成人偏好列 */}
          {/* 自定义修改：移除成人偏好列 */}
          {/* 自定义修改：移除成人偏好列 */}
          <Table.Cell collapsing textAlign="right">
            介绍
          </Table.Cell>
        </Table.Row>
        {sortedDirectory.map((character, i) => (
          <Table.Row key={i}>
            <Table.Cell p={1}>
              {canOrbit ? (
                <Button
                  color="green" // 自定义修改：使用普通目录按钮颜色
                  icon="ghost"
                  tooltip="跟随观察"
                  onClick={() => act('orbit', { ref: character.ref })}
                >
                  {character.name}
                </Button>
              ) : (
                character.name
              )}
            </Table.Cell>
            <Table.Cell>{directoryDisplay(character.species)}</Table.Cell>
            <Table.Cell>{directoryDisplay(character.attraction)}</Table.Cell>
            <Table.Cell>{directoryDisplay(character.gender)}</Table.Cell>
            {/* 自定义修改：不展示成人状态 */}
            {/* 自定义修改：不展示成人状态 */}
            {/* 自定义修改：不展示成人状态 */}
            {/* 自定义修改：不展示成人状态 */}
            <Table.Cell collapsing textAlign="right">
              <Button
                onClick={() => act('view', { ref: character.ref })}
                color="transparent"
                icon="sticky-note"
                mr={1}
              >
                {'查看'}
              </Button>
            </Table.Cell>
          </Table.Row>
        ))}
      </Table>
    </Section>
  );
};

const SortButton = ({ id, sortId, sortOrder, onClick, children }) => (
  <Table.Cell collapsing>
    <Button
      width="100%"
      color={sortId !== id ? 'transparent' : undefined}
      onClick={() => onClick(id)}
    >
      {children}
      {sortId === id && (
        <Icon
          name={sortOrder === 'asc' ? 'sort-up' : 'sort-down'}
          ml="0.25rem;"
        />
      )}
    </Button>
  </Table.Cell>
);

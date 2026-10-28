import { useState } from 'react';
import { useBackend } from 'tgui/backend';
import { Button, NoticeBox, Section, Stack } from 'tgui-core/components';
import { softwareDisplay } from './softwareDisplay';
import { DOOR_JACK, HOST_SCAN, PHOTO_MODE, SOFTWARE_DESC } from './constants';
import type { PaiData } from './types';

/**
 * Renders two sections: A section of buttons and
 * another section that displays the selected installed
 * software info.
 */
export function InstalledDisplay(props) {
  const { data } = useBackend<PaiData>();
  const { installed = [] } = data;

  const [currentSelection, setCurrentSelection] = useState('');

  const title = !currentSelection ? '选择程序' : softwareDisplay(currentSelection);

  return (
    <Stack fill vertical>
      <Stack.Item grow>
        <Section fill scrollable title={title}>
          {currentSelection && (
            <Stack fill vertical>
              <Stack.Item>{SOFTWARE_DESC[currentSelection]}</Stack.Item>
              <Stack.Item grow>
                <SoftwareButtons currentSelection={currentSelection} />
              </Stack.Item>
            </Stack>
          )}
        </Section>
      </Stack.Item>
      <Stack.Item grow={2}>
        <Section fill scrollable title="已安装软件">
          {!installed.length ? (
            <NoticeBox>尚未安装任何软件！</NoticeBox>
          ) : (
            installed.map((software, index) => {
              return (
                <Button
                  key={index}
                  onClick={() => setCurrentSelection(software)}
                >
                  {softwareDisplay(software)}
                </Button>
              );
            })
          )}
        </Section>
      </Stack.Item>
    </Stack>
  );
}

type SoftwareButtonsProps = {
  currentSelection: string;
};

/**
 * Once a software is selected, generates custom buttons or a default
 * power toggle.
 */
function SoftwareButtons(props: SoftwareButtonsProps) {
  const { currentSelection } = props;

  const { act, data } = useBackend<PaiData>();
  const { door_jack, languages, master_name } = data;

  switch (currentSelection) {
    case 'Door Jack':
      return (
        <>
          <Button
            disabled={!!door_jack}
            icon="plug"
            onClick={() => act(currentSelection, { mode: DOOR_JACK.Cable })}
            tooltip="伸出线缆，可插入兼容的气闸。"
          >
            伸出线缆
          </Button>
          <Button
            color="bad"
            disabled={!door_jack}
            icon="door-open"
            onClick={() => act(currentSelection, { mode: DOOR_JACK.Hack })}
            tooltip="开始覆盖气闸的安全协议。"
          >
            破解门禁
          </Button>
          <Button
            disabled={!door_jack}
            icon="unlink"
            onClick={() => act(currentSelection, { mode: DOOR_JACK.Cancel })}
          >
            取消
          </Button>
        </>
      );
    case 'Host Scan':
      return (
        <>
          <Button
            icon="hand-holding-heart"
            onClick={() => act(currentSelection, { mode: HOST_SCAN.Target })}
            tooltip="必须被拿在手中或抱起才能扫描。"
          >
            扫描持有者
          </Button>
          <Button
            disabled={!master_name}
            icon="user-cog"
            onClick={() => act(currentSelection, { mode: HOST_SCAN.Master })}
            tooltip="扫描已绑定的主人。"
          >
            扫描主人
          </Button>
        </>
      );
    case 'Photography Module':
      return (
        <>
          <Button
            icon="camera-retro"
            onClick={() => act(currentSelection, { mode: PHOTO_MODE.Camera })}
            tooltip="开关相机。点击目标区域拍照。"
          >
            相机
          </Button>
          <Button
            icon="print"
            onClick={() => act(currentSelection, { mode: PHOTO_MODE.Printer })}
            tooltip="显示已存储的照片列表。"
          >
            打印机
          </Button>
          <Button
            icon="search-plus"
            onClick={() => act(currentSelection, { mode: PHOTO_MODE.Zoom })}
            tooltip="调整后续照片的变焦倍率。"
          >
            变焦
          </Button>
        </>
      );
    case 'Universal Translator':
      return (
        <Button
          icon="download"
          onClick={() => act(currentSelection)}
          disabled={!!languages}
        >
          {!languages ? '安装' : '已安装'}
        </Button>
      );
    default:
      return (
        <Button
          icon="power-off"
          onClick={() => act(currentSelection)}
          tooltip="尝试启用此模块。"
        >
          切换
        </Button>
      );
  }
}

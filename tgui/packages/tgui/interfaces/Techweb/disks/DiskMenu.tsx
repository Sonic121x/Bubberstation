import { Button, Flex, Tabs } from 'tgui-core/components';

import { useRemappedBackend } from '../helpers';
import { useTechWebRoute } from '../hooks';
import { TechwebDesignDisk, TechwebTechDisk } from './disks';

type Props = {
  diskType: string;
};

export function TechwebDiskMenu(props: Props) {
  const { act, data } = useRemappedBackend();
  const { diskType } = props;
  const { t_disk, d_disk } = data;
  const [techwebRoute, setTechwebRoute] = useTechWebRoute();

  // Check for the disk actually being inserted
  if ((diskType === 'design' && !d_disk) || (diskType === 'tech' && !t_disk)) {
    return null;
  }

  const DiskContent =
    (diskType === 'design' && TechwebDesignDisk) || TechwebTechDisk;

  return (
    <Flex direction="column" height="100%">
      <Flex.Item>
        <Flex justify="space-between" className="Techweb__HeaderSectionTabs">
          <Flex.Item align="center" className="Techweb__HeaderTabTitle">
            {diskType === 'design' ? '设计' : '科技'}磁盘
          </Flex.Item>
          <Flex.Item grow>
            <Tabs>
              <Tabs.Tab selected>已存数据</Tabs.Tab>
            </Tabs>
          </Flex.Item>
          <Flex.Item align="center">
            {diskType === 'tech' && (
              <Button icon="save" onClick={() => act('loadTech')}>
                科技网络 &rarr; 磁盘
              </Button>
            )}
            <Button
              icon="upload"
              onClick={() => act('uploadDisk', { type: diskType })}
            >
              磁盘 &rarr; 科技网络
            </Button>
            <Button
              icon="eject"
              onClick={() => {
                act('ejectDisk', { type: diskType });
                setTechwebRoute({ route: '' });
              }}
            >
              弹出
            </Button>
            <Button icon="home" onClick={() => setTechwebRoute({ route: '' })}>
              主页
            </Button>
          </Flex.Item>
        </Flex>
      </Flex.Item>
      <Flex.Item grow className="Techweb__OverviewNodes">
        <DiskContent />
      </Flex.Item>
    </Flex>
  );
}

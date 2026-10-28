import { useState } from 'react';
import {
  AnimatedNumber,
  Box,
  Button,
  Flex,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
  Slider,
  Stack,
  Tabs,
} from 'tgui-core/components';
import { formatEnergy } from 'tgui-core/format';
import { formatPower } from 'tgui-core/format';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';
import { robotactDisplay as zh } from '../localization/zhRobotactDisplay';
export const NtosRobotact = (props) => {
  return (
    <NtosWindow width={800} height={600}>
      <NtosWindow.Content>
        <NtosRobotactContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};

export const NtosRobotactContent = (props) => {
  const { act, data } = useBackend();
  const [tab_main, setTab_main] = useState(1);
  const [tab_sub, setTab_sub] = useState(1);
  const {
    charge,
    maxcharge,
    integrity,
    lampIntensity,
    lampConsumption,
    cover,
    locomotion,
    wireModule,
    wireCamera,
    wireAI,
    wireLaw,
    sensors,
    printerPictures,
    printerToner,
    printerTonerMax,
    thrustersInstalled,
    thrustersStatus,
    selfDestructAble,
    cyborg_groups = [],
    masterAI_online,
    MasterAI_connected,
  } = data;
  const borgName = data.borgName || [];
  const borgType = data.designation || [];
  const masterAI = data.masterAI || [];
  const laws = data.Laws || [];
  const borgLog = data.borgLog || [];
  const borgUpgrades = data.borgUpgrades || [];

  return (
    <Flex direction={'column'}>
      <Flex.Item position="relative" mb={1}>
        <Tabs>
          <Tabs.Tab
            icon="list"
            lineHeight="23px"
            selected={tab_main === 1}
            onClick={() => setTab_main(1)}
          >
            状态
          </Tabs.Tab>
          <Tabs.Tab
            icon="list"
            lineHeight="23px"
            selected={tab_main === 2}
            onClick={() => setTab_main(2)}
          >
            日志
          </Tabs.Tab>
          <Tabs.Tab
            icon="list"
            lineHeight="23px"
            selected={tab_main === 3}
            onClick={() => setTab_main(3)}
          >
            网络
          </Tabs.Tab>
        </Tabs>
      </Flex.Item>
      {tab_main === 1 && (
        <>
          <Flex direction={'row'}>
            <Flex.Item width="30%">
              <Section title="配置" fill>
                <LabeledList>
                  <LabeledList.Item label="单位">
                    {borgName.slice(0, 17)}
                  </LabeledList.Item>
                  <LabeledList.Item label="类型">{borgType}</LabeledList.Item>
                  <LabeledList.Item label="AI">
                    {masterAI.slice(0, 17)}
                  </LabeledList.Item>
                </LabeledList>
              </Section>
            </Flex.Item>
            <Flex.Item grow={1} basis="content" ml={1}>
              <Section title="状态">
                电量：
                <Button
                  content="电量警报"
                  disabled={charge}
                  onClick={() => act('alertPower')}
                />
                <ProgressBar
                  value={charge / maxcharge}
                  ranges={{
                    good: [0.5, Infinity],
                    average: [0.1, 0.5],
                    bad: [-Infinity, 0.1],
                  }}
                >
                  <AnimatedNumber
                    value={charge}
                    format={(charge) => formatEnergy(charge)}
                  />
                </ProgressBar>
                机体完整度：
                <ProgressBar
                  value={integrity}
                  minValue={0}
                  maxValue={100}
                  ranges={{
                    bad: [-Infinity, 25],
                    average: [25, 75],
                    good: [75, Infinity],
                  }}
                />
              </Section>
              <Section title="灯光强度">
                <Slider
                  value={lampIntensity}
                  step={1}
                  stepPixelSize={25}
                  maxValue={5}
                  minValue={1}
                  onChange={(e, value) =>
                    act('lampIntensity', {
                      ref: value,
                    })
                  }
                />
                灯光功耗：{formatPower(lampIntensity * lampConsumption)}
              </Section>
            </Flex.Item>
            <Flex.Item width="50%" ml={1}>
              <Section fitted>
                <Tabs fluid={1} textAlign="center">
                  <Tabs.Tab
                    icon=""
                    lineHeight="23px"
                    selected={tab_sub === 1}
                    onClick={() => setTab_sub(1)}
                  >
                    操作
                  </Tabs.Tab>
                  <Tabs.Tab
                    icon=""
                    lineHeight="23px"
                    selected={tab_sub === 2}
                    onClick={() => setTab_sub(2)}
                  >
                    升级模块
                  </Tabs.Tab>
                  <Tabs.Tab
                    icon=""
                    lineHeight="23px"
                    selected={tab_sub === 3}
                    onClick={() => setTab_sub(3)}
                  >
                    诊断
                  </Tabs.Tab>
                </Tabs>
              </Section>
              {tab_sub === 1 && (
                <Section>
                  <LabeledList>
                    <LabeledList.Item label="维护舱盖">
                      <Button.Confirm
                        content="解锁"
                        disabled={cover === 'UNLOCKED'}
                        onClick={() => act('coverunlock')}
                      />
                    </LabeledList.Item>
                    <LabeledList.Item label="传感器叠加显示">
                      <Button
                        content={zh(sensors)}
                        onClick={() => act('toggleSensors')}
                      />
                    </LabeledList.Item>
                    <LabeledList.Item
                      label={`已存储照片（${printerPictures}）`}
                    >
                      <Button
                        content="查看"
                        disabled={!printerPictures}
                        onClick={() => act('viewImage')}
                      />
                      <Button
                        content="打印"
                        disabled={!printerPictures}
                        onClick={() => act('printImage')}
                      />
                    </LabeledList.Item>
                    <LabeledList.Item label="打印机碳粉">
                      <ProgressBar value={printerToner / printerTonerMax} />
                    </LabeledList.Item>
                    {!!thrustersInstalled && (
                      <LabeledList.Item label="推进器开关">
                        <Button
                          content={zh(thrustersStatus)}
                          onClick={() => act('toggleThrusters')}
                        />
                      </LabeledList.Item>
                    )}
                    {!!selfDestructAble && (
                      <LabeledList.Item label="自毁">
                        <Button.Confirm
                          content="激活"
                          color="red"
                          onClick={() => act('selfDestruct')}
                        />
                      </LabeledList.Item>
                    )}
                  </LabeledList>
                </Section>
              )}
              {tab_sub === 2 && (
                <Section>
                  {borgUpgrades.map((upgrade) => (
                    <Box mb={1} key={upgrade}>
                      {upgrade}
                    </Box>
                  ))}
                </Section>
              )}
              {tab_sub === 3 && (
                <Section>
                  <LabeledList>
                    <LabeledList.Item
                      label="AI 连接"
                      color={
                        wireAI === 'FAULT'
                          ? 'red'
                          : wireAI === 'READY'
                            ? 'yellow'
                            : 'green'
                      }
                    >
                      {zh(wireAI)}
                    </LabeledList.Item>
                    <LabeledList.Item
                      label="法则同步"
                      color={wireLaw === 'FAULT' ? 'red' : 'green'}
                    >
                      {zh(wireLaw)}
                    </LabeledList.Item>
                    <LabeledList.Item
                      label="摄像头"
                      color={
                        wireCamera === 'FAULT'
                          ? 'red'
                          : wireCamera === 'DISABLED'
                            ? 'yellow'
                            : 'green'
                      }
                    >
                      {zh(wireCamera)}
                    </LabeledList.Item>
                    <LabeledList.Item
                      label="模块控制器"
                      color={wireModule === 'FAULT' ? 'red' : 'green'}
                    >
                      {zh(wireModule)}
                    </LabeledList.Item>
                    <LabeledList.Item
                      label="运动控制器"
                      color={
                        locomotion === 'FAULT'
                          ? 'red'
                          : locomotion === 'DISABLED'
                            ? 'yellow'
                            : 'green'
                      }
                    >
                      {zh(locomotion)}
                    </LabeledList.Item>
                    <LabeledList.Item
                      label="维护舱盖"
                      color={cover === 'UNLOCKED' ? 'red' : 'green'}
                    >
                      {zh(cover)}
                    </LabeledList.Item>
                  </LabeledList>
                </Section>
              )}
            </Flex.Item>
          </Flex>
          <Flex.Item height={21} mt={1}>
            <Section
              title="法则"
              fill
              scrollable
              buttons={
                <>
                  <Button
                    content="宣读法则"
                    onClick={() => act('lawstate')}
                  />
                  <Button icon="volume-off" onClick={() => act('lawchannel')} />
                </>
              }
            >
              {laws.map((law) => (
                <Box mb={1} key={law}>
                  {law}
                </Box>
              ))}
            </Section>
          </Flex.Item>
        </>
      )}
      {tab_main === 2 && (
        <Flex.Item height={40}>
          <Section fill scrollable backgroundColor="black">
            {borgLog.map((log) => (
              <Box mb={1} key={log}>
                <font color="green">{log}</font>
              </Box>
            ))}
          </Section>
        </Flex.Item>
      )}
      {tab_main === 3 && (
        <Flex.Item height={40}>
          <Section
            title={MasterAI_connected ? masterAI : '未配置'}
            textAlign="center"
          >
            <LabeledList>
              <LabeledList.Item label="状态">
                <Box color={masterAI_online ? 'good' : 'bad'}>
                  {!MasterAI_connected
                    ? '未连接'
                    : masterAI_online
                      ? '在线'
                      : '无响应'}
                </Box>
              </LabeledList.Item>
            </LabeledList>
          </Section>

          <Stack vertical>
            {cyborg_groups.map((borggroup, cyborgindex) => (
              <Stack.Item key={cyborgindex}>
                <Stack>
                  {borggroup.map((cyborg, borgindex) => (
                    <Stack.Item key={borgindex} width="24.25%">
                      <Section
                        key={cyborg.ref}
                        title={cyborg.otherBorgName.slice(0, 20)}
                      >
                        <LabeledList>
                          <LabeledList.Item label="状态">
                            <Box
                              color={
                                cyborg.status
                                  ? 'bad'
                                  : cyborg.locked_down
                                    ? 'average'
                                    : 'good'
                              }
                            >
                              {cyborg.status
                                ? '无响应'
                                : cyborg.locked_down
                                  ? '已锁定'
                                  : cyborg.shell_discon
                                    ? '正常／已断开连接'
                                    : '正常'}
                            </Box>
                          </LabeledList.Item>
                          <LabeledList.Item label="机体状况">
                            <Box
                              color={
                                cyborg.integ <= 25
                                  ? 'bad'
                                  : cyborg.integ <= 75
                                    ? 'average'
                                    : 'good'
                              }
                            >
                              {cyborg.integ === 0
                                ? '严重故障'
                                : cyborg.integ <= 25
                                  ? '功能严重受损'
                                  : cyborg.integ <= 75
                                    ? '功能受损'
                                    : '运行正常'}
                            </Box>
                          </LabeledList.Item>
                          <LabeledList.Item label="电量">
                            <Box
                              color={
                                cyborg.charge <= 30
                                  ? 'bad'
                                  : cyborg.charge <= 70
                                    ? 'average'
                                    : 'good'
                              }
                            >
                              {typeof cyborg.charge === 'number'
                                ? `${cyborg.charge}%`
                                : '无电池'}
                            </Box>
                          </LabeledList.Item>
                          <LabeledList.Item label="型号">
                            {cyborg.module}
                          </LabeledList.Item>
                        </LabeledList>
                      </Section>
                    </Stack.Item>
                  ))}
                </Stack>
                <Stack.Divider />
              </Stack.Item>
            ))}
          </Stack>

          {!cyborg_groups.length && (
            <NoticeBox textAlign="center" top="30%" position="relative">
              <Box fontSize={2}>
                无法连接——网络状态未知
              </Box>
            </NoticeBox>
          )}
        </Flex.Item>
      )}
    </Flex>
  );
};

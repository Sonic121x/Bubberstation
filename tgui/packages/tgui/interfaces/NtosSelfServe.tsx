import { Button, NoticeBox, Section, Stack } from 'tgui-core/components';
import { jobSelectionDisplay } from '../localization/zhJobSelectionDisplay';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';
import type { NTOSData } from '../layouts/NtosWindow';
import { displayRole } from '../localization/roleDisplay';
type Data = {
  authCard: string;
  authCardTimeRemaining: string;
  authIDName: string;
  authIDRank: string;
  hasTrim: boolean;
  trimAssignment: string;
  stationAlertLevel: string;
  trimClockedOut: boolean;
  authCardHOPLocked: boolean;
  authCardTimeLocked: boolean;
  selfServeBlock: boolean;
} & NTOSData;

export const NtosSelfServe = (props) => {
  const { act, data } = useBackend<Data>();

  return (
    <NtosWindow width={400} height={522}>
      <NtosWindow.Content>
        <Stack>
          <Stack.Item width="100%">
            <SelfServePage />
          </Stack.Item>
        </Stack>
      </NtosWindow.Content>
    </NtosWindow>
  );
};

const SelfServePage = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    authCardTimeRemaining,
    authIDName,
    authIDRank,
    authCardHOPLocked,
    authCardTimeLocked,
    stationAlertLevel,
    trimClockedOut,
    trimAssignment,
  } = data;

  return (
    <Section title="企业资源规划">
      <Section title={`欢迎，${authIDName}`}>
        <Stack wrap="wrap">
          <Stack.Item width="100%" mt={1} ml={0}>
            当前职务：{displayRole(trimAssignment || '-----')}
          </Stack.Item>
          <Stack.Item align="center" mt={1} ml={0}>
            职位名称：{displayRole(authIDRank || '-----')}
          </Stack.Item>
          <Stack.Item width="100%" mt={1} ml={0}>
            当前状态：{trimClockedOut ? '休班' : '在岗'}
          </Stack.Item>
          <Stack.Item width="100%" mt={1} ml={0}>
            空间站警报等级：{jobSelectionDisplay(stationAlertLevel) || '-----'}
          </Stack.Item>
        </Stack>
      </Section>

      <Section title="考勤打卡">
        <Stack wrap="wrap">
          <Stack.Item width="100%" mt={1} ml={0}>
            <Stack>
              <Stack.Item>
                <Button
                  width="342px"
                  disabled={
                    authCardHOPLocked || authCardTimeLocked || !authIDName
                  }
                  onClick={() => act('PRG_change_status')}
                >
                  <center>
                    {trimClockedOut
                      ? '返回工作岗位'
                      : '下班打卡'}
                  </center>
                </Button>
              </Stack.Item>
              <Stack.Item>
                <Button
                  right="0px"
                  width="100%"
                  icon="eject"
                  onClick={() => act('PRG_eject_id')}
                />
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Section>
      <Section title="岗位信息">
        <Stack wrap="wrap">
          {!trimClockedOut ? (
            <Stack.Item width="100%" mt={0} ml={0}>
              <NoticeBox info>
                下班打卡前，请将重要或仅限工作场所使用的
                岗位装备归还。
              </NoticeBox>
              <NoticeBox info>
                休班期间，受限制的物品将存入
                船员装备锁箱，上班打卡时归还。
              </NoticeBox>
            </Stack.Item>
          ) : (
            ''
          )}
          {authCardHOPLocked ? (
            <Stack.Item width="100%" mt={0} ml={0}>
              <NoticeBox danger>
                岗位已锁定！
                <br />
                <br />
                安保和指挥人员必须找有相应权限的指挥人员，
                才能上班打卡！
              </NoticeBox>
            </Stack.Item>
          ) : authCardTimeLocked ? (
            <Stack.Item width="100%" mt={0} ml={0}>
              <NoticeBox>
                现在还不能返回岗位！
                <br />
                剩余时间：{authCardTimeRemaining}
                <br />
                <br />
                请前往人事主管窗口或联系本部门主管，
                以解除限制。
              </NoticeBox>
            </Stack.Item>
          ) : (
            ''
          )}
        </Stack>
      </Section>
    </Section>
  );
};

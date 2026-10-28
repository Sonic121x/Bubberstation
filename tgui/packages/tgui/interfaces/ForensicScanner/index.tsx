import { Button, NoticeBox, Section } from 'tgui-core/components';
import { useBackend } from '../../backend';
import { Window } from '../../layouts';
import { ForensicLogs } from './ForensicLogs';
import type { ForensicScannerData } from './types';

export function ForensicScanner() {
  const { act, data } = useBackend<ForensicScannerData>();
  const { logs = [] } = data;
  return (
    <Window width={512} height={512}>
      <Window.Content>
        {logs.length === 0 ? (
          <NoticeBox>日志为空。</NoticeBox>
        ) : (
          <Section
            title="扫描历史"
            fill
            scrollable
            buttons={
              <>
                <Button.Confirm
                  icon="trash"
                  color="danger"
                  onClick={() => act('clear')}
                >
                  清除日志
                </Button.Confirm>
                <Button icon="print" onClick={() => act('print')}>
                  打印报告
                </Button>
              </>
            }
          >
            {logs
              .map((log, index) => (
                <ForensicLogs
                  key={index}
                  dataEntries={log.dataEntries}
                  scanTarget={log.scanTarget}
                  scanTime={log.scanTime}
                  index={index}
                />
              ))
              .reverse()}
          </Section>
        )}
      </Window.Content>
    </Window>
  );
}

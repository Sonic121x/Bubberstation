import { LabeledList, NoticeBox } from 'tgui-core/components';
import { orbitDisplay } from '../../localization/zhOrbitDisplay';
import type { Antagonist, Observable } from './types';

type Props = {
  item: Observable | Antagonist;
  realNameDisplay: boolean;
};

/** Displays some info on the mob as a tooltip. */
export function OrbitTooltip(props: Props) {
  const { item, realNameDisplay } = props;
  const { extra, full_name, health, job, mind_job } = item;

  let antag;
  if ('antag' in item) {
    antag = item.antag;
  }

  const extraInfo = extra?.split(/[:：](.*)/s);
  const displayHealth = health && health >= 0 ? `${health}%` : '濒危';
  const showAFK = 'client' in item && !item.client;
  const displayJob = realNameDisplay ? mind_job : job;

  return (
    <>
      <NoticeBox textAlign="center" nowrap info={showAFK}>
        最近已知数据
      </NoticeBox>
      <LabeledList>
        {extraInfo ? (
          <LabeledList.Item label={extraInfo[0]}>
            {extraInfo[1]}
          </LabeledList.Item>
        ) : (
          <>
            {!!full_name && (
              <LabeledList.Item label="真实身份">{full_name}</LabeledList.Item>
            )}
            {!!displayJob && (
              <LabeledList.Item label="职业">{orbitDisplay(displayJob)}</LabeledList.Item>
            )}
            {!!antag && (
              <LabeledList.Item label="威胁">{orbitDisplay(antag)}</LabeledList.Item>
            )}
            {!!health && (
              <LabeledList.Item label="健康">
                {displayHealth}
              </LabeledList.Item>
            )}
          </>
        )}
        {showAFK && <LabeledList.Item label="状态">暂离</LabeledList.Item>}
      </LabeledList>
    </>
  );
}

import { NoticeBox } from 'tgui-core/components';

interface TechwebWarningProps {
  display: boolean;
}

export const TechwebWarning = (props: TechwebWarningProps) => {
  const { display } = props;
  if (!display) {
    return null;
  }
  return (
    <NoticeBox danger>
      <b>警告：</b>未连接科技网络！
    </NoticeBox>
  );
};

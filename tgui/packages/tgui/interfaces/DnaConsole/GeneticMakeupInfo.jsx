import { LabeledList, Section } from 'tgui-core/components';

export const GeneticMakeupInfo = (props) => {
  const { makeup } = props;

  return (
    <Section title="酶信息">
      <LabeledList>
        <LabeledList.Item label="姓名">
          {makeup.name || '无'}
        </LabeledList.Item>
        <LabeledList.Item label="血型">
          {makeup.blood_type || '无'}
        </LabeledList.Item>
        <LabeledList.Item label="独特酶">
          {makeup.UE || '无'}
        </LabeledList.Item>
        <LabeledList.Item label="独特标识符">
          {makeup.UI || '无'}
        </LabeledList.Item>
        <LabeledList.Item label="独特特征">
          {makeup.UF || '无'}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

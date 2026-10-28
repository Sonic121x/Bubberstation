import { Box, Button, Icon, LabeledList } from 'tgui-core/components';

import { useBackend } from '../../backend';

export const ReagentLookup = (props) => {
  const { reagent } = props;
  const { act } = useBackend();
  if (!reagent) {
    return <Box>未选择试剂！</Box>;
  }

  return (
    <LabeledList>
      <LabeledList.Item label="试剂">
        <Icon name="circle" mr={1} color={reagent.reagentCol} />
        {reagent.name}
        <Button
          ml={1}
          icon="wifi"
          color="teal"
          tooltip="打开此试剂对应的维基页面。"
          tooltipPosition="left"
          onClick={() => {
            Byond.command(`wiki Guide_to_chemistry#${reagent.name}`);
          }}
        />
      </LabeledList.Item>
      <LabeledList.Item label="描述">{reagent.desc}</LabeledList.Item>
      <LabeledList.Item label="pH">
        <Icon name="circle" mr={1} color={reagent.pHCol} />
        {reagent.pH}
      </LabeledList.Item>
      <LabeledList.Item label="性质">
        <LabeledList>
          {!!reagent.OD && (
            <LabeledList.Item label="过量阈值">{reagent.OD}u</LabeledList.Item>
          )}
          {reagent.addictions[0] && (
            <LabeledList.Item label="成瘾性">
              {reagent.addictions.map((addiction) => (
                <Box key={addiction}>{addiction}</Box>
              ))}
            </LabeledList.Item>
          )}
          <LabeledList.Item label="代谢速率">
            {reagent.metaRate}u/s
          </LabeledList.Item>
        </LabeledList>
      </LabeledList.Item>
      <LabeledList.Item label="杂质">
        <LabeledList>
          {reagent.impureReagent && (
            <LabeledList.Item label="杂质试剂">
              <Button
                icon="vial"
                tooltip="摄入时，若纯度高于逆转纯度阈值，部分试剂会转化为此物质。"
                tooltipPosition="left"
                content={reagent.impureReagent}
                onClick={() =>
                  act('reagent_click', {
                    id: reagent.impureId,
                  })
                }
              />
            </LabeledList.Item>
          )}
          {reagent.inverseReagent && (
            <LabeledList.Item label="逆转试剂">
              <Button
                icon="vial"
                content={reagent.inverseReagent}
                tooltip="摄入时，若纯度低于逆转纯度阈值，试剂会转化为此物质。"
                tooltipPosition="left"
                onClick={() =>
                  act('reagent_click', {
                    id: reagent.inverseId,
                  })
                }
              />
            </LabeledList.Item>
          )}
          {reagent.failedReagent && (
            <LabeledList.Item label="失败产物">
              <Button
                icon="vial"
                tooltip="反应完成时，若纯度低于最低纯度，试剂会转化为此物质。"
                tooltipPosition="left"
                content={reagent.failedReagent}
                onClick={() =>
                  act('reagent_click', {
                    id: reagent.failedId,
                  })
                }
              />
            </LabeledList.Item>
          )}
        </LabeledList>
        {reagent.isImpure && <Box>此试剂由杂质产生。</Box>}
        {reagent.deadProcess && <Box>此试剂对死者也有效。</Box>}
        {!reagent.failedReagent &&
          !reagent.inverseReagent &&
          !reagent.impureReagent && (
            <Box>此试剂不会产生杂质试剂。</Box>
          )}
      </LabeledList.Item>
      <LabeledList.Item>
        <Button
          icon="flask"
          mt={2}
          content={'查找相关反应'}
          color="purple"
          onClick={() =>
            act('find_reagent_reaction', {
              id: reagent.id,
            })
          }
        />
      </LabeledList.Item>
    </LabeledList>
  );
};

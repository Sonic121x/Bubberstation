import { Button, Dropdown, Section, Stack } from 'tgui-core/components';

import { useBackend, useSharedState } from '../backend';
import { Window } from '../layouts';
import { machineChoiceDisplay } from './common/machineChoiceDisplay';
export const PaintingMachine = (props) => {
  const { act, data } = useBackend();

  const { pdaTypes, cardTrims, hasPDA, pdaName, hasID, idName } = data;

  const [selectedPDA] = useSharedState(
    'pdaSelection',
    pdaTypes[Object.keys(pdaTypes)[0]],
  );

  const [selectedTrim] = useSharedState(
    'trimSelection',
    cardTrims[Object.keys(cardTrims)[0]],
  );

  return (
    <Window width={500} height={620}>
      <Window.Content scrollable>
        <Section
          title="PDA 涂装机"
          buttons={
            <>
              <Button.Confirm
                disabled={!hasPDA}
                content="涂装 PDA"
                confirmContent="确认？"
                onClick={() =>
                  act('trim_pda', {
                    selection: selectedPDA,
                  })
                }
              />
              <Button.Confirm
                disabled={!hasPDA}
                content="重置身份绑定"
                confirmContent="确认？"
                onClick={() => {
                  act('reset_pda');
                }}
              />
            </>
          }
        >
          <Stack vertical>
            <Stack.Item height="100%">
              <EjectButton
                name={pdaName || '-----'}
                onClickEject={() => act('eject_pda')}
              />
            </Stack.Item>
            <Stack.Item height="100%">
              <PainterDropdown stateKey="pdaSelection" options={pdaTypes} />
            </Stack.Item>
          </Stack>
        </Section>
        <Section
          title="ID 卡饰边写入机"
          buttons={
            <>
              <Button.Confirm
                disabled={!hasID}
                content="重置 ID 卡账户"
                confirmContent="确认？"
                onClick={() => act('reset_card')}
              />
              <Button.Confirm
                disabled={!hasID}
                content="写入 ID 卡饰边"
                confirmContent="确认？"
                onClick={(sel) =>
                  act('trim_card', {
                    selection: selectedTrim,
                  })
                }
              />
              <Button
                icon="question-circle"
                tooltip={
                  '警告：此操作具有破坏性，' +
                  '将清除卡片上的所有通行权限。'
                }
                tooltipPosition="left"
              />
            </>
          }
        >
          <Stack vertical>
            <Stack.Item height="100%">
              <EjectButton
                name={idName || '-----'}
                onClickEject={() => act('eject_card')}
              />
            </Stack.Item>
            <Stack.Item height="100%">
              <PainterDropdown stateKey="trimSelection" options={cardTrims} />
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};

export const EjectButton = (props) => {
  const { name, onClickEject } = props;

  return (
    <Button
      fluid
      ellipsis
      icon="eject"
      content={name}
      onClick={() => onClickEject()}
    />
  );
};

export const PainterDropdown = (props) => {
  const { stateKey, options } = props;

  const [selectedOption, setSelectedOption] = useSharedState(
    stateKey,
    options[Object.keys(options)[0]],
  );

  return (
    <Dropdown
      width="100%"
      selected={selectedOption} displayText={machineChoiceDisplay(selectedOption)}
      options={Object.keys(options).map((path) => {
        return { value: options[path], displayText: machineChoiceDisplay(options[path]) };
      })}
      onSelected={(sel) => setSelectedOption(sel)}
    />
  );
};

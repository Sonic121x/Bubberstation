import {
  Collapsible,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
  Tooltip,
} from 'tgui-core/components';

import { getColor } from './helpers';
import type { Threshold } from './types';

/**
 * Similar to the virus info display.
 * Returns info about symptoms as collapsibles.
 */
export const SymptomDisplay = (props) => {
  const { symptoms = [] } = props;
  if (!symptoms?.length) {
    return <NoticeBox>未检测到症状。</NoticeBox>;
  }

  return (
    <Section fill title="症状">
      {symptoms.map((symptom) => {
        const { name, desc, threshold_desc } = symptom;
        return (
          <Collapsible key={name} title={name}>
            <Stack fill>
              <Stack.Item grow={3}>
                {desc}
                <Thresholds thresholds={threshold_desc} />
              </Stack.Item>
              <Stack.Divider />
              <Stack.Item grow={1}>
                <Traits symptom={symptom} />
              </Stack.Item>
            </Stack>
          </Collapsible>
        );
      })}
    </Section>
  );
};

/** Displays threshold data */
const Thresholds = (props) => {
  const { thresholds = [] } = props;
  const convertedThresholds = Object.entries<Threshold>(thresholds);

  return (
    <Section mt={1} title="阈值">
      {!convertedThresholds.length ? (
        <NoticeBox>无</NoticeBox>
      ) : (
        <LabeledList>
          {convertedThresholds.map(([label, descr], index) => {
            return (
              <LabeledList.Item key={index} label={label}>
                {String(descr)}
              </LabeledList.Item>
            );
          })}
        </LabeledList>
      )}
    </Section>
  );
};

/** Displays the numerical trait modifiers for a virus symptom */
const Traits = (props) => {
  const {
    symptom: { level, resistance, stage_speed, stealth, transmission, symptom_cure, cure_color},
  } = props;

  return (
    <Section title="修正值">
      <LabeledList>
        <Tooltip content="症状的稀有程度。">
          <LabeledList.Item color={getColor(level)} label="等级">
            {level}
          </LabeledList.Item>
        </Tooltip>
        <Tooltip content="抵抗治疗和自然康复的能力。">
          <LabeledList.Item color={getColor(resistance)} label="抗性">
            {resistance}
          </LabeledList.Item>
        </Tooltip>
        <Tooltip content="症状发展的速度。">
          <LabeledList.Item color={getColor(stage_speed)} label="阶段速度">
            {stage_speed}
          </LabeledList.Item>
        </Tooltip>
        <Tooltip content="医疗设备检测到症状的难度。">
          <LabeledList.Item color={getColor(stealth)} label="隐蔽性">
            {stealth}
          </LabeledList.Item>
        </Tooltip>
        <Tooltip content="决定传播方式。">
          <LabeledList.Item color={getColor(transmission)} label="传播性">
            {transmission}
          </LabeledList.Item>
        </Tooltip>
        <Tooltip content="可治疗此症状的试剂。">
          <LabeledList.Item color={cure_color} label="治疗药物">
            {symptom_cure}
          </LabeledList.Item>
        </Tooltip>
      </LabeledList>
    </Section>
  );
};

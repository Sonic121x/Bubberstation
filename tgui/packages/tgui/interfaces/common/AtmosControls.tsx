import {
  Button,
  LabeledList,
  NumberInput,
  Section,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { decodeHtmlEntities } from 'tgui-core/string';

import { useBackend } from '../../backend';
import { getGasLabel } from '../../constants';

export type VentProps = {
  refID: string;
  long_name: string;
  power: BooleanLike;
  overclock: BooleanLike;
  integrity: number;
  checks: number;
  excheck: BooleanLike;
  incheck: BooleanLike;
  direction: number;
  external: number;
  internal: number;
  extdefault: number;
  intdefault: number;
};

export type ScrubberProps = {
  refID: string;
  long_name: string;
  power: BooleanLike;
  scrubbing: BooleanLike;
  widenet: BooleanLike;
  filter_types: {
    gas_id: string;
    gas_name: string;
    enabled: BooleanLike;
  }[];
};

export const Vent = (props: VentProps) => {
  const { act } = useBackend();
  const {
    refID,
    long_name,
    power,
    overclock,
    integrity,
    checks,
    excheck,
    incheck,
    direction,
    external,
    internal,
    extdefault,
    intdefault,
  } = props;
  return (
    <Section
      title={decodeHtmlEntities(long_name)}
      buttons={
        <>
          <Button
            icon={power ? 'power-off' : 'times'}
            selected={power}
            disabled={integrity <= 0}
            content={power ? '开启' : '关闭'}
            onClick={() =>
              act('power', {
                ref: refID,
                val: Number(!power),
              })
            }
          />
          <Button
            icon="gauge-high"
            color={overclock ? 'green' : 'yellow'}
            disabled={integrity <= 0}
            onClick={() =>
              act('overclock', {
                ref: refID,
              })
            }
            tooltip={`${overclock ? '禁用' : '启用'}超频`}
          />
        </>
      }
    >
      <LabeledList>
        <LabeledList.Item label="完整度">
          <p
            title={
              '超频可使通风口克服极端压力，但也会持续损伤通风口，最终导致故障。完整度越低，正常运行时的效率也越低。'
            }
          >
            {(integrity * 100).toFixed(2)}%
          </p>
        </LabeledList.Item>
        <LabeledList.Item label="模式">
          <Button
            icon="sign-in-alt"
            content={direction ? '加压' : '虹吸'}
            color={!direction && 'danger'}
            onClick={() =>
              act('direction', {
                ref: refID,
                val: Number(!direction),
              })
            }
          />
        </LabeledList.Item>
        <LabeledList.Item label="压力调节">
          <Button
            icon="sign-in-alt"
            content="内部"
            selected={incheck}
            onClick={() =>
              act('incheck', {
                ref: refID,
                val: checks,
              })
            }
          />
          <Button
            icon="sign-out-alt"
            content="外部"
            selected={excheck}
            onClick={() =>
              act('excheck', {
                ref: refID,
                val: checks,
              })
            }
          />
        </LabeledList.Item>
        {!!incheck && (
          <LabeledList.Item label="内部目标压力">
            <NumberInput
              value={Math.round(internal)}
              unit="kPa"
              width="75px"
              minValue={0}
              step={10}
              maxValue={5066}
              onChange={(value) =>
                act('set_internal_pressure', {
                  ref: refID,
                  value,
                })
              }
            />
            <Button
              icon="undo"
              disabled={intdefault}
              content="重置"
              onClick={() =>
                act('reset_internal_pressure', {
                  ref: refID,
                })
              }
            />
          </LabeledList.Item>
        )}
        {!!excheck && (
          <LabeledList.Item label="外部目标压力">
            <NumberInput
              value={Math.round(external)}
              unit="kPa"
              width="75px"
              minValue={0}
              step={10}
              maxValue={5066}
              onChange={(value) =>
                act('set_external_pressure', {
                  ref: refID,
                  value,
                })
              }
            />
            <Button
              icon="undo"
              disabled={extdefault}
              content="重置"
              onClick={() =>
                act('reset_external_pressure', {
                  ref: refID,
                })
              }
            />
          </LabeledList.Item>
        )}
      </LabeledList>
    </Section>
  );
};

export const Scrubber = (props: ScrubberProps) => {
  const { act } = useBackend();
  const { long_name, power, scrubbing, refID, widenet, filter_types } = props;
  return (
    <Section
      title={decodeHtmlEntities(long_name)}
      buttons={
        <Button
          icon={power ? 'power-off' : 'times'}
          content={power ? '开启' : '关闭'}
          selected={power}
          onClick={() =>
            act('power', {
              ref: refID,
              val: Number(!power),
            })
          }
        />
      }
    >
      <LabeledList>
        <LabeledList.Item label="模式">
          <Button
            icon={scrubbing ? 'filter' : 'sign-in-alt'}
            color={!scrubbing && 'danger'}
            content={scrubbing ? '洗涤' : '虹吸'}
            onClick={() =>
              act('scrubbing', {
                ref: refID,
                val: Number(!scrubbing),
              })
            }
          />
          <Button
            icon={widenet ? 'expand' : 'compress'}
            selected={widenet}
            content={widenet ? '扩大范围' : '正常范围'}
            onClick={() =>
              act('widenet', {
                ref: refID,
                val: Number(!widenet),
              })
            }
          />
        </LabeledList.Item>
        <LabeledList.Item label="过滤器">
          {(scrubbing &&
            filter_types.map((filter) => (
              <Button
                key={filter.gas_id}
                icon={filter.enabled ? 'check-square-o' : 'square-o'}
                tooltip={getGasLabel(filter.gas_id, filter.gas_name)}
                selected={filter.enabled}
                onClick={() =>
                  act('toggle_filter', {
                    ref: refID,
                    val: filter.gas_id,
                  })
                }
              >
                {getGasLabel(filter.gas_id, filter.gas_name)}
              </Button>
            ))) ||
            '不适用'}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

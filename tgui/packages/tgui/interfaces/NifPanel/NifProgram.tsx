// THIS IS A BUBBER UI FILE
import { useBackend } from 'tgui/backend';
import {
  BlockQuote,
  Button,
  Collapsible,
  Icon,
  Table,
} from 'tgui-core/components';
import type { NifPanelData, NifProgramData } from './data';

export function NifProgram(props: { src: NifProgramData }) {
  const { act, data } = useBackend<NifPanelData>();
  const { max_power } = data;
  const {
    name,
    desc,
    active,
    active_mode,
    activation_cost,
    active_cost,
    reference,
    ui_icon,
    able_to_keep,
    keep_installed,
  } = props.src;

  return (
    <Collapsible
      title={name}
      icon={ui_icon}
      buttons={
        <>
          <Button.Confirm
            icon="trash"
            color="red"
            tooltip="卸载"
            confirmContent="确认卸载？"
            onClick={() =>
              act('uninstall_nifsoft', {
                nifsoft_to_remove: reference,
              })
            }
          />
          <Button
            icon="floppy-disk"
            color={!able_to_keep ? 'grey' : keep_installed ? 'green' : null}
            tooltip={
              !able_to_keep
                ? '无法跨班次保存'
                : keep_installed
                  ? '已启用跨班次保存'
                  : '未启用跨班次保存'
            }
            disabled={!able_to_keep}
            onClick={() =>
              act('toggle_keeping_nifsoft', {
                nifsoft_to_keep: reference,
              })
            }
          />
          <Button
            icon={!active_mode ? 'power-off' : active ? 'pause' : 'play'}
            color={active ? 'yellow' : 'green'}
            tooltip={!active_mode ? '激活' : active ? '停止' : '启动'}
            onClick={() =>
              act('activate_nifsoft', {
                activated_nifsoft: reference,
              })
            }
          />
        </>
      }
    >
      <Table mb="5px">
        <Table.Row>
          <Table.Cell>
            <Icon
              name={!activation_cost ? 'check' : 'plug'}
              color="yellow"
              mr="5px"
            />
            {!activation_cost
              ? '激活不消耗电量'
              : `每次激活消耗 ${+(activation_cost / max_power) * 100}% 电量`}
          </Table.Cell>
          <Table.Cell>
            <Icon
              name={active_cost ? 'battery-half' : 'battery-empty'}
              color="orange"
              mr="5px"
            />
            {!active_cost
              ? '运行不消耗电量'
              : `运行时消耗 ${(active_cost / max_power) * 100}% 电量`}
          </Table.Cell>
          <Table.Cell>
            <Icon name="power-off" color={active ? 'green' : 'red'} mr="5px" />
            {active ? '已激活' : '未激活'}
          </Table.Cell>
        </Table.Row>
      </Table>
      <BlockQuote preserveWhitespace>{desc}</BlockQuote>
    </Collapsible>
  );
}

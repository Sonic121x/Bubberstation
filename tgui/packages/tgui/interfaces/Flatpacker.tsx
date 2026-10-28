import {
  Box,
  Button,
  Dimmer,
  Icon,
  Image,
  NoticeBox,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { toTitleCase } from 'tgui-core/string';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { MaterialAccessBar } from './Fabrication/MaterialAccessBar';
import { MaterialIcon } from './Fabrication/MaterialIcon';
import type { Material } from './Fabrication/Types';
import { materialDisplay } from '../localization/batchThreeDisplay';
type Data = {
  SHEET_MATERIAL_AMOUNT: number;
  materials: Material[];
  design?: Design;
  busy: BooleanLike;
};

type Design = {
  name: string;
  icon: string;
  requiredMaterials: Material[];
  disableReason?: string;
};

export const Flatpacker = (props: any) => {
  const { act, data } = useBackend<Data>();
  const { SHEET_MATERIAL_AMOUNT, materials, design, busy } = data;

  return (
    <Window width={670} height={400} title="平装打包机">
      <Window.Content>
        {!!busy && (
          <Dimmer
            style={{
              fontSize: '2em',
              textAlign: 'center',
            }}
          >
            <Icon name="cog" spin />
            {' 正在制造平装套件……'}
          </Dimmer>
        )}
        <Stack fill vertical align="stretch">
          <Stack.Item>
            <Stack>
              <Stack.Item grow>
                <Section>
                  <Box
                    className="FabricatorRecipe__Label"
                    style={{
                      fontFamily: 'Helvetica',
                      fontSize: '18px',
                    }}
                  >
                    {design ? toTitleCase(design.name) : '无电路板！'}
                  </Box>
                </Section>
              </Stack.Item>
              <Stack.Item>
                <Button
                  tooltip="弹出电路板"
                  tooltipPosition="left"
                  height="37px"
                  width="37px"
                  disabled={!design}
                  onClick={() => act('ejectBoard')}
                >
                  <Icon name="eject" size={1.5} mt="0.8rem" ml="0rem" />
                </Button>
              </Stack.Item>
            </Stack>
          </Stack.Item>
          <Stack.Item grow>
            {design ? (
              <Stack fill>
                <Stack.Item width={15}>
                  <BoardPreview design={design} onPrint={() => act('build')} />
                </Stack.Item>
                <Stack.Item grow>
                  <CostPreview
                    SHEET_MATERIAL_AMOUNT={SHEET_MATERIAL_AMOUNT}
                    materials={design.requiredMaterials}
                  />
                </Stack.Item>
              </Stack>
            ) : (
              <NoticeBox>未放入电路板！</NoticeBox>
            )}
          </Stack.Item>
          <Stack.Item>
            <Section fill>
              <MaterialAccessBar
                availableMaterials={materials}
                SHEET_MATERIAL_AMOUNT={SHEET_MATERIAL_AMOUNT}
                onEjectRequested={(material, amount) =>
                  act('eject', { ref: material.ref, amount })
                }
              />
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

type BoardPreviewProps = {
  design: Design;
  onPrint: () => void;
};

const BoardPreview = (props: BoardPreviewProps) => {
  const { design, onPrint } = props;

  return (
    <Section fill>
      <Stack fill vertical justify="space-between">
        <Stack.Item>
          <Stack vertical align="center">
            <Stack.Item>
              <Image
                width="128px"
                height="128px"
                src={`data:image/jpeg;base64,${design.icon}`}
              />
            </Stack.Item>
          </Stack>
        </Stack.Item>
        <Stack.Item>
          <Button
            bold
            fluid
            p={1}
            icon="cog"
            fontSize={1.2}
            textAlign="center"
            disabled={design?.disableReason !== ''}
            tooltip={design.disableReason}
            tooltipPosition="bottom"
            onClick={() => onPrint()}
          >
            打印
          </Button>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

type CostPreviewProps = {
  SHEET_MATERIAL_AMOUNT: number;
  materials?: Material[];
};

const CostPreview = (props: CostPreviewProps) => {
  const { materials, SHEET_MATERIAL_AMOUNT } = props;

  return (
    <Section fill scrollable>
      {materials ? (
        <Table>
          {materials.map((material) => (
            <Table.Row key={material.name} className="candystripe">
              <Table.Cell verticalAlign="middle">
                <div style={{ width: '200px' }}>
                  <MaterialIcon
                    materialName={material.name}
                    sheets={material.amount / SHEET_MATERIAL_AMOUNT}
                  />
                </div>
              </Table.Cell>
              <Table.Cell verticalAlign="middle">
                <div style={{ width: '200px' }}>
                  {materialDisplay(material.name)}
                </div>
              </Table.Cell>
              <Table.Cell verticalAlign="middle">
                <div style={{ width: '200px' }}>
                  x{(material.amount / SHEET_MATERIAL_AMOUNT).toFixed(2)}
                </div>
              </Table.Cell>
            </Table.Row>
          ))}
        </Table>
      ) : (
        <NoticeBox>无需材料！</NoticeBox>
      )}
    </Section>
  );
};

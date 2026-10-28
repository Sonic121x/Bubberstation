import { Window } from '../layouts';
import { useBackend } from '../backend';
import { GenericUplink, type Item } from './Uplink/GenericUplink';

type MalfModuleData = {
  name: string,
  icon: string,
  icon_state: string,
  cost: number,
  desc: string,
  category: string,
  minimumApcs: number,
};

type Data = {
  processingTime: number;
  hackedAPCs: number;
  categories: string[];
  modules: MalfModuleData[];
};

export function MalfunctionModulePicker(props) {
  const { act, data } = useBackend<Data>();
  const { processingTime, hackedAPCs, categories } = data;

  const items: Item[] = data.modules.map((module) => ({
    category: module.category,
    cost: `${module.cost} 处理点`,
    desc:
      module.desc +
      (module.minimumApcs > 0
        ? ` 至少需要入侵 ${module.minimumApcs} 台 APC。`
        : ''),
    disabled: processingTime < module.cost || hackedAPCs < module.minimumApcs,
    id: module.name,
    name: module.name,
    icon: module.icon,
    icon_state: module.icon_state,
    population_tooltip: '',
    insufficient_population: false,
  }))

  return (
    <Window width={620} height={525} theme='malfunction'>
      <Window.Content>
        <GenericUplink
          categories={categories}
          items={items}
          currency={`${processingTime} 处理点`}
          handleBuy={(item) => act('buy', { name: item.name })}
        />
      </Window.Content>
    </Window>
  );
}

import { Section, VirtualList } from 'tgui-core/components';

import { useRemappedBackend } from '../helpers';
import { TechNode } from '../nodes/TechNode';
import type { TechwebNode } from '../types';

export function TechwebDesignDisk(props) {
  const { data } = useRemappedBackend();
  const { design_cache, d_disk } = data;
  if (!d_disk) return;

  const { blueprints } = d_disk;

  return (
    <>
      {blueprints.map((x, i) => (
        <Section key={i} title={`槽位 ${i + 1}`}>
          {(x === null && '空') || (
            <>
              包含 <b>{design_cache[x].name}</b> 的设计：<br />
              <span
                className={`${design_cache[x].class} Techweb__DesignIcon`}
              />
            </>
          )}
        </Section>
      ))}
    </>
  );
}

export function TechwebTechDisk(props) {
  const { data } = useRemappedBackend();
  const { t_disk } = data;
  if (!t_disk) return;

  const { stored_research } = t_disk;

  return (
    <Section scrollable fill>
      <VirtualList>
        {Object.keys(stored_research)
          .map((x) => ({ id: x }))
          .map((n) => (
            <TechNode key={n.id} nocontrols node={n as TechwebNode} />
          ))}
      </VirtualList>
    </Section>
  );
}

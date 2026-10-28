import { capitalizeFirst } from 'tgui-core/string';
import type { OperationData } from './types';

export function extractSurgeryName(
  operation: OperationData,
  catalog: boolean,
): { name: string; tool: string; true_name?: string } {
  // operation names may be "make incision", "lobotomy", or "disarticulation (amputation)"
  const { name, tool_rec } = operation;
  if (!name) {
    return { name: '手术错误', tool: '错误' };
  }
  const parenthesis = name.search(/[（(]/);
  if (parenthesis === -1) {
    return { name: capitalizeFirst(name), tool: tool_rec };
  }
  const in_parenthesis = name.slice(parenthesis + 1, name.search(/[）)]/)).trim();
  if (!catalog) {
    return {
      name: capitalizeFirst(in_parenthesis),
      tool: tool_rec,
    };
  }
  const out_parenthesis = capitalizeFirst(name.slice(0, parenthesis).trim());
  return {
    name: capitalizeFirst(out_parenthesis),
    tool: tool_rec,
    true_name: capitalizeFirst(in_parenthesis),
  };
}

export function extractRequirementMap(
  surgery: OperationData,
): Record<string, string[]> {
  if (surgery.requirements?.length !== 4) {
    return {}; // we can assert this never happens, but just in case...
  }
  const hard_requirements = surgery.requirements[0];
  const soft_requirements = surgery.requirements[1];
  const optional_requirements = surgery.requirements[2];
  const blocked_requirements = surgery.requirements[3];

  // you *have* to have one of the soft requirements, so if there's only one...
  if (soft_requirements.length === 1) {
    hard_requirements.push(soft_requirements[0]);
    soft_requirements.length = 0;
  }

  const optional_title = () => {
    if (optional_requirements.length === 1) {
      if (hard_requirements.length === 0) return '以下条件为可选：';
      return '另外，以下条件为可选：';
    }
    if (hard_requirements.length === 0)
      return '以下条件均为可选：';
    return '另外，以下条件均为可选：';
  };

  const blocked_title = () => {
    if (blocked_requirements.length === 1) {
      if (hard_requirements.length === 0)
        return '以下条件会阻止操作：';
      return '但以下条件会阻止操作：';
    }
    if (hard_requirements.length === 0)
      return '以下任一条件都会阻止操作：';
    return '但以下任一条件都会阻止操作：';
  };

  return {
    '必须满足以下全部条件：':
      hard_requirements,
    '另外，还必须满足以下任一条件：': soft_requirements,
    [optional_title()]: optional_requirements,
    [blocked_title()]: blocked_requirements,
  };
}

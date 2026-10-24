import { describe, expect, it } from 'bun:test';
import { displayRole, roleOption } from './roleDisplay';

describe('role display localization', () => {
  it('uses the required company, port and role terminology', () => {
    expect(displayRole('Nanotrasen Consultant')).toBe('纳米传讯顾问');
    expect(displayRole('Port Tarkon Survivor')).toBe('塔肯港幸存者');
    expect(displayRole('Captain')).toBe('舰长');
    expect(displayRole('Cyborg')).toBe('半机械人');
    expect(displayRole('Bitrunner')).toBe('比特潜行者');
  });

  it('keeps preference values and input ordering unchanged', () => {
    const titles = Object.freeze([
      'Captain',
      'Station Commander',
      'Nanotrasen Consultant',
    ]);
    const options = titles.map(roleOption);
    expect(options.map((option) => option.value)).toEqual([...titles]);
    expect(options[1]).toEqual({
      value: 'Station Commander',
      displayText: '空间站指挥官',
    });
    const submission = { job: titles[0], new_title: options[1].value };
    expect(submission).toEqual({
      job: 'Captain',
      new_title: 'Station Commander',
    });
  });

  it('preserves unknown names, including object prototype property names', () => {
    for (const value of ['Future Role', 'constructor', '__proto__', '']) {
      expect(displayRole(value)).toBe(value);
      expect(roleOption(value)).toEqual({ value, displayText: value });
    }
  });
});

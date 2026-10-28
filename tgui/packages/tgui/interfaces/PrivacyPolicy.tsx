import { Button, Section } from 'tgui-core/components';
import { useBackend } from '../backend';
import { Window } from '../layouts';

interface PrivacyPolicyData {
  policy_text: string;
}

export const PrivacyPolicy = () => {
  const { act, data } = useBackend<PrivacyPolicyData>();
  const { policy_text } = data;

  return (
    <Window width={600} height={500} title="隐私政策">
      <Window.Content scrollable>
        <Section>
          <div style={{ whiteSpace: 'pre-wrap' }}>{policy_text}</div>
        </Section>

        <Button fluid color="good" onClick={() => act('accept')}>
          我同意
        </Button>
      </Window.Content>
    </Window>
  );
};

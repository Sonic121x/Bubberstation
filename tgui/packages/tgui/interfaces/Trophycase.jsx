import {
  Box,
  Button,
  Dimmer,
  Icon,
  Image,
  Section,
  Stack,
} from 'tgui-core/components';
import { decodeHtmlEntities } from 'tgui-core/string';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const Trophycase = (props) => {
  const { act, data } = useBackend();
  return (
    <Window width={300} height={380}>
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item>
            <ShowpieceName />
          </Stack.Item>
          <Stack.Item>
            <ShowpieceImage />
          </Stack.Item>
          <Stack.Item grow>
            <ShowpieceDescription />
          </Stack.Item>
          <Stack.Divider />
          <Stack.Item>
            <HistorianPanel />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const HistorianPanel = (props) => {
  const { act, data } = useBackend();
  const {
    has_showpiece,
    historian_mode,
    holographic_showpiece,
    showpiece_description,
  } = data;

  return (
    <Section align="left">
      {!historian_mode && (
        <Button
          icon="key"
          content="插入钥匙以开启历史记录模式"
          onClick={() => act('insert_key')}
        />
      )}
      {!!historian_mode && (
        <div>
          <Button
            icon="times"
            content="锁定历史记录模式"
            onClick={() => act('lock')}
          />
          <Button
            icon="pencil"
            content="编辑描述"
            disabled={!has_showpiece || holographic_showpiece}
            onClick={() => act('change_message')}
          />
        </div>
      )}
      {!!historian_mode && !!holographic_showpiece && (
        <Box>
          当前已展示全息纪念品。请用新的纪念品替换它，
          以创建新的记录。
        </Box>
      )}
      {!!historian_mode && !has_showpiece && <Box>未找到纪念品。</Box>}
      {!!historian_mode &&
        !!has_showpiece &&
        !holographic_showpiece &&
        !!showpiece_description && (
          <Box>
            记录已开始。只要纪念品留在完好的展柜中，
            其数据就会在夜间保存。
          </Box>
        )}
      {!!historian_mode &&
        !!has_showpiece &&
        !holographic_showpiece &&
        !showpiece_description && (
          <Box>
            检测到新的纪念品。请填写描述以开始归档。
          </Box>
        )}
    </Section>
  );
};

const ShowpieceDescription = (props) => {
  const { act, data } = useBackend();
  const {
    has_showpiece,
    holographic_showpiece,
    historian_mode,
    max_length,
    showpiece_description,
  } = data;
  return (
    <Section fill align="center">
      {!has_showpiece && (
        <Box fill className="Trophycase-description">
          <b>此展柜空空如也。历史等待着你的贡献！</b>
        </Box>
      )}
      {!!holographic_showpiece && <b>{showpiece_description}</b>}
      {!holographic_showpiece && !!has_showpiece && (
        <Box fill className="Trophycase-description">
          {showpiece_description
            ? decodeHtmlEntities(showpiece_description)
            : '此展品正在布置中。取得馆长的钥匙以完成你的贡献！'}
        </Box>
      )}
    </Section>
  );
};

const ShowpieceImage = (props) => {
  const { data } = useBackend();
  const { showpiece_icon } = data;
  return showpiece_icon ? (
    <Section align="center">
      <Image
        m={1}
        src={`data:image/jpeg;base64,${showpiece_icon}`}
        height="96px"
        width="96px"
      />
    </Section>
  ) : (
    <Section align="center">
      <Box height="96px" width="96px">
        <Dimmer fontSize="32px">
          <Icon name="landmark" />
        </Dimmer>
      </Box>
    </Section>
  );
};

const ShowpieceName = (props) => {
  const { data } = useBackend();
  const { showpiece_name } = data;
  return (
    <Section align="center">
      <b>
        {showpiece_name
          ? decodeHtmlEntities(showpiece_name)
          : '布置中。'}
      </b>
    </Section>
  );
};

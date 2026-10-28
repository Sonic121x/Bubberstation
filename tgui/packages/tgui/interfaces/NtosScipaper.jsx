import {
  BlockQuote,
  Box,
  Button,
  Collapsible,
  Dropdown,
  Input,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
  Table,
  Tabs,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';

export const NtosScipaper = (props) => {
  return (
    <NtosWindow width={600} height={600}>
      <NtosWindow.Content scrollable>
        <NtosScipaperContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};

const PaperPublishing = (props) => {
  const { act, data } = useBackend();
  const {
    title,
    author,
    etAlia,
    abstract,
    fileList = [],
    expList = [],
    allowedTiers = [],
    allowedPartners = [],
    gains,
    selectedFile,
    selectedExperiment,
    tier,
    selectedPartner,
    coopIndex,
    fundingIndex,
  } = data;
  return (
    <>
      <Section title="投稿表单">
        {fileList.length === 0 && (
          <NoticeBox>
            使用数据磁盘从压缩机或多普勒阵列下载文件。
          </NoticeBox>
        )}
        <LabeledList>
          <LabeledList.Item
            label="文件（必填）"
            buttons={
              <Button
                tooltip="所选文件包含论文所需的实验数据。文件必须位于本地文件系统或数据磁盘中才能访问。"
                icon="info-circle"
              />
            }
          >
            <Box position="relative" top="8px">
              <Dropdown
                width="100%"
                options={Object.keys(fileList)}
                selected={selectedFile}
                onSelected={(ordfile_name) =>
                  act('select_file', {
                    selected_uid: fileList[ordfile_name],
                  })
                }
              />
            </Box>
          </LabeledList.Item>
          <LabeledList.Item
            label="实验（必填）"
            buttons={
              <Button
                tooltip="论文的研究课题。不同课题会解锁不同技术和潜在合作伙伴。"
                icon="info-circle"
              />
            }
          >
            <Box position="relative" top="8px">
              <Dropdown
                width="100%"
                options={Object.keys(expList)}
                selected={selectedExperiment}
                onSelected={(experiment_name) =>
                  act('select_experiment', {
                    selected_expath: expList[experiment_name],
                  })
                }
              />
            </Box>
          </LabeledList.Item>
          <LabeledList.Item
            label="等级（必填）"
            buttons={
              <Button
                tooltip="论文的发表等级。等级越高，奖励可能越好，但对数据的评审也会更加严格。"
                icon="info-circle"
              />
            }
          >
            <Box position="relative" top="8px">
              <Dropdown
                width="100%"
                options={allowedTiers.map((number) => String(number))}
                selected={String(tier)}
                onSelected={(new_tier) =>
                  act('select_tier', {
                    selected_tier: Number(new_tier),
                  })
                }
              />
            </Box>
          </LabeledList.Item>
          <LabeledList.Item
            label="合作伙伴（必填）"
            buttons={
              <Button
                tooltip="选择合作组织。我们可以获得与该组织研究兴趣相关的科技研究加成。"
                icon="info-circle"
              />
            }
          >
            <Box position="relative" top="8px">
              <Dropdown
                width="100%"
                options={Object.keys(allowedPartners)}
                selected={selectedPartner}
                onSelected={(new_partner) =>
                  act('select_partner', {
                    selected_partner: allowedPartners[new_partner],
                  })
                }
              />
            </Box>
          </LabeledList.Item>
          <LabeledList.Item
            label="主要作者"
            buttons={
              <Button
                tooltip="多位作者"
                selected={etAlia}
                icon="users"
                onClick={() => act('et_alia')}
              />
            }
          >
            <Input
              mt={2}
              fluid
              value={author}
              onBlur={(value) =>
                act('rewrite', {
                  author: value,
                })
              }
            />
          </LabeledList.Item>
          <LabeledList.Item label="标题">
            <Input
              fluid
              value={title}
              onBlur={(value) =>
                act('rewrite', {
                  title: value,
                })
              }
            />
          </LabeledList.Item>
          <LabeledList.Item label="摘要">
            <Input
              fluid
              value={abstract}
              onBlur={(value) =>
                act('rewrite', {
                  abstract: value,
                })
              }
            />
          </LabeledList.Item>
        </LabeledList>
      </Section>
      <Section title="预期成果" key="rewards">
        <Stack fill>
          <Stack.Item grow>
            <Button
              tooltip="与所选合作伙伴的关系将提升多少。合作点数可用于解锁研究加成。"
              icon="info-circle"
            />
            {' 合作点数：'}
            <BlockQuote>{gains[coopIndex]}</BlockQuote>
          </Stack.Item>
          <Stack.Item grow>
            <Button
              tooltip="发表这篇论文后将获得的资助金额。"
              icon="info-circle"
            />
            {' 资助：'}
            <BlockQuote>{gains[fundingIndex]}</BlockQuote>
          </Stack.Item>
        </Stack>
        <br />
        <Button
          lineHeight={3}
          icon="upload"
          textAlign="center"
          fluid
          onClick={() => act('publish')}
        >
          发表论文
        </Button>
      </Section>
    </>
  );
};

const PaperBrowser = (props) => {
  const { act, data } = useBackend();
  const { publishedPapers, coopIndex, fundingIndex } = data;
  if (publishedPapers.length === 0) {
    return <NoticeBox> 尚未发表论文！ </NoticeBox>;
  } else {
    return publishedPapers.map((paper) => (
      <Collapsible
        key={String(paper.experimentName + paper.tier)}
        title={paper.title}
      >
        <Section>
          <LabeledList>
            <LabeledList.Item label="课题">
              {`${paper.experimentName} - ${paper.tier}`}
            </LabeledList.Item>
            <LabeledList.Item label="作者">
              {paper.author + (paper.etAlia ? ' 等' : '')}
            </LabeledList.Item>
            <LabeledList.Item label="合作伙伴">{paper.partner}</LabeledList.Item>
            <LabeledList.Item label="收益">
              <LabeledList>
                <LabeledList.Item label="合作点数">
                  {paper.gains[coopIndex]}
                </LabeledList.Item>
                <LabeledList.Item label="资助">
                  {paper.gains[fundingIndex]}
                </LabeledList.Item>
              </LabeledList>
            </LabeledList.Item>
            <LabeledList.Item label="摘要">
              {paper.abstract}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Collapsible>
    ));
  }
};
const ExperimentBrowser = (props) => {
  const { act, data } = useBackend();
  const { experimentInformation = [] } = data;
  return experimentInformation.map((experiment) => (
    <Section title={experiment.name} key={experiment.name}>
      {experiment.description}
      <br />
      <LabeledList>
        {Object.keys(experiment.target).map((tier) => (
          <LabeledList.Item
            key={tier}
            label={
              '最佳' +
              experiment.prefix +
              '量——等级 ' +
              String(Number(tier) + 1)
            }
          >
            {`${experiment.target[tier]} ${experiment.suffix}`}
          </LabeledList.Item>
        ))}
      </LabeledList>
    </Section>
  ));
};

const PartnersBrowser = (props) => {
  const { act, data } = useBackend();
  const {
    partnersInformation,
    coopIndex,
    fundingIndex,
    purchaseableBoosts = [],
    relations = [],
    visibleNodes = [],
  } = data;
  return partnersInformation.map((partner) => (
    <Section title={partner.name} key={partner.path}>
      <Collapsible title={`关系：${relations[partner.path]}`}>
        <LabeledList>
          <LabeledList.Item label="描述">
            {partner.flufftext}
          </LabeledList.Item>
          <LabeledList.Item label="关系">
            {relations[partner.path]}
          </LabeledList.Item>
          <LabeledList.Item label="合作加成">
            {`${partner.multipliers[coopIndex]}x`}
          </LabeledList.Item>
          <LabeledList.Item label="资助加成">
            {`${partner.multipliers[fundingIndex]}x`}
          </LabeledList.Item>
          <LabeledList.Item label="接受的实验">
            {partner.acceptedExperiments.map((experiment_name) => (
              <Box key={experiment_name}>{experiment_name}</Box>
            ))}
          </LabeledList.Item>
          <LabeledList.Item label="技术共享">
            <Table>
              {partner.boostedNodes.map((node) => (
                <Table.Row key={node.id}>
                  <Table.Cell>
                    {visibleNodes.includes(node.id)
                      ? node.name
                      : '未知技术'}
                  </Table.Cell>
                  <Table.Cell>
                    <Button
                      fluid
                      tooltipPosition="left"
                      textAlign="center"
                      disabled={
                        !purchaseableBoosts[partner.path].includes(node.id)
                      }
                      content="购买"
                      tooltip={`研究费用减免：${node.discount}`}
                      onClick={() =>
                        act('purchase_boost', {
                          purchased_boost: node.id,
                          boost_seller: partner.path,
                        })
                      }
                    />
                  </Table.Cell>
                </Table.Row>
              ))}
            </Table>
          </LabeledList.Item>
        </LabeledList>
      </Collapsible>
    </Section>
  ));
};

export const NtosScipaperContent = (props) => {
  const { act, data } = useBackend();
  const { currentTab, has_techweb } = data;
  return (
    <>
      {!has_techweb && (
        <Section title="未检测到科技网络！" key="rewards">
          请将此应用与有效的科技网络同步，以便上传研究进度！
        </Section>
      )}
      <Tabs key="navigation" fluid align="center">
        <Tabs.Tab
          selected={currentTab === 1}
          onClick={() =>
            act('change_tab', {
              new_tab: 1,
            })
          }
        >
          {'发表论文'}
        </Tabs.Tab>
        <Tabs.Tab
          selected={currentTab === 2}
          onClick={() =>
            act('change_tab', {
              new_tab: 2,
            })
          }
        >
          {'已发表论文'}
        </Tabs.Tab>
        <Tabs.Tab
          selected={currentTab === 3}
          onClick={() =>
            act('change_tab', {
              new_tab: 3,
            })
          }
        >
          {'实验'}
        </Tabs.Tab>
        <Tabs.Tab
          selected={currentTab === 4}
          onClick={() =>
            act('change_tab', {
              new_tab: 4,
            })
          }
        >
          {'科研合作伙伴'}
        </Tabs.Tab>
      </Tabs>
      {currentTab === 1 && <PaperPublishing />}
      {currentTab === 2 && <PaperBrowser />}
      {currentTab === 3 && <ExperimentBrowser />}
      {currentTab === 4 && <PartnersBrowser />}
    </>
  );
};

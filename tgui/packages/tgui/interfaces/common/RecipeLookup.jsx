import {
  Box,
  Button,
  Chart,
  Flex,
  Icon,
  LabeledList,
  Tooltip,
} from 'tgui-core/components';

import { useBackend } from '../../backend';

export const RecipeLookup = (props) => {
  const { recipe, bookmarkedReactions } = props;
  const { act, data } = useBackend();
  if (!recipe) {
    return <Box>未选择反应！</Box>;
  }

  const getReaction = (id) => {
    return data.master_reaction_list.filter((reaction) => reaction.id === id);
  };

  const addBookmark = (bookmark) => {
    bookmarkedReactions.add(bookmark);
  };

  return (
    <LabeledList>
      <LabeledList.Item bold label="配方">
        <Icon name="circle" mr={1} color={recipe.reagentCol} />
        {recipe.name}
        <Button
          icon="arrow-left"
          ml={3}
          disabled={recipe.subReactIndex === 1}
          onClick={() =>
            act('reduce_index', {
              id: recipe.name,
            })
          }
        />
        <Button
          icon="arrow-right"
          disabled={recipe.subReactIndex === recipe.subReactLen}
          onClick={() =>
            act('increment_index', {
              id: recipe.name,
            })
          }
        />
        {bookmarkedReactions && (
          <Button
            icon="book"
            color="green"
            disabled={bookmarkedReactions.has(getReaction(recipe.id)[0])}
            onClick={() => {
              addBookmark(getReaction(recipe.id)[0]);
              act('update_ui');
            }}
          />
        )}
      </LabeledList.Item>
      {recipe.products && (
        <LabeledList.Item bold label="产物">
          {recipe.products.map((product) => (
            <Button
              key={product.name}
              icon="vial"
              disabled={product.hasProduct}
              content={`${product.ratio}u ${product.name}`}
              onClick={() =>
                act('reagent_click', {
                  id: product.id,
                })
              }
            />
          ))}
        </LabeledList.Item>
      )}
      <LabeledList.Item bold label="反应物">
        {recipe.reactants.map((reactant) => (
          <Box key={reactant.id}>
            <Button
              icon="vial"
              color={reactant.color}
              content={`${reactant.ratio}u ${reactant.name}`}
              onClick={() =>
                act('reagent_click', {
                  id: reactant.id,
                })
              }
            />
            {!!reactant.tooltipBool && (
              <Button
                icon="flask"
                color="purple"
                tooltip={reactant.tooltip}
                tooltipPosition="right"
                onClick={() =>
                  act('find_reagent_reaction', {
                    id: reactant.id,
                  })
                }
              />
            )}
          </Box>
        ))}
      </LabeledList.Item>
      {recipe.catalysts && (
        <LabeledList.Item bold label="催化剂">
          {recipe.catalysts.map((catalyst) => (
            <Box key={catalyst.id}>
              {(catalyst.tooltipBool && (
                <Button
                  icon="vial"
                  color={catalyst.color}
                  content={`${catalyst.ratio}u ${catalyst.name}`}
                  tooltip={catalyst.tooltip}
                  tooltipPosition={'right'}
                  onClick={() =>
                    act('reagent_click', {
                      id: catalyst.id,
                    })
                  }
                />
              )) || (
                <Button
                  icon="vial"
                  color={catalyst.color}
                  content={`${catalyst.ratio}u ${catalyst.name}`}
                  onClick={() =>
                    act('reagent_click', {
                      id: catalyst.id,
                    })
                  }
                />
              )}
            </Box>
          ))}
        </LabeledList.Item>
      )}
      {recipe.reqContainer && (
        <LabeledList.Item bold label="容器">
          <Button
            color="transparent"
            textColor="white"
            tooltipPosition="right"
            content={recipe.reqContainer}
            tooltip="进行此反应所需的容器。"
          />
        </LabeledList.Item>
      )}
      <LabeledList.Item bold label="纯度">
        <LabeledList>
          <LabeledList.Item label="最佳 pH 范围">
            <Box position="relative">
              <Tooltip content="若反应始终保持在此范围内，产物纯度将达到 100%。">
                {`${recipe.lowerpH}-${recipe.upperpH}`}
              </Tooltip>
            </Box>
          </LabeledList.Item>
          {!!recipe.inversePurity && (
            <LabeledList.Item label="逆转纯度阈值">
              <Box position="relative">
                <Tooltip content="若纯度低于此值，摄入时产物将完全转化为对应的逆转试剂。">
                  {`<${recipe.inversePurity * 100}%`}
                </Tooltip>
              </Box>
            </LabeledList.Item>
          )}
          {!!recipe.minPurity && (
            <LabeledList.Item label="最低纯度">
              <Box position="relative">
                <Tooltip content="反应过程中，纯度一旦低于此值就会产生负面效果；若完成时仍低于此值，产物将转化为对应的失败产物。">
                  {`<${recipe.minPurity * 100}%`}
                </Tooltip>
              </Box>
            </LabeledList.Item>
          )}
        </LabeledList>
      </LabeledList.Item>
      <LabeledList.Item bold label="速率曲线" width="10px">
        <Box
          height="50px"
          position="relative"
          style={{
            backgroundColor: 'black',
          }}
        >
          <Chart.Line
            fillPositionedParent
            data={recipe.thermodynamics}
            strokeWidth={0}
            fillColor={'#3cf072'}
          />
          {recipe.explosive && (
            <Chart.Line
              position="absolute"
              justify="right"
              top={0.01}
              bottom={0}
              right={recipe.isColdRecipe ? null : 0}
              width="28px"
              data={recipe.explosive}
              strokeWidth={0}
              fillColor={'#d92727'}
            />
          )}
        </Box>
        <Flex justify="space-between">
          <Tooltip
            content={
              recipe.isColdRecipe
                ? '温度降至此值时会过冷，对反应产生负面效果。'
                : '启动此反应所需的最低温度。超过此温度后继续加热可提高反应速率。'
            }
          >
            <Flex.Item
              position="relative"
              textColor={recipe.isColdRecipe && 'red'}
            >
              {recipe.isColdRecipe
                ? `${recipe.explodeTemp}K`
                : `${recipe.tempMin}K`}
            </Flex.Item>
          </Tooltip>

          {recipe.explosive && (
            <Tooltip
              content={
                recipe.isColdRecipe
                  ? '启动此反应所需的最低温度。超过此温度后继续加热可提高反应速率。'
                  : '温度升至此值时会过热，对反应产生负面效果。'
              }
            >
              <Flex.Item
                position="relative"
                textColor={!recipe.isColdRecipe && 'red'}
              >
                {recipe.isColdRecipe
                  ? `${recipe.tempMin}K`
                  : `${recipe.explodeTemp}K`}
              </Flex.Item>
            </Tooltip>
          )}
        </Flex>
      </LabeledList.Item>
      <LabeledList.Item bold label="反应动力学">
        <LabeledList>
          <LabeledList.Item label="最佳速率">
            <Tooltip content="反应可达到的最大速率，单位为每秒单位数。对应上方速率曲线的平台区。">
              <Box position="relative">{`${recipe.thermoUpper}u/s`}</Box>
            </Tooltip>
          </LabeledList.Item>
        </LabeledList>
        <Tooltip content="反应产生的热量：放热反应释放热量，吸热反应消耗热量。">
          <Box position="relative">{recipe.thermics}</Box>
        </Tooltip>
      </LabeledList.Item>
    </LabeledList>
  );
};

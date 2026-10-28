import {
  Button,
  ByondUi,
  LabeledList,
  Section,
  Tooltip,
} from 'tgui-core/components';
import { getReadableLayer, getReadablePlane } from '.';
import { type Appearance, AppearanceType, DIR, MOUSE_OPACITY } from './types';
import { useAppearanceDebugContext } from './useAppearanceDebug';

export type AppearanceInfoProps = {
  appearance: Appearance;
  onClose: React.MouseEventHandler<HTMLDivElement>;
};

export function AppearanceInfo(props: AppearanceInfoProps) {
  const { appearance, onClose } = props;
  const {
    planeToText,
    layerToText,
    flagsToText,
    visToText,
    blendToText,
    mapRefSelected,
    act,
  } = useAppearanceDebugContext();
  return (
    <Section
      fill
      scrollable
      width="400px"
      position="absolute"
      top="0px"
      right="0px"
      backgroundColor="#121212DA"
      title={`外观调试：${appearance.data.name || appearance.data.icon_state}`}
      buttons={<Button icon="times" tooltip="关闭" onClick={onClose} />}
    >
      <ByondUi
        width="384px"
        height="384px"
        params={{
          id: mapRefSelected,
          type: 'map',
        }}
      />
      <Section title="信息">
        <LabeledList>
          <LabeledList.Item label="类型">
            {appearance.data.type === AppearanceType.Atom
              ? '原子对象'
              : appearance.data.type === AppearanceType.Image
                ? '图像'
                : '可变外观'}
          </LabeledList.Item>
          {!!appearance.data.icon && (
            <LabeledList.Item label="icon">
              {appearance.data.icon}
              {appearance.inherited_icon ? '（继承）' : ''}
            </LabeledList.Item>
          )}
          {!!appearance.data.icon_state && (
            <LabeledList.Item label="icon_state">
              {appearance.data.icon_state}
              {appearance.inherited_icon_state ? '（继承）' : ''}
            </LabeledList.Item>
          )}
          <LabeledList.Item label="alpha">
            {appearance.data.alpha}
            {appearance.total_alpha !== appearance.data.alpha
              ? `（显示为 ${appearance.total_alpha}）`
              : ''}
          </LabeledList.Item>
          <LabeledList.Item label="appearance_flags">
            {Object.entries(flagsToText)
              .filter((x) => appearance.data.flags & x[1])
              .map((x) => x[0])
              .join(' | ') || '无'}
          </LabeledList.Item>
          <LabeledList.Item label="blend_mode">
            {Object.entries(blendToText)
              .find((x) => appearance.data.blend_mode.toString() === x[0])
              ?.at(1) || '错误'}
          </LabeledList.Item>
          {!!appearance.data.color && (
            <LabeledList.Item label="color">
              {typeof appearance.data.color === 'string'
                ? appearance.data.color
                : `[${appearance.data.color.join(', ')}]`}
            </LabeledList.Item>
          )}
          <LabeledList.Item label="dir">
            {`${
              Object.entries(DIR)
                .filter((x) => appearance.data.dir & x[1])
                .map((x) => x[0])
                .join(' | ') || '无'
            } (${appearance.data.dir})`}
            {appearance.inherited_dir ? '（继承）' : ''}
          </LabeledList.Item>
          {!!appearance.data.filters?.length && (
            <LabeledList.Item label="filters">
              {appearance.data.filters
                .map((x) => `${x.name} (${x.type})`)
                .join(', ')}
            </LabeledList.Item>
          )}
          <LabeledList.Item label="invisibility">
            {appearance.data.invisibility}
          </LabeledList.Item>
          <LabeledList.Item label="layer">
            {getReadableLayer(appearance, layerToText)}
            {appearance.inherited_layer ? '（继承）' : ''}
          </LabeledList.Item>
          <Tooltip content={`真实渲染平面：${appearance.data.plane_true}`}>
            <LabeledList.Item label="plane">
              {getReadablePlane(appearance, planeToText)}
              {appearance.inherited_plane ? '（继承）' : ''}
            </LabeledList.Item>
          </Tooltip>
          {!!appearance.data.maptext && (
            <>
              <LabeledList.Item label="maptext">
                {appearance.data.maptext}
              </LabeledList.Item>
              <LabeledList.Item label="maptext_width/height">
                {appearance.data.maptext_width}/{appearance.data.maptext_height}
              </LabeledList.Item>
              <LabeledList.Item label="maptext_x/y">
                {'['}
                {appearance.data.maptext_x}
                {', '}
                {appearance.data.maptext_y}
                {']'}
              </LabeledList.Item>
            </>
          )}
          <LabeledList.Item label="mouse_opacity">
            {Object.entries(MOUSE_OPACITY)
              .find((x) => appearance.data.mouse_opacity === x[1])
              ?.at(0) || '错误'}
          </LabeledList.Item>
          <LabeledList.Item label="pixel_x/y/w/z">
            {'['}
            {appearance.data.pixel_x}
            {', '}
            {appearance.data.pixel_y}
            {', '}
            {appearance.data.pixel_w}
            {', '}
            {appearance.data.pixel_z}
            {']'}
          </LabeledList.Item>
          {!!appearance.data.render_source && (
            <LabeledList.Item label="render_source">
              {appearance.data.render_source}
            </LabeledList.Item>
          )}
          {!!appearance.data.render_target && (
            <LabeledList.Item label="render_target">
              {appearance.data.render_target}
            </LabeledList.Item>
          )}
          {!!appearance.data.screen_loc && (
            <LabeledList.Item label="screen_loc">
              {appearance.data.screen_loc}
            </LabeledList.Item>
          )}
          <LabeledList.Item label="transform">
            {`[${appearance.data.transform.join(', ')}]`}
          </LabeledList.Item>
          {!!(appearance.data.vis_flags !== null) && (
            <LabeledList.Item label="vis_flags">
              {Object.entries(visToText)
                .filter((x) => (appearance.data.vis_flags as number) & x[1])
                .map((x) => x[0])
                .join(' | ') || '无'}
            </LabeledList.Item>
          )}
        </LabeledList>
      </Section>
    </Section>
  );
}

import { Box, Input, NoticeBox, Section } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';

type Data = {
  valid_id: BooleanLike;
  redeemed_coupons: CouponData[];
  printed_coupons: CouponData[];
};

type CouponData = {
  goody: string;
  discount: number;
};

export const NtosCouponMaster = (props) => {
  const { act, data } = useBackend<Data>();
  const { valid_id, redeemed_coupons = [], printed_coupons = [] } = data;
  return (
    <NtosWindow width={400} height={400}>
      <NtosWindow.Content scrollable>
        {!valid_id ? (
          <NoticeBox danger>
            未检测到有效银行账户。请插入有效身份卡。
          </NoticeBox>
        ) : (
          <>
            <NoticeBox info>
              右键点击复印机即可打印已兑换的优惠券。
            </NoticeBox>
            <Input
              fontSize={1.2}
              placeholder="在此输入优惠券代码"
              onEnter={(value) =>
                act('redeem', {
                  code: value,
                })
              }
            />
            <Section title="已兑换的优惠券">
              {redeemed_coupons.map((coupon, index) => (
                <Box key={index} className="candystripe">
                  {coupon.goody}（减价 {coupon.discount}%）
                </Box>
              ))}
            </Section>
            <Section title="已打印的优惠券">
              {printed_coupons.map((coupon, index) => (
                <Box key={index} className="candystripe">
                  {coupon.goody}（减价 {coupon.discount}%）
                </Box>
              ))}
            </Section>
          </>
        )}
      </NtosWindow.Content>
    </NtosWindow>
  );
};

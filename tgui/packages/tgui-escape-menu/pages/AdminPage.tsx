import { Tooltip } from 'tgui-core/components';

type Props = {
  serverState: {
    canAdminHelp: boolean;
    canSeeNotes: boolean;
    hasTicketNotification: boolean;
  };
  onNavigate: (page: 'home') => void;
  onAction: (action: string) => void;
  onClose: () => void;
};

export function AdminPage({
  serverState,
  onNavigate,
  onAction,
  onClose,
}: Props) {
  return (
    <>
      <BackButton onClick={() => onNavigate('home')} />
      <div className="escape-menu__buttons escape-menu__buttons--page">
        <MenuButton
          onClick={() => {
            onAction('create_ticket');
            onClose();
          }}
          disabled={!serverState.canAdminHelp}
        >
          创建管理员求助单
        </MenuButton>
        <MenuButton
          onClick={() => onAction('view_ticket')}
          blinking={serverState.hasTicketNotification}
          tooltip={
            serverState.hasTicketNotification
              ? '有管理员正在尝试联系你！'
              : undefined
          }
        >
          查看最新求助单
        </MenuButton>
        <MenuButton
          onClick={() => {
            onAction('admin_notice');
            onClose();
          }}
        >
          查看管理员通知
        </MenuButton>
        <MenuButton
          onClick={() => {
            onAction('pray');
            onClose();
          }}
        >
          祈祷
        </MenuButton>
        {!!serverState.canSeeNotes && (
          <MenuButton
            onClick={() => {
              onAction('see_notes');
              onClose();
            }}
          >
            查看记录
          </MenuButton>
        )}
      </div>
    </>
  );
}

function BackButton({ onClick }: { onClick: () => void }) {
  return (
    <button className="escape-menu__back-button" onClick={onClick}>
      <div className="escape-menu__icon-button">
        <span className="escape-menu-icons40x40 template" />
        <span className="escape-menu-icons40x40 back escape-menu__icon-overlay" />
      </div>
      <span>返回</span>
    </button>
  );
}

type MenuButtonProps = {
  children: React.ReactNode;
  onClick: () => void;
  disabled?: boolean;
  blinking?: boolean;
  tooltip?: string;
};

function MenuButton({
  children,
  onClick,
  disabled,
  blinking,
  tooltip,
}: MenuButtonProps) {
  const button = (
    <button
      className={
        'escape-menu__menu-button' +
        (disabled ? ' escape-menu__menu-button--disabled' : '') +
        (blinking ? ' escape-menu__menu-button--blinking' : '')
      }
      onClick={disabled ? undefined : onClick}
    >
      {children}
    </button>
  );

  if (tooltip) {
    return <Tooltip content={tooltip}>{button}</Tooltip>;
  }

  return button;
}

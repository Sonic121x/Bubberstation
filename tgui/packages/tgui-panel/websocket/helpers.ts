import { createLogger } from 'tgui/logging';
import { chatRenderer } from 'tgui-panel/chat/renderer';
import { store } from 'tgui-panel/events/store';
import { settingsAtom } from 'tgui-panel/settings/atoms';

const MAX_RETRIES = 10;
const RETRY_INTERVAL = 500; // ms

// Websocket close codes
const WEBSOCKET_DISABLED = 4555;
const WEBSOCKET_REATTEMPT = 4556;
const SAFE_CLOSE_CODE = 1000;

const logger = createLogger('websocket');

let websocket: WebSocket | null = null;
let reconnectTimer: number | null = null;
let retryCount = 0;
let manuallyClosed = false;

function sendWSNotice(message, small = false) {
  chatRenderer.processBatch([
    {
      html: small
        ? `<span class='adminsay'>${message}</span>`
        : `<div class="boxed_message"><center><span class='alertwarning'>${message}</span></center></div>`,
    },
  ]);
}

function clearReconnectTimer() {
  if (reconnectTimer !== null) {
    clearInterval(reconnectTimer);
    reconnectTimer = null;
  }
}

function safeClose(code = SAFE_CLOSE_CODE, reason?: string) {
  if (!websocket) return;
  if (
    websocket.readyState === WebSocket.CLOSED ||
    websocket.readyState === WebSocket.CLOSING
  ) {
    return;
  }

  websocket.close(code, reason);
}

function startReconnectLoop() {
  if (reconnectTimer !== null) return;

  reconnectTimer = window.setInterval(() => {
    const { websocketEnabled } = store.get(settingsAtom);

    if (!websocketEnabled) {
      clearReconnectTimer();
      return;
    }

    if (retryCount >= MAX_RETRIES) {
      clearReconnectTimer();
      sendWSNotice(
        `WebSocket 尝试重连 ${MAX_RETRIES} 次后仍未成功。`,
        true,
      );
      return;
    }

    if (
      !websocket ||
      websocket.readyState === WebSocket.CLOSED ||
      websocket.readyState === WebSocket.CLOSING
    ) {
      retryCount++;
      setupWebsocket();
    }
  }, RETRY_INTERVAL);
}

function setupWebsocket(force = false) {
  const { websocketEnabled, websocketServer } = store.get(settingsAtom);

  if (!websocketEnabled) {
    clearReconnectTimer();
    safeClose(WEBSOCKET_DISABLED);
    websocket = null;
    return;
  }

  if (!force && websocket && websocket.readyState === WebSocket.OPEN) {
    return;
  }

  if (force) {
    clearReconnectTimer();

    if (websocket) {
      manuallyClosed = true;
      try {
        websocket.close(WEBSOCKET_REATTEMPT, 'forced reconnect');
      } catch {
        /* ignore */
      }
      websocket = null;
    }
  }

  try {
    manuallyClosed = false;
    websocket = new WebSocket(`ws://${websocketServer}`);
  } catch (e: any) {
    if (e.name === 'SyntaxError') {
      sendWSNotice(
        `创建 WebSocket 连接失败：地址无效！请按提示格式填写，例如：<code>localhost:1234</code>`,
        true,
      );
      return;
    }
    sendWSNotice(`创建 WebSocket 连接失败：${e.name} - ${e.message}`);
    startReconnectLoop();
    return;
  }

  websocket.addEventListener('open', () => {
    clearReconnectTimer();
    sendWSNotice('WebSocket 已连接！', true);
    Byond.sendMessage('requestMetadata'); // let's be nice and request metadata
    retryCount = 0;
  });

  websocket.addEventListener('message', (event) => {
    if (event.data === 'requestMetadata') {
      Byond.sendMessage('requestMetadata');
    }
  });

  websocket.addEventListener('close', (ev) => {
    websocket = null;

    if (manuallyClosed || ev.code === WEBSOCKET_DISABLED) return;

    sendWSNotice(
      `WebSocket 已断开！代码：${ev.code}；原因：${ev.reason || '未提供'}`,
      true,
    );

    startReconnectLoop();
  });

  websocket.addEventListener('error', (ev) => {
    logger.error('got websocket error', ev);
    safeClose(WEBSOCKET_REATTEMPT, 'got error from server');
  });
}

// Initial connect
setupWebsocket();

export function wsUpdate(enabled: boolean): void {
  if (enabled) {
    setupWebsocket();
    return;
  }

  manuallyClosed = true;
  clearReconnectTimer();
  safeClose(WEBSOCKET_DISABLED);
  websocket = null;
}

export function wsReconnect(): void {
  setupWebsocket(true);
  sendWSNotice('正在尝试连接 WebSocket……', true);
}

export function wsDisconnect(): void {
  manuallyClosed = true;
  clearReconnectTimer();
  safeClose(WEBSOCKET_DISABLED);
  websocket = null;
  retryCount = 0;
  sendWSNotice('已强制断开 WebSocket。（重试次数已重置）', true);
}

export function wsSend(msg: Record<string, any>): void {
  if (websocket?.readyState === WebSocket.OPEN) {
    websocket.send(JSON.stringify(msg));
  }
}
